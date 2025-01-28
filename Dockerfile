# Stage 1: Build with specific Flutter version
FROM flutter:3.27.3-web AS build

WORKDIR /app

# Enable web and get dependencies first for cache optimization
RUN flutter config --enable-web
COPY pubspec.yaml .
RUN flutter pub get

# Copy remaining source files and build
COPY . .
RUN flutter build web --release -v

# Stage 2: Serve with Nginx
FROM nginx:1.25.3-alpine

# Copy build artifacts
COPY --from=build /app/build/web /usr/share/nginx/html

# Create optimized Nginx configuration
RUN echo "server {" > /etc/nginx/conf.d/default.conf && \
    echo "    listen 80;" >> /etc/nginx/conf.d/default.conf && \
    echo "    server_name _;" >> /etc/nginx/conf.d/default.conf && \
    echo "    root /usr/share/nginx/html;" >> /etc/nginx/conf.d/default.conf && \
    echo "    index index.html;" >> /etc/nginx/conf.d/default.conf && \
    echo "    location / {" >> /etc/nginx/conf.d/default.conf && \
    echo "        try_files \$uri \$uri/ /index.html;" >> /etc/nginx/conf.d/default.conf && \
    echo "        add_header Cache-Control 'no-store, no-cache, must-revalidate, proxy-revalidate';" >> /etc/nginx/conf.d/default.conf && \
    echo "        expires 0;" >> /etc/nginx/conf.d/default.conf && \
    echo "    }" >> /etc/nginx/conf.d/default.conf && \
    echo "    error_page 500 502 503 504 /50x.html;" >> /etc/nginx/conf.d/default.conf && \
    echo "    location = /50x.html { root /usr/share/nginx/html; }" >> /etc/nginx/conf.d/default.conf && \
    echo "}" >> /etc/nginx/conf.d/default.conf

# Security headers and permissions
RUN chmod -R 755 /usr/share/nginx/html && \
    chown -R nginx:nginx /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]