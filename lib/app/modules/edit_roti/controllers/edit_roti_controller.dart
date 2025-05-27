import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EditRotiController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController imageC = TextEditingController();
  TextEditingController breadC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();

  late DocumentSnapshot<Map<String, dynamic>> dataRoti;

  @override
  void onInit() {
    super.onInit();
    dataRoti = Get.arguments; // Ambil data dari argumen Get.toNamed

    // Isi form dengan data lama
    imageC.text = dataRoti['image_url'] ?? '';
    breadC.text = dataRoti['bread'] ?? '';
    priceC.text = dataRoti['price']?.toString() ?? '';
    descriptionC.text = dataRoti['description'] ?? '';
  }

  Future<void> updateRoti() async {
    isLoading.value = true;
    try {
      await FirebaseFirestore.instance
          .collection("breads")
          .doc(dataRoti.id)
          .update({
            "image_url": imageC.text,
            "bread": breadC.text,
            "price": int.tryParse(priceC.text) ?? 0,
            "description": descriptionC.text,
          });
      Get.back(); // Kembali ke halaman sebelumnya
      Get.snackbar("Sukses", "Data roti berhasil diperbarui");
    } catch (e) {
      Get.snackbar("Error", "Gagal memperbarui data");
    } finally {
      isLoading.value = false;
    }
  }
}
