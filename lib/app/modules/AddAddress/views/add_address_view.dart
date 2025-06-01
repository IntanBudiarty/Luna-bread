// add_address_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddressView extends StatelessWidget {
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Alamat')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Masukkan Alamat Baru',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: 'Alamat',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Simpan alamat baru dan navigasi kembali ke halaman akun
                // Anda bisa menambahkan logika penyimpanan alamat di sini
                Get.back();
              },
              child: const Text('Simpan Alamat'),
            ),
          ],
        ),
      ),
    );
  }
}
