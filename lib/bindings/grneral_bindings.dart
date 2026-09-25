import 'package:get/get.dart';
import 'package:wilford/utils/network/network_manager.dart';

class GrneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
  }
}
