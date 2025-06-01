import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/keranjang_controller.dart';

class KeranjangView extends StatelessWidget {
  const KeranjangView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<KeranjangController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
        actions: [
          Obx(
            () => IconButton(
              icon: const Icon(Icons.delete),
              onPressed:
                  controller.selectedIds.isEmpty
                      ? null
                      : () {
                        controller.hapusProdukTerpilih();
                        Get.snackbar(
                          'Berhasil',
                          'Produk terpilih telah dihapus',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.items.isEmpty) {
                return const Center(child: Text('Keranjang belanja kosong'));
              }

              return ListView.builder(
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  final item = controller.items[index];
                  final isSelected = controller.selectedIds.contains(
                    item['id'],
                  );
                  final harga = double.tryParse(item['price'].toString()) ?? 0;
                  final jumlah = item['quantity'] ?? 1;
                  final subtotal = harga * jumlah;

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    color: isSelected ? Colors.grey[100] : Colors.white,
                    child: InkWell(
                      onTap: () => controller.togglePilihan(item['id']),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            // Checkbox
                            Checkbox(
                              value: isSelected,
                              onChanged:
                                  (_) => controller.togglePilihan(item['id']),
                              activeColor: Colors.brown,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),

                            // Gambar Produk
                            if (item['image_url']?.toString().isNotEmpty ==
                                true)
                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    item['image_url'],
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (_, __, ___) => Container(
                                          width: 50,
                                          height: 50,
                                          color: Colors.grey[200],
                                          child: const Icon(
                                            Icons.bakery_dining,
                                          ),
                                        ),
                                  ),
                                ),
                              ),

                            // Info Produk
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['bread'] ?? 'Produk',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Rp ${harga.toStringAsFixed(0)}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Kontrol Jumlah
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove, size: 20),
                                  onPressed:
                                      () => controller.kurangJumlah(index),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                                Container(
                                  width: 30,
                                  alignment: Alignment.center,
                                  child: Text(
                                    jumlah.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add, size: 20),
                                  onPressed:
                                      () => controller.tambahJumlah(index),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                              ],
                            ),

                            // Subtotal
                            Container(
                              width: 80,
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Rp ${subtotal.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),

          // Total Harga dan Checkout
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Harga:', style: TextStyle(fontSize: 16)),
                    Obx(
                      () => Text(
                        'Rp ${controller.totalHarga.value.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: Obx(
                    () => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[700],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed:
                          controller.selectedIds.isEmpty
                              ? null
                              : () {
                                // Filter item yang dipilih
                                final selectedItems =
                                    controller.items
                                        .where(
                                          (item) => controller.selectedIds
                                              .contains(item['id']),
                                        )
                                        .toList();

                                // Navigasi ke halaman checkout, bawa selectedItems sebagai argumen
                                Get.toNamed(
                                  '/checkout',
                                  arguments: selectedItems,
                                );
                              },
                      child: const Text(
                        'Pesan Sekarang',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
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
