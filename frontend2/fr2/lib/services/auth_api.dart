import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthResult {
  final bool success;
  final String? error;
  final Map<String, dynamic>? user;

  const AuthResult({required this.success, this.error, this.user});
}

class AuthApi {
  static Map<String, dynamic>? currentUser;

  static String get _baseUrl {
    if (kIsWeb) {
      return const String.fromEnvironment(
        'API_BASE_URL',
        defaultValue: 'http://localhost:8000',
      );
    }

    return const String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'http://10.0.2.2:8000',
    );
  }

  static Uri _endpoint(String path) => Uri.parse('$_baseUrl$path');

  static Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      _endpoint('/api/auth/login/'),
      headers: const {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final payload = jsonDecode(response.body) as Map<String, dynamic>;
      currentUser = payload['user'] as Map<String, dynamic>?;
      return AuthResult(
        success: true,
        user: currentUser,
      );
    }

    String? errorMessage;
    try {
      final payload = jsonDecode(response.body) as Map<String, dynamic>;
      errorMessage = payload['error']?.toString();
    } catch (_) {
      errorMessage = 'Login failed. Please try again.';
    }

    return AuthResult(success: false, error: errorMessage);
  }

  static Future<AuthResult> signup({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      _endpoint('/api/auth/signup/'),
      headers: const {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      final payload = jsonDecode(response.body) as Map<String, dynamic>;
      currentUser = payload['user'] as Map<String, dynamic>?;
      return AuthResult(
        success: true,
        user: currentUser,
      );
    }

    String? errorMessage;
    try {
      final payload = jsonDecode(response.body) as Map<String, dynamic>;
      errorMessage = payload['error']?.toString();
    } catch (_) {
      errorMessage = 'Signup failed. Please try again.';
    }

    return AuthResult(success: false, error: errorMessage);
  }
}
