import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toko_roti/app/routes/app_pages.dart';
import '../controllers/home_page_controller.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.TAMBAH_ROTI);
        },
        backgroundColor: Colors.brown,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      backgroundColor: const Color(0xFFEBDED4),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildSearchBar(),
              const SizedBox(height: 20),
              _buildFeaturedProducts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('assets/logo.png', width: 80, height: 80),
        Row(
          children: [
            // Icon untuk keranjang belanja
            IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                size: 30,
                color: Colors.brown,
              ),
              onPressed: () => Get.toNamed(Routes.KERANJANG),
            ),

            // PopupMenuButton untuk dropdown Akun dan Logout
            PopupMenuButton<String>(
              icon: const Icon(
                Icons.account_circle,
                size: 30,
                color: Colors.brown,
              ),
              onSelected: (value) {
                if (value == 'account') {
                  // Arahkan ke halaman akun
                  Get.toNamed(Routes.ACCOUNT);
                } else if (value == 'logout') {
                  // Logout dan arahkan ke halaman login
                  controller
                      .logout(); // Pastikan ada method logout di controller
                }
              },
              itemBuilder:
                  (context) => [
                    PopupMenuItem<String>(
                      value: 'account',
                      child: Row(
                        children: const [
                          Icon(Icons.account_circle, color: Colors.brown),
                          SizedBox(width: 10),
                          Text('Akun Saya'),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'logout',
                      child: Row(
                        children: const [
                          Icon(Icons.logout, color: Colors.brown),
                          SizedBox(width: 10),
                          Text('Logout'),
                        ],
                      ),
                    ),
                  ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        onChanged: (value) {
          controller.searchQuery.value = value;
        },
        decoration: const InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        ),
      ),
    );
  }

  Widget _buildFeaturedProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'Produk Kami',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
        ),
        const SizedBox(height: 16),
        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.breadStream.value,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            return Obx(() {
              final query = controller.searchQuery.value.toLowerCase();
              final allBreads = snapshot.data!.docs;
              final breads =
                  allBreads.where((doc) {
                    final name = doc['bread'].toString().toLowerCase();
                    return name.contains(query);
                  }).toList();

              if (breads.isEmpty) {
                return Center(
                  child: Text(
                    controller.searchQuery.value.isEmpty
                        ? "BELUM ADA DATA ROTI"
                        : "Tidak ditemukan roti dengan nama '${controller.searchQuery.value}'",
                    style: const TextStyle(
                      color: Colors.brown,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: breads.length,
                itemBuilder: (context, index) {
                  var data = breads[index].data();
                  return GestureDetector(
                    onTap:
                        () => Get.toNamed(Routes.DETAIL_ROTI, arguments: data),
                    child: _buildBreadCard(
                      data,
                      breads[index].id,
                      breads[index],
                    ),
                  );
                },
              );
            });
          },
        ),
      ],
    );
  }

  Widget _buildBreadCard(
    Map<String, dynamic> data,
    String docId,
    QueryDocumentSnapshot breadDoc,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Image.network(
                    data['image_url'],
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) =>
                            const Icon(Icons.broken_image),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Text(
                      data['bread'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Rp ${data['price']}",
                      style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data['description'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: 30,
                  height: 30,
                  child: IconButton(
                    onPressed: () {
                      Get.toNamed(Routes.EDIT_ROTI, arguments: breadDoc);
                    },
                    icon: const Icon(Icons.edit, color: Colors.white, size: 19),
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: 30,
                  height: 30,
                  child: IconButton(
                    onPressed: () {
                      Get.defaultDialog(
                        title: "Konfirmasi",
                        middleText: "Yakin ingin menghapus roti ini?",
                        textConfirm: "Ya",
                        textCancel: "Batal",
                        confirmTextColor: Colors.white,
                        onConfirm: () {
                          controller.hapusRoti(docId);
                          Get.back();
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 19,
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
