import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class KeranjangController extends GetxController {
  final items = <Map<String, dynamic>>[].obs;
  final selectedIds = <String>[].obs;
  final totalHarga = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadKeranjang();
  }

  // Load data keranjang dari SharedPreferences
  Future<void> _loadKeranjang() async {
    final prefs = await SharedPreferences.getInstance();
    final String? keranjangData = prefs.getString('keranjang');

    if (keranjangData != null) {
      final List<dynamic> decodedItems = json.decode(keranjangData);
      items.addAll(decodedItems.map((item) => Map<String, dynamic>.from(item)));
      hitungTotal();
    }
  }

  // Simpan data keranjang ke SharedPreferences
  Future<void> _saveKeranjang() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedItems = json.encode(items);
    await prefs.setString('keranjang', encodedItems);
  }

  void tambahProduk(Map<String, dynamic> produk) {
    final index = items.indexWhere((item) => item['id'] == produk['id']);

    if (index >= 0) {
      items[index] = {
        ...items[index],
        'quantity': (items[index]['quantity'] ?? 1) + 1,
      };
    } else {
      items.add({...produk, 'quantity': 1, 'isChecked': false});
    }
    hitungTotal();
    _saveKeranjang(); // Simpan data setelah menambah produk
    items.refresh();
  }

  void togglePilihan(String productId) {
    if (selectedIds.contains(productId)) {
      selectedIds.remove(productId);
    } else {
      selectedIds.add(productId);
    }
    hitungTotal();
    items.refresh();
    _saveKeranjang(); // Simpan data setelah toggle pilihan
  }

  // Tambah jumlah produk
  void tambahJumlah(int index) {
    items[index] = {
      ...items[index],
      'quantity': (items[index]['quantity'] ?? 1) + 1,
    };
    hitungTotal();
    _saveKeranjang(); // Simpan data setelah tambah jumlah
    items.refresh();
  }

  // Kurangi jumlah produk
  void kurangJumlah(int index) {
    final currentQty = items[index]['quantity'] ?? 1;

    if (currentQty > 1) {
      items[index] = {...items[index], 'quantity': currentQty - 1};
    } else {
      final productId = items[index]['id'];
      selectedIds.remove(productId);
      items.removeAt(index);
    }
    hitungTotal();
    _saveKeranjang(); // Simpan data setelah kurangi jumlah
    items.refresh();
  }

  // Hitung total harga
  void hitungTotal() {
    double total = 0.0;

    for (final item in items) {
      if (selectedIds.contains(item['id'])) {
        total +=
            (double.parse(item['price'].toString())) * (item['quantity'] ?? 1);
      }
    }

    totalHarga.value = total;
  }

  void hapusProdukTerpilih() {
    items.removeWhere((item) => selectedIds.contains(item['id']));
    selectedIds.clear();
    hitungTotal();
    _saveKeranjang(); // Simpan data setelah hapus produk terpilih
  }
}
