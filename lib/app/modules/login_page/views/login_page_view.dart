import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toko_roti/app/routes/app_pages.dart';

import '../controllers/login_page_controller.dart';

class LoginPageView extends StatelessWidget {
  const LoginPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginPageController controller = Get.put(LoginPageController());

    return Scaffold(
      backgroundColor: const Color(0xFFEBDED4),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/logo.png", height: 120),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.brown.withOpacity(0.1),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Masuk ke Akun Anda',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        controller: controller.emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.brown.withOpacity(0.6),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.brown.withOpacity(0.4),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.brown),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 16,
                          ),
                          labelStyle: const TextStyle(color: Colors.brown),
                        ),
                        style: const TextStyle(color: Colors.brown),
                        cursorColor: Colors.brown,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: controller.passController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.brown.withOpacity(0.6),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.brown.withOpacity(0.4),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.brown),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 16,
                          ),
                          labelStyle: const TextStyle(color: Colors.brown),
                        ),
                        style: const TextStyle(color: Colors.brown),
                        cursorColor: Colors.brown,
                      ),
                      // Tombol Lupa Password - Pastikan ini ada di dalam Column
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Tambahkan navigasi ke halaman lupa password
                            Get.toNamed(
                              Routes.LUPA_PASSWORD,
                            ); // Pastikan route ini sudah didefinisikan
                          },
                          child: const Text(
                            'Lupa Password?',
                            style: TextStyle(
                              color: Colors.brown,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Obx(() {
                        return ElevatedButton(
                          onPressed:
                              controller.isLoading.value
                                  ? null
                                  : controller.login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF4E9CD),
                            foregroundColor: Colors.brown,
                            minimumSize: const Size(double.infinity, 52),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 2,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child:
                              controller.isLoading.value
                                  ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.brown,
                                      strokeWidth: 3,
                                    ),
                                  )
                                  : const Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                        );
                      }),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Belum punya akun?",
                            style: TextStyle(color: Colors.brown),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.REGISTER_PAGE);
                            },
                            child: const Text(
                              "Daftar",
                              style: TextStyle(
                                color: Colors.brown,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
