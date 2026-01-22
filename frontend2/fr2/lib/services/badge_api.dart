import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class BadgeResult {
  final bool success;
  final String? error;
  final int? requestId;
  final String? status;
  final String? badgeUrl;

  const BadgeResult({
    required this.success,
    this.error,
    this.requestId,
    this.status,
    this.badgeUrl,
  });
}

class BadgeApi {
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

  static Future<BadgeResult> createBadge({
    required int userId,
    required Map<String, dynamic> modifiers,
  }) async {
    final response = await http.post(
      _endpoint('/api/badges/'),
      headers: const {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'user_id': userId,
        'modifiers': modifiers,
      }),
    );

    if (response.statusCode == 201) {
      final payload = jsonDecode(response.body) as Map<String, dynamic>;
      return BadgeResult(
        success: true,
        requestId: payload['request_id'] as int?,
        status: payload['status'] as String?,
        badgeUrl: payload['badge_url'] as String?,
      );
    }

    return BadgeResult(
      success: false,
      error: 'Failed to create badge: ${response.statusCode}',
    );
  }

  static Future<BadgeResult> checkStatus({required int requestId}) async {
    final response = await http.get(
      _endpoint('/api/badges/$requestId/status/'),
    );

    if (response.statusCode == 200) {
      final payload = jsonDecode(response.body) as Map<String, dynamic>;
      return BadgeResult(
        success: true,
        status: payload['status'] as String?,
        badgeUrl: payload['badge_url'] as String?,
      );
    }

    return BadgeResult(
      success: false,
      error: 'Failed to check status: ${response.statusCode}',
    );
  }
}
