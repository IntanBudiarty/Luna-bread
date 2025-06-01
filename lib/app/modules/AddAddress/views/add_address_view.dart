import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toko_roti/app/modules/AddAddress/controllers/add_address_controller.dart';


class AddAddressView extends StatelessWidget {
  final AddAddressController controller = Get.put(AddAddressController());

  AddAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBDED4),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Tambah Alamat',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Masukkan Alamat Baru',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.brown[700],
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller.addressController,
              decoration: const InputDecoration(
                labelText: 'Alamat',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => ElevatedButton(
                onPressed:
                    controller.isLoading.value
                        ? null
                        : () => controller.saveAddress(),
                child:
                    controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : const Text(
                          'Simpan Alamat',
                          style: TextStyle(color: Colors.white),
                        ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
