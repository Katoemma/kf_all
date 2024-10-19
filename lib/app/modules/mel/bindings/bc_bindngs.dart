import 'package:get/get.dart';
import 'package:kijani_branch/app/modules/mel/controllers/mel_controller.dart';

class MelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MelController>(() => MelController());
  }
}
