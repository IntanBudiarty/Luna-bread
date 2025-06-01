import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  final userData = <String, dynamic>{}.obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    fetchUserData();
    super.onInit();
  }

  // Mengambil data pengguna dari Firestore
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
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal memuat data pengguna");
    } finally {
      isLoading.value = false;
    }
  }

  // Fungsi untuk logout
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed('/login-page');
    } catch (e) {
      Get.snackbar("Error", "Gagal logout");
    }
  }

  // Fungsi untuk menambahkan alamat baru
  Future<void> addAddress(String newAddress) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Tambahkan alamat ke daftar alamat pengguna
        final List addresses = userData['addresses'] ?? [];
        addresses.add({
          'address': newAddress,
          'isDefault': false, // Menandai alamat baru bukan default
        });

        // Update Firestore dengan alamat baru
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'addresses': addresses});

        // Update data lokal
        userData['addresses'] = addresses;
      } catch (e) {
        Get.snackbar("Error", "Gagal menambahkan alamat");
      }
    }
  }

  // Fungsi untuk mengganti alamat default
  Future<void> setDefaultAddress(int index) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        List addresses = userData['addresses'] ?? [];

        // Set alamat default berdasarkan index
        for (var addr in addresses) {
          addr['isDefault'] = false; // Reset semua alamat sebagai bukan default
        }

        // Menandai alamat yang dipilih sebagai default
        addresses[index]['isDefault'] = true;

        // Update Firestore dengan alamat default baru
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'addresses': addresses});

        // Update data lokal
        userData['addresses'] = addresses;
      } catch (e) {
        Get.snackbar("Error", "Gagal mengganti alamat default");
      }
    }
  }
}
