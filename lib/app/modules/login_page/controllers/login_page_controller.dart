import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        // Menyimpan userId setelah login berhasil
        await saveUserId(FirebaseAuth.instance.currentUser!.uid);

        // Jika login berhasil
        Get.offAllNamed('/home-page');
      } else {
        Get.defaultDialog(
          title:
              "Email Belum Terverifikasi, Apakah Anda Ingin Verifikasi Ulang?",
          actions: [
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Get.back();
              },
              child: Text("Tidak", style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                FirebaseAuth.instance.currentUser!.sendEmailVerification();
                Get.back();
              },
              child: Text("Ya", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      }
    } catch (e) {
      _showErrorDialog(
        "Login Gagal",
        e.toString().replaceAll('firebase_auth/', ''),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Fungsi untuk menyimpan userId ke SharedPreferences
  Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId); // Menyimpan ID pengguna
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
