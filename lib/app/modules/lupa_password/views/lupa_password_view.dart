import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controllers/lupa_password_controller.dart';

class LupaPasswordView extends GetView<LupaPasswordController> {
  @override
  Widget build(BuildContext context) {
    // Menggunakan controller LupaPasswordController
    final LupaPasswordController controller = Get.put(LupaPasswordController());

    return Scaffold(
      appBar: AppBar(title: Text("Reset Password")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            SizedBox(
              height: 150,
              child: Lottie.asset(
                'assets/lottie/lupa-password.json', // Pastikan animasi Lottie ada di folder assets
                fit: BoxFit.cover,
              ),
            ),
            // Form Inputan Email
            TextField(
              onChanged: (value) => controller.email.value = value,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Masukkan Email',
              ),
            ),
            const Spacer(),
            // Tombol untuk mengirimkan link reset password
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.resetPassword(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Warna biru
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Radius sudut
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                  ), // Padding vertikal agar tombol lebih tinggi
                ),
                child: Text(
                  "Reset Password",
                  style: TextStyle(
                    fontSize: 16, // Ukuran font
                    color: Colors.white, // Warna teks putih
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
