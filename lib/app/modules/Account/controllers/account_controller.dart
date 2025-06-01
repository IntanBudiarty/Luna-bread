import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var isLoading = false.obs;
  var userData = {}.obs;
  var anotherAddress = <Map>[].obs;

  late String userId;

  @override
  void onInit() {
    super.onInit();
    final user = _auth.currentUser;
    if (user != null) {
      userId = user.uid;
      debugPrint('Login sebagai UID: $userId');
      fetchUserData();
    } else {
      userId = '';
      Get.snackbar('Error', 'User belum login');
    }
  }

  Future<void> fetchUserData() async {
    final user = _auth.currentUser;
    if (user == null) {
      Get.snackbar('Error', 'User belum login');
      return;
    }

    userId = user.uid;
    debugPrint('Fetching data for user: $userId');

    try {
      isLoading.value = true;
      userData.clear();
      anotherAddress.clear();

      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        userData.value = userDoc.data() as Map<String, dynamic>;
        debugPrint('Data user ditemukan: ${userData['fullName']}');
      } else {
        debugPrint('Dokumen user tidak ditemukan di Firestore!');
      }

      QuerySnapshot addrSnapshot =
          await _firestore
              .collection('users')
              .doc(userId)
              .collection(
                'anotherAddress',
              ) // PENTING! Konsisten dengan Firestore
              .orderBy('createdAt', descending: true)
              .get();

      anotherAddress.value =
          addrSnapshot.docs
              .map((doc) {
                var data = doc.data() as Map<String, dynamic>;
                if (data['address'] != null && data['createdAt'] != null) {
                  return {
                    'id': doc.id,
                    'address': data['address'],
                    'createdAt': data['createdAt'],
                  };
                }
                return null;
              })
              .where((element) => element != null)
              .cast<Map<String, dynamic>>()
              .toList();

      debugPrint('Jumlah alamat tambahan: ${anotherAddress.length}');
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil data: $e');
      debugPrint('Error saat fetch user: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteAnotherAddress(String addressId) async {
    if (userId.isEmpty) return;

    try {
      isLoading.value = true;
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('anotherAddress') // FIXED: konsisten!
          .doc(addressId)
          .delete();

      Get.snackbar('BERHASIL', 'Alamat berhasil dihapus');
      await fetchUserData();
    } catch (e) {
      Get.snackbar('GAGAL', 'Gagal menghapus alamat: $e');
      debugPrint('Error saat delete address: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void logout() async {
    await _auth.signOut();
    Get.offAllNamed('/login');
  }
}
