import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_roti_controller.dart';

import 'package:lottie/lottie.dart';

class EditRotiView extends GetView<EditRotiController> {
  const EditRotiView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Roti",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFEBDED4),
      ),
      backgroundColor: const Color(0xFFEBDED4),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Lottie.asset("assets/bread/roti1.json", height: 350),
          ),
          TextField(
            controller: controller.imageC,
            decoration: InputDecoration(
              labelText: "Image URL",
              prefixIcon: Icon(Icons.photo),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: controller.breadC,
            decoration: InputDecoration(
              labelText: "Bread",
              prefixIcon: Icon(Icons.cake),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: controller.priceC,
            decoration: InputDecoration(
              labelText: "Price",
              prefixIcon: Icon(Icons.money),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: controller.descriptionC,
            decoration: InputDecoration(
              labelText: "Description",
              prefixIcon: Icon(Icons.description),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          SizedBox(height: 10),
          Obx(
            () => ElevatedButton(
              onPressed: () {
                if (controller.isLoading.isFalse) {
                  controller.updateRoti();
                }
              },
              child: Text(
                controller.isLoading.isFalse ? "SAVE" : "LOADING...",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
            ),
          ),
        ],
      ),
    );
  }
}
