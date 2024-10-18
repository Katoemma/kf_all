import 'package:get/get.dart';
import 'package:kijani_branch/app/modules/bc/controllers/bc_controller.dart';

class BcBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BcController>(() => BcController());
  }
}
