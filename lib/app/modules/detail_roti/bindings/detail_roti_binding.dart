import 'package:get/get.dart';

import '../controllers/detail_roti_controller.dart';

class DetailRotiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailRotiController>(
      () => DetailRotiController(),
    );
  }
}
