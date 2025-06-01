import 'package:get/get.dart';

import '../controllers/edit_account_controller.dart';

class EditAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditAccountController>(
      () => EditAccountController(),
    );
  }
}
