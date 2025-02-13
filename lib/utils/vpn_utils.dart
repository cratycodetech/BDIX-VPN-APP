import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:flutter_screenutil/flutter_screenutil.dart';

class VpnUtils {
  // Country-based Offset mapping
  static final Map<String, Offset> _countryOffsets = {
    'USA': Offset(-120.w, -80.h),
    'India': Offset(70.w, -55.h),
    'Finland': Offset(10.w, -115.h),
    'Singapore': Offset(90.w, -40.h),
  };

  // Country-based Image mapping
  static final Map<String, String> _countryImages = {
    'USA': 'assets/images/usa_flag.png',
    'India': 'assets/images/india_flag.png',
    'Finland': 'assets/images/finland_flag.png',
    'Singapore': 'assets/images/singapore_flag.png',
  };

  // Function to get Offset dynamically
  static Offset getCountryOffset(String country) {
    return _countryOffsets[country] ?? Offset(70.w, -55.h); // Default offset
  }

  // Function to get Image dynamically
  static String getCountryImage(String country) {
    return _countryImages[country] ?? 'assets/images/india_flag.png'; // Default image
  }

  static Future<String> getPublicIP() async {
    try {
      final response =
      await http.get(Uri.parse('https://api64.ipify.org?format=json'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['ip'] ?? "Unknown";
      }
    } catch (error) {
      print('Error retrieving public IP: $error');
    }
    return "Unknown";
  }
}
