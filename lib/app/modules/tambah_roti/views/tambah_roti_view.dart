import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tambah_roti_controller.dart';

class TambahRotiView extends GetView<TambahRotiController> {
  const TambahRotiView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TambahRotiView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TambahRotiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
