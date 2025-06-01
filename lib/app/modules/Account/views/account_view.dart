import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/account_controller.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Akun Saya'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.fetchUserData(),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: controller.logout,
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

        final anotherAddresses = controller.anotherAddresses;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header dengan foto profil
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                        'assets/images/default_profile.png',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      controller.userData['fullName'] ?? 'Nama tidak tersedia',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Info Akun
              const Text(
                'Informasi Akun',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const Divider(),
              _buildInfoRow('Nama Lengkap', controller.userData['fullName']),
              _buildInfoRow('Email', controller.userData['email']),
              _buildInfoRow('Nomor HP', controller.userData['phone'] ?? '-'),
              _buildInfoRow('Usia', controller.userData['age'] ?? '-'),

              // Alamat utama
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 120,
                      child: Text(
                        'Alamat',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
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
                      onPressed: () {
                        // Navigasi ke halaman tambah alamat
                        Get.toNamed('/add-address');
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),
              const Text(
                'Alamat Lainnya',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const Divider(),

              anotherAddresses.isEmpty
                  ? const Text('Belum ada alamat tambahan')
                  : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: anotherAddresses.length,
                    itemBuilder: (context, index) {
                      final address = anotherAddresses[index];
                      return ListTile(
                        leading: const Icon(Icons.location_on),
                        title: Text(address['address']),
                        subtitle:
                            address['createdAt'] != null
                                ? Text(address['createdAt'].toDate().toString())
                                : null,
                      );
                    },
                  ),

              const SizedBox(height: 32),

              // Tombol Edit Profil
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.toNamed('/edit-profile'),
                  child: const Text('Edit Profil'),
                ),
              ),
            ],
          ),
        );
      }),
    );
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
