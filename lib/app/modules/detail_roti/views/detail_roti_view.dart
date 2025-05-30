import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailRotiView extends StatelessWidget {
  const DetailRotiView({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F1EE),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Color(0xFFA67C52),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Get.back(),
                  ),
                ),
                Positioned.fill(
                  top: 50,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        const Text(
                          "Details",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              data['image_url'],
                              height: 250,
                              width: 250,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image, size: 80),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['bread'],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _infoBox('Stock', '${Random().nextInt(255)}'),
                          _infoBox('Weight', '${Random().nextInt(255)}gr'),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // _quantityPicker(),
                          Text(
                            "Rp ${data['price']}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          const Text(
                            "x pcs",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: () {
                          // Tambahkan ke keranjang logika
                          Get.snackbar(
                            "Berhasil",
                            "Roti ditambahkan ke keranjang",
                          );
                        },
                        child: const Text(
                          "Buy",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        data['description'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
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

  // Widget _quantityPicker() {
  //   return Row(
  //     children: [
  //       Container(
  //         decoration: BoxDecoration(
  //           border: Border.all(color: Colors.brown),
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         child: const Icon(Icons.remove, size: 20, color: Colors.brown),
  //       ),
  //       const SizedBox(width: 10),
  //       const Text("0", style: TextStyle(fontSize: 16)),
  //       const SizedBox(width: 10),
  //       Container(
  //         decoration: BoxDecoration(
  //           border: Border.all(color: Colors.brown),
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         child: const Icon(Icons.add, size: 20, color: Colors.brown),
  //       ),
  //     ],
  //   );
  // }
}
