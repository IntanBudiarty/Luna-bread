import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RegisterPageController extends GetxController {
  // Text controllers untuk semua input
  var fullNameController = TextEditingController();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  var ageController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();

  // Loading
  var isLoading = false.obs;

  // Fungsi untuk register
  Future<void> register() async {
    try {
      isLoading.value = true;

      // Validasi sederhana
      if (fullNameController.text.isEmpty ||
          emailController.text.isEmpty ||
          passController.text.isEmpty) {
        Get.snackbar("Error", "Harap isi semua data penting");
        return;
      }

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );
      Get.offAllNamed('/login-page');
    } catch (e) {
      // Registrasi gagal -> tampilkan animasi error
      await Get.dialog(
        Dialog(
          backgroundColor: Colors.transparent,
          child: Lottie.asset('assets/lottie/error.json', repeat: false),
        ),
      );

      Get.snackbar(
        "Pendaftaran Gagal",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
