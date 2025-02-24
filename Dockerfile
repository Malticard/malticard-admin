# Stage 1: Build the Flutter web app
FROM ubuntu:22.04 AS builder

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    libglu1-mesa \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set noninteractive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install Flutter with specific version
RUN git clone https://github.com/flutter/flutter.git -b 3.27.3 /flutter
ENV PATH="/flutter/bin:${PATH}"

# Set up Flutter
RUN flutter doctor
RUN flutter config --enable-web

# Verify Flutter and Dart versions
RUN flutter --version

# Copy the Flutter project
WORKDIR /app
COPY . .

# Build the web app
RUN flutter pub get
RUN flutter build web --release

# Stage 2: Deploy with Nginx
FROM nginx:alpine

# Copy the built web app from the builder stage
COPY --from=builder /app/build/web /usr/share/nginx/html

# Copy custom nginx config if needed
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]