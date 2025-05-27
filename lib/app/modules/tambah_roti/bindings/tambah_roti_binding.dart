import 'package:get/get.dart';

import '../controllers/tambah_roti_controller.dart';

class TambahRotiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahRotiController>(
      () => TambahRotiController(),
    );
  }
}
