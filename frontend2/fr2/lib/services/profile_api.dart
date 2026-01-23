import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProfileResult {
  final bool success;
  final String? error;
  final Map<String, dynamic>? profile;

  const ProfileResult({required this.success, this.error, this.profile});
}

class ProfileApi {
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

  static Future<ProfileResult> createProfile({
    required int userId,
    required String firstName,
    required String lastName, // we might need to split full name
    required String dob,
    XFile? photo,
    // Add extra identity fields
    String? nationality,
    String? address,
    String? sex,
    String? cnp,
    String? placeOfBirth,
    bool randomize = false,
    String? description,
  }) async {
    final uri = _endpoint('/api/profile/');
    final request = http.MultipartRequest('POST', uri);

    request.fields['user_id'] = userId.toString();
    request.fields['first_name'] = firstName;
    request.fields['last_name'] = lastName;
    request.fields['date_of_birth'] = dob;
    
    // Optional Identity Fields
    if (nationality != null) request.fields['nationality'] = nationality;
    if (address != null) request.fields['address'] = address;
    if (sex != null) request.fields['sex'] = sex;
    if (cnp != null) request.fields['cnp'] = cnp;
    if (placeOfBirth != null) request.fields['place_of_birth'] = placeOfBirth;
    if (description != null) request.fields['description'] = description;
    
    request.fields['randomize'] = randomize.toString();

    // Default id_code generation is handled by backend if omitted

    if (photo != null) {
      if (kIsWeb) {
         final bytes = await photo.readAsBytes();
         request.files.add(http.MultipartFile.fromBytes(
           'profile_photo',
           bytes,
           filename: photo.name,
         ));
      } else {
        request.files.add(await http.MultipartFile.fromPath(
          'profile_photo',
          photo.path,
        ));
      }
    }

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        final payload = jsonDecode(response.body) as Map<String, dynamic>;
        return ProfileResult(success: true, profile: payload);
      } else {
         return ProfileResult(
          success: false,
          error: 'Create profile failed: ${response.statusCode} ${response.body}',
        );
      }
    } catch (e) {
      return ProfileResult(success: false, error: e.toString());
    }
  }

  static Future<ProfileResult> getProfile({required int userId}) async {
    final response = await http.get(_endpoint('/api/profile/me/?user_id=$userId'));

    if (response.statusCode == 200) {
      final payload = jsonDecode(response.body) as Map<String, dynamic>;
      return ProfileResult(success: true, profile: payload);
    }
    return ProfileResult(success: false, error: 'Get profile failed: ${response.statusCode}');
  }

  static Future<List<Map<String, dynamic>>> getMyProfiles({required int userId}) async {
    final response = await http.get(_endpoint('/api/profile/mine/?user_id=$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> list = jsonDecode(response.body);
      return list.cast<Map<String, dynamic>>();
    }
    return [];
  }

  static Future<ProfileResult> updateProfile({
    required int profileId,
    String? firstName,
    String? lastName,
    String? dob,
    XFile? photo,
  }) async {
    final uri = _endpoint('/api/profile/$profileId/');
    
    // Using MultipartRequest to support potential photo update
    final request = http.MultipartRequest('PATCH', uri);

    if (firstName != null) request.fields['first_name'] = firstName;
    if (lastName != null) request.fields['last_name'] = lastName;
    if (dob != null) request.fields['date_of_birth'] = dob;

    if (photo != null) {
      if (kIsWeb) {
         final bytes = await photo.readAsBytes();
         request.files.add(http.MultipartFile.fromBytes(
           'profile_photo',
           bytes,
           filename: photo.name,
         ));
      } else {
        request.files.add(await http.MultipartFile.fromPath(
          'profile_photo',
          photo.path,
        ));
      }
    }

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final payload = jsonDecode(response.body) as Map<String, dynamic>;
        return ProfileResult(success: true, profile: payload);
      } else {
         return ProfileResult(
          success: false,
          error: 'Update profile failed: ${response.statusCode} ${response.body}',
        );
      }
    } catch (e) {
      return ProfileResult(success: false, error: e.toString());
    }
  }

  static Future<bool> deleteProfile({required int profileId}) async {
    final response = await http.delete(_endpoint('/api/profile/$profileId/'));
    return response.statusCode == 204;
  }
}
