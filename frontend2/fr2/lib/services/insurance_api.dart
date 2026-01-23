import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'auth_api.dart';

class InsuranceApi {
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

  static Future<List<dynamic>> getMyPolicies() async {
    final uri = _endpoint('/api/insurance/mine/');
    
    // In a real app we'd attach headers
    // final headers = {'Authorization': 'Bearer ...'}; 
    
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        if (kDebugMode) {
          print('Failed to load policies: ${response.statusCode} ${response.body}');
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching policies: $e');
      }
      return [];
    }
  }

  static Future<bool> deletePolicy({required int policyId}) async {
    final response = await http.delete(_endpoint('/api/insurance/$policyId/'));
    return response.statusCode == 204;
  }
}
