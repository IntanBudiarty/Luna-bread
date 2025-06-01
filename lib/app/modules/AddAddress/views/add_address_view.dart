import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toko_roti/app/modules/AddAddress/controllers/add_address_controller.dart';


class AddAddressView extends StatelessWidget {
  final AddAddressController controller = Get.put(AddAddressController());

  AddAddressView({super.key});

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
              controller: controller.addressController,
              decoration: const InputDecoration(
                labelText: 'Alamat',
                border: OutlineInputBorder(),
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
                        : const Text('Simpan Alamat'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
