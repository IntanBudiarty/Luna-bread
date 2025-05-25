import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_page_controller.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

        // Cart Icon on the right
        IconButton(
          icon: const Icon(Icons.shopping_cart, size: 30, color: Colors.brown),
          onPressed: () {
            // Add functionality for the cart icon
            print('Cart tapped!');
          },
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
          height: 120,
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
        // Use a SizedBox with proper height constraints for GridView
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            _buildProductItem(
              'Roti Tawar Putih Sandwich',
              'assets/home/roti_tawar.png',
              'Rp. 13.000',
              'Rp. 18.000',
            ),
            _buildProductItem(
              'Roti Panggang Roti Susu Tawar',
              'assets/home/roti_panggang.png',
              'Rp. 10.000',
              'Rp. 13.000',
            ),
            _buildProductItem(
              'Roti Panggang Roti Susu Tawar',
              'assets/home/roti_panggang.png',
              'Rp. 10.000',
              'Rp. 13.000',
            ),
            _buildProductItem(
              'Roti Panggang Roti Susu Tawar',
              'assets/home/roti_panggang.png',
              'Rp. 10.000',
              'Rp. 13.000',
            ),
          ],
        ),
      ],
    );
  }

  // Product Item Widget
  Widget _buildProductItem(
    String name,
    String image,
    String originalPrice,
    String discountedPrice,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              image,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      originalPrice,
                      style: const TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      discountedPrice,
                      style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
