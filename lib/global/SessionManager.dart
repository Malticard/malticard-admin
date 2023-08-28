import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static final SessionManager _singleton = SessionManager._internal();

  factory SessionManager() {
    return _singleton;
  }

  SessionManager._internal();

  // Key for storing the JWT token
  static const String _tokenKey = 'admin_jwt_token';

  // Store JWT token
  Future<void> storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Retrieve JWT token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Check if the token is expired
  Future<bool> isTokenExpired() async {
    final token = await getToken();
    if (token == null) {
      return true; // Token not found, consider it expired.
    }

    final decodedToken = json.decode(
      ascii.decode(
        base64.decode(
          base64.normalize(token.split('.')[1]),
        ),
      ),
    );

    final expiry =
        DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
    bool isExpired = DateTime.now().isAfter(expiry);
    return isExpired;
  }

  // Clear JWT token
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}
