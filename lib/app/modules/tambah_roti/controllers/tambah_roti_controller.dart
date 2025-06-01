import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TambahRotiController extends GetxController {
  RxBool isLoading = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  RxString selectedCategory = ''.obs;

  TextEditingController imageC = TextEditingController();
  TextEditingController breadC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();

  void addBread() async {
    if (imageC.text.isNotEmpty &&
        breadC.text.isNotEmpty &&
        priceC.text.isNotEmpty &&
        descriptionC.text.isNotEmpty) {
      isLoading == true;
      try {
        await firestore.collection("breads").add({
          "image_url": imageC.text,
          "bread": breadC.text,
          "price": priceC.text,
          "description": descriptionC.text,
          "category": selectedCategory.value,
          "createdAt": DateTime.now().toIso8601String(),
        });
        isLoading == false;
        Get.back();
        Get.snackbar("BERHASIL", "Data Berhasil Di Tambah");
      } catch (e) {
        isLoading == false;
        Get.snackbar("GAGAL", "Data Gagal Di Tambah ${e}");
      }
    } else {
      isLoading == false;
      Get.snackbar("GAGAL", "Semua Data Harus Di Isi");
    }
  }
}
