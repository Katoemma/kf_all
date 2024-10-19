import 'package:get/get.dart';
import 'package:kijani_branch/app/data/providers/parish_provider.dart';

class ParishBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ParishProvider());
  }
}
