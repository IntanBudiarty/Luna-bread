import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toko_roti/app/routes/app_pages.dart';
import '../controllers/account_controller.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountController());

    return Scaffold(
      backgroundColor: const Color(0xFFEBDED4),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Akun Saya', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.brown,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.fetchUserData,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.userData.isEmpty) {
          return const Center(child: Text('Data pengguna tidak ditemukan'));
        }

        return Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 160),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileHeader(controller),
                  const SizedBox(height: 32),
                  _buildInfoSection(controller),
                  const SizedBox(height: 12),
                  _buildAddressSection(controller),
                  const SizedBox(height: 12),
                  _buildAnotherAddressSection(controller),
                  const SizedBox(height: 32),
                ],
              ),
            ),

            // Bottom Buttons
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(
                children: [
                  // View Orders Button
                  ElevatedButton(
                    onPressed: () => Get.toNamed(Routes.ORDERS),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[700],
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_bag, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Lihat Pesanan Saya',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Edit Profile Button
                  ElevatedButton(
                    onPressed: () => Get.toNamed(Routes.EDIT_ACCOUNT),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.edit, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Edit Profil',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildProfileHeader(AccountController controller) {
    return Center(
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey,
            backgroundImage: AssetImage('assets/images/default_profile.png'),
          ),
          const SizedBox(height: 16),
          Text(
            controller.userData['fullName'] ?? 'Nama tidak tersedia',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(AccountController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informasi Akun',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        const Divider(),
        _buildInfoRow('Nama Lengkap', controller.userData['fullName'] ?? '-'),
        _buildInfoRow('Email', controller.userData['email'] ?? '-'),
        _buildInfoRow('Nomor HP', controller.userData['phone'] ?? '-'),
        _buildInfoRow('Usia', controller.userData['age']?.toString() ?? '-'),
      ],
    );
  }

  Widget _buildAddressSection(AccountController controller) {
    return Row(
      children: [
        const SizedBox(
          width: 120,
          child: Text('Alamat', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            controller.userData['address'] ?? '-',
            style: const TextStyle(fontSize: 16),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => Get.toNamed('/add-address'),
        ),
      ],
    );
  }

  Widget _buildAnotherAddressSection(AccountController controller) {
    return Obx(() {
      if (controller.anotherAddress.isEmpty) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text('Tidak ada alamat tambahan yang valid'),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Alamat Lainnya',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          const Divider(),
          ...controller.anotherAddress.map((address) {
            final createdAt =
                address['createdAt'] is Timestamp
                    ? (address['createdAt'] as Timestamp)
                        .toDate()
                        .toLocal()
                        .toString()
                    : address['createdAt'].toString();

            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                tileColor: Colors.brown[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                leading: const Icon(Icons.location_on, color: Colors.brown),
                title: Text(address['address'] ?? ''),
                subtitle: Text('Ditambahkan: $createdAt'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.brown),
                  onPressed:
                      () => controller.deleteAnotherAddress(address['id']),
                ),
              ),
            );
          }).toList(),
        ],
      );
    });
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
