import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class EditAccountController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String userId;

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController();
  final addressController = TextEditingController();

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final user = _auth.currentUser;
    if (user != null) {
      userId = user.uid;
      fetchUserData();
    } else {
      Get.snackbar('Error', 'User belum login');
    }
  }

  void fetchUserData() async {
    try {
      isLoading.value = true;
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        final data = doc.data()!;
        fullNameController.text = data['fullName'] ?? '';
        emailController.text = data['email'] ?? '';
        phoneController.text = data['phone'] ?? '';
        ageController.text = data['age']?.toString() ?? '';
        addressController.text = data['address'] ?? '';
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void saveChanges() async {
    try {
      isLoading.value = true;
      await _firestore.collection('users').doc(userId).update({
        'fullName': fullNameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'age': int.tryParse(ageController.text) ?? 0,
        'address': addressController.text,
      });
      Get.back(); // kembali ke halaman sebelumnya
      Get.snackbar('Berhasil', 'Profil berhasil diperbarui');
    } catch (e) {
      Get.snackbar('Error', 'Gagal menyimpan: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    ageController.dispose();
    addressController.dispose();
    super.onClose();
  }
}
