import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:toko_roti/app/routes/app_pages.dart';

class HomePageController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  void logout() async {
    try {
      await auth.signOut();
      Get.offAllNamed(Routes.LOGIN_PAGE);
    } catch (e) {
      Get.snackbar("GAGAL", "Terjadi Kesalahan Saat Logout, ${e}");
    }
  }
}
