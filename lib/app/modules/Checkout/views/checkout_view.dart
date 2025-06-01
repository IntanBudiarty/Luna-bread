import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toko_roti/app/modules/Account/controllers/account_controller.dart';
import 'package:toko_roti/app/modules/Orders/views/orders_view.dart';
import 'package:toko_roti/app/modules/keranjang/controllers/keranjang_controller.dart';
import 'package:toko_roti/app/modules/payment_method_dropdown/views/payment_method_dropdown_view.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  _CheckoutViewState createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  File? _image;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _takePhoto() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  final List<dynamic> cartItems = Get.arguments ?? [];
  Widget build(BuildContext context) {
    final accountController = Get.put(AccountController());
    Get.find<KeranjangController>();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text('Checkout', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.brown,
      ),
      backgroundColor: const Color(0xFFEBDED4),
      body: Obx(() {
        if (accountController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (accountController.userData.isEmpty) {
          return const Center(child: Text('Data pengguna tidak ditemukan'));
        }

        final double totalAmount = cartItems.fold(0, (total, item) {
          final harga = double.tryParse(item['price'].toString()) ?? 0.0;
          final jumlah = item['quantity'] ?? 1;
          return total + (harga * jumlah);
        });

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Information Card
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informasi Pengiriman',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[700],
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Divider(height: 1),
                      const SizedBox(height: 12),
                      _buildUserInfoItem(
                        Icons.person,
                        'Nama Lengkap',
                        accountController.userData['fullName'] ??
                            'Tidak tersedia',
                      ),
                      _buildUserInfoItem(
                        Icons.email,
                        'Email',
                        accountController.userData['email'] ?? 'Tidak tersedia',
                      ),
                      _buildUserInfoItem(
                        Icons.phone,
                        'Nomor HP',
                        accountController.userData['phone'] ?? '-',
                      ),
                      _buildUserInfoItem(
                        Icons.location_on,
                        'Alamat',
                        accountController.userData['address'] ?? '-',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Order Items Card
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Detail Pesanan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[700],
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Divider(height: 1),
                      const SizedBox(height: 12),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          double harga =
                              double.tryParse(item['price'].toString()) ?? 0.0;
                          int jumlah = item['quantity'] ?? 1;
                          double subtotal = harga * jumlah;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    item['image_url'] ??
                                        'https://example.com/default.jpg',
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['bread'] ?? 'Nama tidak tersedia',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${jumlah}x Rp ${harga.toStringAsFixed(0)}',
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'Rp ${subtotal.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.brown[700],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      const Divider(height: 1),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Pembayaran',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown[700],
                            ),
                          ),
                          Text(
                            'Rp ${totalAmount.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown[700],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Payment Method Card
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Metode Pembayaran',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[700],
                        ),
                      ),
                      SizedBox(height: 12),
                      Divider(height: 1),
                      SizedBox(height: 12),
                      PaymentMethodDropdown(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Payment Proof Card
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bukti Pembayaran',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[700],
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Divider(height: 1),
                      const SizedBox(height: 12),
                      if (_image == null)
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image,
                                  size: 40,
                                  color: Colors.brown,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Belum ada gambar',
                                  style: TextStyle(color: Colors.brown[700]),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            _image!,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              icon: const Icon(
                                Icons.photo_library,
                                color: Colors.brown,
                              ),
                              label: Text(
                                'Galeri',
                                style: TextStyle(color: Colors.brown[700]),
                              ),
                              onPressed: _pickImage,
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.brown,
                              ),
                              label: Text(
                                'Kamera',
                                style: TextStyle(color: Colors.brown[700]),
                              ),
                              onPressed: _takePhoto,
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Checkout Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final orderItems =
                        cartItems.map((item) {
                          return {
                            'bread': item['bread'],
                            'price':
                                double.tryParse(item['price'].toString()) ??
                                0.0, // Pastikan harga dalam double
                            'quantity': item['quantity'],
                            'image_url': item['image_url'],
                          };
                        }).toList();

                    // Kirim data yang sudah dipastikan memiliki tipe yang sesuai
                    Get.toNamed(
                      '/orders',
                      arguments: {
                        'items': orderItems,
                        'total':
                            totalAmount, // Pastikan totalAmount adalah double
                      },
                    );
                    Get.snackbar('Berhasil', 'Pesanan berhasil dibuat');
                  },
                  child: const Text(
                    'PROSES PEMBAYARAN',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildUserInfoItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.brown),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
