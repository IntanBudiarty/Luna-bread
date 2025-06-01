import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  final userData = <String, dynamic>{}.obs;
  final isLoading = true.obs;
  final anotherAddresses = <Map<String, dynamic>>[].obs; // ← Tambah ini

  @override
  void onInit() {
    fetchUserData();
    super.onInit();
  }

  Future<void> fetchUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();

        if (doc.exists) {
          userData.value = doc.data()!;
          await fetchAnotherAddresses(user.uid); // ← Panggil fungsi ini juga
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal memuat data pengguna");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAnotherAddresses(String uid) async {
    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .collection('anotherAddress') // ← Subcollection
              .get();

      anotherAddresses.value = snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      Get.snackbar("Error", "Gagal memuat alamat lainnya");
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed('/login-page');
    } catch (e) {
      Get.snackbar("Error", "Gagal logout");
    }
  }
}

