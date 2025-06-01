import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class KeranjangController extends GetxController {
  final items = <Map<String, dynamic>>[].obs;
  final selectedIds = <String>[].obs;
  final totalHarga = 0.0.obs;

  String? userId;

  @override
  void onInit() {
    super.onInit();
    _loadUserId(); // Memuat userId ketika aplikasi dimulai
  }

  // Load userId dari SharedPreferences
  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId'); // Memuat userId yang disimpan
    if (userId != null) {
      await _loadKeranjang(); // Jika userId ditemukan, load keranjang
    }
  }

  // Load keranjang berdasarkan userId
  Future<void> _loadKeranjang() async {
    if (userId == null) return;

    final prefs = await SharedPreferences.getInstance();
    final String? keranjangData = prefs.getString(
      'keranjang_$userId',
    ); // Menyimpan keranjang dengan key unik berdasarkan userId

    if (keranjangData != null) {
      final List<dynamic> decodedItems = json.decode(keranjangData);
      items.addAll(decodedItems.map((item) => Map<String, dynamic>.from(item)));
      hitungTotal();
    }
  }

  // Simpan keranjang dengan userId sebagai bagian dari key
  Future<void> _saveKeranjang() async {
    if (userId == null) return;

    final prefs = await SharedPreferences.getInstance();
    final String encodedItems = json.encode(items);
    await prefs.setString(
      'keranjang_$userId',
      encodedItems,
    ); // Simpan data keranjang dengan kunci berbasis userId
  }

  // Menambahkan produk ke keranjang
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

  // Toggle pilihan produk
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

  // Menambah jumlah produk
  void tambahJumlah(int index) {
    items[index] = {
      ...items[index],
      'quantity': (items[index]['quantity'] ?? 1) + 1,
    };
    hitungTotal();
    _saveKeranjang(); // Simpan data setelah tambah jumlah
    items.refresh();
  }

  // Mengurangi jumlah produk
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

  // Menghitung total harga
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

  // Menghapus produk terpilih
  void hapusProdukTerpilih() {
    items.removeWhere((item) => selectedIds.contains(item['id']));
    selectedIds.clear();
    hitungTotal();
    _saveKeranjang(); // Simpan data setelah hapus produk terpilih
  }
}
