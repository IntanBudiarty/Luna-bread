import 'package:get/get.dart';

import '../controllers/payment_method_dropdown_controller.dart';

class PaymentMethodDropdownBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentMethodDropdownController>(
      () => PaymentMethodDropdownController(),
    );
  }
}
