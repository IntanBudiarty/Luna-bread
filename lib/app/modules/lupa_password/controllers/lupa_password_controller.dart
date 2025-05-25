import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LupaPasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Variabel untuk menyimpan inputan email
  var email = ''.obs;

  // Fungsi untuk mengirimkan link reset password ke email
  Future<void> resetPassword() async {
    try {
      // Pastikan email tidak kosong
      if (email.value.isEmpty) {
        Get.snackbar("Error", "Email tidak boleh kosong.");
        return;
      }

      // Mengirimkan link reset password ke email
      await _auth.sendPasswordResetEmail(email: email.value);

      // Tampilkan snackbar berhasil
      Get.snackbar(
        "Link Reset Password",
        "Link reset password telah dikirim ke email Anda.",
      );

      // Kembali ke halaman login setelah sukses reset
      Get.offAllNamed('/login-page'); // Menavigasi ke halaman login
    } catch (e) {
      Get.snackbar("Gagal Mengirim Link Reset", e.toString());
    }
  }
}
