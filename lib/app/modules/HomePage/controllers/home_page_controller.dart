import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:toko_roti/app/routes/app_pages.dart';

class HomePageController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // var tabIndex = 0.obs;

  RxString searchQuery = ''.obs;
  late Rx<Stream<QuerySnapshot<Map<String, dynamic>>>> breadStream;

  @override
  void onInit() {
    super.onInit();
    breadStream = Rx(getBreadStream());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getBreadStream() {
    return firestore.collection("breads").snapshots();
  }

  void logout() async {
    try {
      await auth.signOut();
      Get.offAllNamed(Routes.LOGIN_PAGE);
      Get.snackbar("BERHASIL", "Berhasil Logout");
    } catch (e) {
      Get.snackbar("GAGAL", "Terjadi Kesalahan Saat Logout, $e");
    }
  }

  void hapusRoti(String docId) async {
    try {
      await firestore.collection("breads").doc(docId).delete();
      Get.snackbar("Sukses", "Roti berhasil dihapus");
    } catch (e) {
      Get.snackbar("Error", "Gagal menghapus roti: $e");
    }
  }
}
