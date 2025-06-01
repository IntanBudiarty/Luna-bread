import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class RegisterPageController extends GetxController {
  // Text controllers
  final fullNameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  final isLoading = false.obs;

  Future<void> register() async {
    try {
      isLoading.value = true;

      // Validasi
      if (fullNameController.text.isEmpty ||
          emailController.text.isEmpty ||
          passController.text.isEmpty) {
        Get.snackbar("Error", "Harap isi semua data penting");
        return;
      }

      // 1. Buat akun Firebase Auth
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passController.text,
          );

      // 2. Simpan data tambahan ke Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
            'uid': userCredential.user!.uid,
            'fullName': fullNameController.text,
            'address': addressController.text,
            'phone': phoneController.text,
            'age': ageController.text,
            'email': emailController.text,
            'createdAt': FieldValue.serverTimestamp(),
          });

      // 3. Kirim email verifikasi
      await userCredential.user!.sendEmailVerification();

      Get.snackbar(
        "Berhasil",
        "Pendaftaran berhasil! Silakan cek email Anda",
        snackPosition: SnackPosition.BOTTOM,
      );

      Get.offAllNamed('/login-page');
    } catch (e) {
      await Get.dialog(
        Dialog(
          backgroundColor: Colors.transparent,
          child: Lottie.asset('assets/lottie/error.json', repeat: false),
        ),
      );
      Get.snackbar(
        "Gagal",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
