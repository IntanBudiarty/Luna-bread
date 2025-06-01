// File: app/modules/orders/controllers/orders_controller.dart
import 'package:get/get.dart';

class OrdersController extends GetxController {
  final orders = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    // Load data pesanan dari API atau database
    super.onInit();
  }

  void addOrder(Map<String, dynamic> order) {
    orders.insert(0, order);
  }
}
