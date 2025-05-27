import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:toko_roti/app/routes/app_pages.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background layer
          Positioned.fill(
            child: Container(
              color: const Color(0xFFE7D6C8), // background utama
            ),
          ),
          // Corner Background Top Left
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/background_corner_1.png',
              width: MediaQuery.of(context).size.width,
            ),
          ),
          // Corner Background Bottom Right
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'assets/background_corner_2.png',
              width: MediaQuery.of(context).size.width,
            ),
          ),
          // Content
          Positioned.fill(
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  // Logo dan Nama
                  Column(
                    children: [
                      Image.asset('assets/logo.png', width: 60),
                      const SizedBox(height: 8),
                      const Text(
                        'LUNA\nBREAD',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: Color(0xFF7A5F3C),
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Gambar Roti
                  Expanded(
                    child: Image.asset(
                      'assets/bread.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  // Tagline
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Quick, Fresh, Tasty &\nDelicious Bread",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Warm. Fresh. Ready in a Flash!",
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                  // Button Get Started
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offNamed(Routes.LOGIN_PAGE);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF4EBD0),
                        foregroundColor: Colors.brown[800],
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Get Started',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
