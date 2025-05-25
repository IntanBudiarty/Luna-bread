import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginPageController extends GetxController {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var isLoading = false.obs;

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passController.text.trim();

    // Validasi input kosong
    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog("Login Gagal", "Email dan password tidak boleh kosong.");
      return;
    }

    try {
      isLoading.value = true;

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Jika login berhasil
      Get.offAllNamed('/home-page');
    } catch (e) {
      _showErrorDialog(
        "Login Gagal",
        e.toString().replaceAll('firebase_auth/', ''),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _showErrorDialog(String title, String message) {
    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 150,
              child: Lottie.asset('assets/lottie/error.json'),
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => Get.back(),
              child: const Text("Tutup"),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}
