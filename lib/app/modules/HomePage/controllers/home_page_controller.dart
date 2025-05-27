import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:toko_roti/app/routes/app_pages.dart';

class HomePageController extends GetxController {
  RxBool isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void logout() async {
    try {
      await auth.signOut();
      Get.offAllNamed(Routes.LOGIN_PAGE);
      Get.snackbar("BERHASIL", "Berhasil Logout");
    } catch (e) {
      Get.snackbar("GAGAL", "Terjadi Kesalahan Saat Logout, ${e}");
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getBread() async* {
    yield* await firestore.collection("breads").snapshots();
  }
}
