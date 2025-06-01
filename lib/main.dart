import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:toko_roti/app/modules/keranjang/controllers/keranjang_controller.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() async {
  Get.put(KeranjangController());
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Inisialisasi Firebase dengan error handling
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).then((_) => print('Firebase initialized successfully'));

    // Registrasi controller dengan pengecekan
    Get.put(
      KeranjangController(),
      permanent: true,
    ); // Tambahkan permanent: true

    runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Luna Bread",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        // Tambahkan fallback untuk route tidak ditemukan
        unknownRoute: GetPage(
          name: '/not-found',
          page:
              () => const Scaffold(
                body: Center(child: Text('Halaman tidak ditemukan')),
              ),
        ),
      ),
    );
  } catch (e) {
    // Fallback jika inisialisasi gagal
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Error: $e\nAplikasi tidak dapat diinisialisasi'),
          ),
        ),
      ),
    );
  }
}
