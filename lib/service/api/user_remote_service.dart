import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../../models/user.dart';
import '../token_service.dart';

class UserRemoteService {
  final String? baseUrl = dotenv.env['BASE_URL'];
  final TokenService _tokenService = TokenService();

  Future<User> userDetails() async {
    try {
      final token = await _tokenService.getToken();
      final userId = await _tokenService.decodeUserId();
      if (userId == null) {
        throw Exception("Unable to fetch user ID");
      }

      final url = Uri.parse('$baseUrl/api/v1/user/single/$userId');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        return User.fromJson(responseBody);
      } else {
        throw Exception(
            "Failed to fetch user details: ${response.reasonPhrase}");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateEmail({required String email}) async {
    try {
      final token = await _tokenService.getToken();

      if (token == null) {
        throw Exception('No token found');
      }

      final url = Uri.parse('$baseUrl/api/v1/auth/update-email');
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'newEmail': email,
        }),
      );

      if (response.statusCode != 200) {
        final errorResponse = jsonDecode(response.body);
        throw Exception(errorResponse['message'] ?? 'Update failed');
      }
    } catch (e) {
      // Log or handle the error appropriately
      throw Exception('Failed to update email: ${e.toString()}');
    }
  }

  Future<void> updatePassword(
      {required String currentPass, required newPass}) async {
    final token = await _tokenService.getToken();

    if (token == null) {
      throw Exception('No token found');
    }

    final url = Uri.parse('$baseUrl/api/v1/auth/update-pass');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'currentPassword': currentPass,
        'newPassword': newPass,
      }),
    );

    if (response.statusCode != 200) {
      final errorResponse = jsonDecode(response.body);
      throw Exception(errorResponse['message'] ?? 'Update failed');
    }
  }

  Future<String> premiumUserSubscription() async {
      final token = await _tokenService.getToken();

      final url = Uri.parse('$baseUrl/api/v1/premium-user/subscribed-package');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to verify OTP: ${response.body}');
      }
      Map<String, dynamic> data = jsonDecode(response.body);
      String subscriptionType = data['subscriptionType'];
      return subscriptionType;
  }



  Future<void> updateFcmToken({required String fcmToken}) async {
    try {
      final token = await _tokenService.getToken();
      final userId = await _tokenService.decodeUserId();
      if (token == null) {
        throw Exception('No token found');
      }

      final url = Uri.parse('$baseUrl/api/v1/user/update-profile/$userId');
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'fcmToken': fcmToken,
        }),
      );

      if (response.statusCode != 200) {
        final errorResponse = jsonDecode(response.body);
        throw Exception(errorResponse['message'] ?? 'Update failed');
      }
    } catch (e) {
      // Log or handle the error appropriately
      throw Exception('Failed to update fcmToken: ${e.toString()}');
    }
  }
}
