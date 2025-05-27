import 'package:get/get.dart';

import '../controllers/edit_roti_controller.dart';

class EditRotiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditRotiController>(
      () => EditRotiController(),
    );
  }
}
