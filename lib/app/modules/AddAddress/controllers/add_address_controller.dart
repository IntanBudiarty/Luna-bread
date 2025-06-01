import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddressController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController addressController = TextEditingController();

  Future<void> saveAddress() async {
    final address = addressController.text.trim();
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Get.snackbar('Error', 'User belum login');
      return;
    }

    if (address.isEmpty) {
      Get.snackbar('Error', 'Alamat tidak boleh kosong');
      return;
    }

    try {
      isLoading.value = true;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('anotherAddress')
          .add({'address': address, 'createdAt': FieldValue.serverTimestamp()});

      Get.back(); // kembali ke halaman sebelumnya
      Get.snackbar("BERHASIL", "Alamat Berhasil Di Tambahkan");
    } catch (e) {
      Get.snackbar('GAGAL', 'Gagal menyimpan alamat: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
