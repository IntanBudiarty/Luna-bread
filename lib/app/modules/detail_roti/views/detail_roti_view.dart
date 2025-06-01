import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toko_roti/app/modules/keranjang/controllers/keranjang_controller.dart';

class DetailRotiView extends StatelessWidget {
  const DetailRotiView({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F1EE),
      body: SafeArea(
        child: Stack(
          children: [
            // Bagian background coklat di atas
            Column(
              children: [
                Container(
                  height: 280,
                  decoration: const BoxDecoration(
                    color: Color(0xFFA67C52),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                ),
              ],
            ),

            // Konten utama
            Positioned.fill(
              top: 0,
              bottom: 70, // Sisakan ruang untuk tombol Buy
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Get.back(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Gambar Produk
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Shadow bayangan di bawah gambar
                        Positioned(
                          bottom: 10,
                          child: Container(
                            width: 180,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 20,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Gambar roti
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            data['image_url'],
                            width: 250,
                            height: 250,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image, size: 100),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Detail Deskripsi
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Nama Roti
                            Text(
                              data['bread'],
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown,
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Info Stock dan Weight
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _infoBox(
                                  'Stock',
                                  '${Random().nextInt(50) + 1}',
                                ),
                                _infoBox(
                                  'Berat',
                                  '${Random().nextInt(400) + 100} gr',
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Harga
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Rp ${data['price']}",
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                                const Text(
                                  "x pcs",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Deskripsi Produk
                            Text(
                              "Deskripsi Produk",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown[700],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              data['description'],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                height: 1.5,
                              ),
                            ),

                            const SizedBox(
                              height: 80,
                            ), // Spasi untuk tombol bawah
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Tombol Buy di bawah layar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    final keranjangController = Get.find<KeranjangController>();
                    final productData = Get.arguments as Map<String, dynamic>;

                    final productWithId = {
                      ...productData,
                      'id':
                          productData['id'] ??
                          'prod_${productData['bread']}_${DateTime.now().millisecondsSinceEpoch}',
                    };

                    keranjangController.tambahProduk(productWithId);

                    Get.snackbar(
                      "Berhasil",
                      "${productData['bread']} ditambahkan ke keranjang",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                      duration: const Duration(seconds: 2),
                    );

                    Get.toNamed('/keranjang');
                  },
                  child: const Text(
                    "Buy",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoBox(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
