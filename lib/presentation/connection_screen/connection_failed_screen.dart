import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ConnectionFailedScreen extends StatefulWidget {
  const ConnectionFailedScreen({super.key});

  @override
  State<ConnectionFailedScreen> createState() => _ConnectionFailedScreenState();
}

class _ConnectionFailedScreenState extends State<ConnectionFailedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 130,
          ),
          Center(
            child: SvgPicture.asset(
              'assets/images/world_image.svg',
              height: 261.46,
              width: 352,
            ),
          ),
          const SizedBox(
            height: 43.54,
          ),
          const Text(
            'Connection Failed',
            style: TextStyle(
                fontSize: 28,
                color: Color(0xFF080E59),
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 18,
          ),
          SizedBox(
            width: 90, // Button width
            height: 36, // Button height
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF1D1D7D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'Try Again',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
