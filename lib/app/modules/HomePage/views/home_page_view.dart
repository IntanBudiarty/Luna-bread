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
        child: Icon(Icons.add, color: Colors.white),
      ),
      backgroundColor: const Color(0xFFEBDED4),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo and Cart Icon in Row, scrolls with content
              _buildHeader(),

              const SizedBox(
                height: 20,
              ), // Spacing between header and search bar
              // Search Bar
              _buildSearchBar(),

              const SizedBox(
                height: 20,
              ), // Spacing between search bar and category section
              // Kategori Horizontal
              _buildCategorySection(),

              const SizedBox(
                height: 20,
              ), // Spacing between category section and featured products
              // Produk Unggulan
              _buildFeaturedProducts(),
            ],
          ),
        ),
      ),
    );
  }

  // Build logo and cart icon in a row, which will scroll with the content
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out the items
      children: [
        // Logo on the left
        Image.asset(
          'assets/logo.png', // Make sure to have the logo image in the correct folder
          width: 80,
          height: 80,
        ),

        Row(
          children: [
            // Cart Icon on the right
            IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                size: 30,
                color: Colors.brown,
              ),
              onPressed: () {
                // Add functionality for the cart icon
                print('Cart tapped!');
              },
            ),
            IconButton(
              onPressed: () {
                controller.logout();
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
      ],
    );
  }

  // Search Bar
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
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 20,
          ),
        ),
      ),
    );
  }

  // Kategori Section
  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'Kategori',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Use Expanded to ensure the ListView takes the available space
        SizedBox(
          height: 130,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildCategoryItem('Tawar', 'assets/home/tawar.png'),
              const SizedBox(width: 16),
              _buildCategoryItem('Manis', 'assets/home/manis.png'),
              const SizedBox(width: 16),
              _buildCategoryItem('Gandum', 'assets/home/gandum.png'),
              const SizedBox(width: 16),
              _buildCategoryItem('Sourdough', 'assets/home/sourdough.png'),
            ],
          ),
        ),
      ],
    );
  }

  // Category Item Widget
  Widget _buildCategoryItem(String title, String imagePath) {
    return Column(
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.brown,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  // Featured Products Section
  Widget _buildFeaturedProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'Produk Unggulan',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // StreamBuilder untuk ambil data dari Firestore
        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.getBread(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("BELUM ADA DATA ROTI"));
            }

            var breads = snapshot.data!.docs;

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
                  onTap: () {
                    Get.toNamed(Routes.DETAIL_ROTI, arguments: data);
                  },
                  child: Container(
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
                                  "${data['image_url']}",
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
                                    "${data['bread']}",
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
                                    "${data['description']}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
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
                                    Get.toNamed(
                                      Routes.EDIT_ROTI,
                                      arguments: breads[index],
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 19,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
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
                                      middleText:
                                          "Yakin ingin menghapus roti ini?",
                                      textConfirm: "Ya",
                                      textCancel: "Batal",
                                      confirmTextColor: Colors.white,
                                      onConfirm: () {
                                        controller.hapusRoti(breads[index].id);
                                        Get.back(); // Tutup dialog
                                      },
                                    );
                                  },
                                  icon: Icon(
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
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
