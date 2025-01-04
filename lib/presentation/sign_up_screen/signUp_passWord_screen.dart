import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../../service/api/auth_service.dart';
import '../../utils/validation_utils.dart';


void main() {
  runApp(const signUpPaass());
}

class signUpPaass extends StatelessWidget {
  const signUpPaass({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const SignUp6(),
    );
  }
}

class SignUp6 extends StatefulWidget {
  const SignUp6({super.key});

  @override
  State<SignUp6> createState() => _SignUp6State();
}

class _SignUp6State extends State<SignUp6> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final AuthService _authService = AuthService();
  final String email = Get.arguments['email'] ?? '';

  String? _passwordError;
  String? _confirmPasswordError;

  void _validateAndCreateAccount() async {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    setState(() {
      _passwordError = ValidationUtils.validatePassword(password);
      _confirmPasswordError = ValidationUtils.validateConfirmPassword(password, confirmPassword);
    });

    if (_passwordError == null && _confirmPasswordError == null) {
      try {
        await _authService.signUp(email: email, password: password);
        Get.toNamed(AppRoutes.guestHome);
      } catch (e) {
        Get.snackbar(
          'Error',
          e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            // App Logo
            Center(
              child: Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Password Fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Password Field
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                      suffixIcon: const Icon(Icons.visibility_off, color: Colors.grey),
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(color: Color(0xFFE2DBDA)),
                      ),
                      errorText: _passwordError,
                    ),
                  ),
                  const SizedBox(height: 14),
                  // Confirm Password Field
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                      suffixIcon: const Icon(Icons.visibility_off, color: Colors.grey),
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(color: Color(0xFFE2DBDA)),
                      ),
                      errorText: _confirmPasswordError,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Create Account Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _validateAndCreateAccount,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF393E7A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Create account',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Sign In Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Color(0xFF545454),
                      fontSize: 12,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.signIn);
                    },
                    child: const Text(
                      ' Sign in',
                      style: TextStyle(
                        color: Color(0xFF393E7A),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Privacy Policy Text
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'By creating an account, you agree to our ',
                      style: TextStyle(
                        color: Color(0xFF8A8A8A),
                        fontSize: 10,
                      ),
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        color: Color(0xFFEC8304),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                      ', which outlines how we handle your personal data and browsing information to ensure secure and private access to the VPN service.',
                      style: TextStyle(
                        color: Color(0xFF8A8A8A),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
