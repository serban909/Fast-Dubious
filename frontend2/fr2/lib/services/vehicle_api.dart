import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'auth_api.dart';

class VehicleResult {
  final bool success;
  final String? error;
  final Map<String, dynamic>? data;

  VehicleResult({required this.success, this.error, this.data});
}

class VehicleApi {
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

  static Future<VehicleResult> createVehicle({
    required String registrationNumber,
    required String makeModel,
    required String vin,
    required String enginePower,
    required String seatsMass,
    // Add these if you want to link to a specific user explicitly
    // otherwise backend might rely on session
    String? userCode, 
  }) async {
    final uri = _endpoint('/api/vehicles/');
    
    // Simple logic to try finding a user ID to attach
    // In a real app, AuthApi.currentUser should have the real ID
    String? userIdToUse = userCode; 
    if (userIdToUse == null && AuthApi.currentUser != null) {
        // If we stored the user ID in the auth result, use it.
        // Assuming AuthApi.currentUser['id'] exists or similar
    }

    try {
      final request = http.MultipartRequest('POST', uri);
      
      request.fields['registration_number'] = registrationNumber;
      request.fields['make_model'] = makeModel;
      request.fields['vin'] = vin;
      request.fields['engine_power'] = enginePower;
      request.fields['seats_mass'] = seatsMass;

      // HACK: For now, we need to associate this car with a user profile.
      // Since we don't have global state management fully visible here, 
      // the backend will try to match based on `request.user` if authenticated
      // OR we can pass `user_id_code` if we have it in the form.
      // For this demo, we might rely on the backend finding the "current logged in user's profile"
      
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return VehicleResult(success: true, data: data);
      } else {
        return VehicleResult(
          success: false, 
          error: 'Failed: ${response.statusCode} ${response.body}'
        );
      }
    } catch (e) {
      return VehicleResult(success: false, error: e.toString());
    }
  }
}
