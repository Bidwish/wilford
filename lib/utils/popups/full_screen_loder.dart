import 'package:get/get.dart';
import 'package:wilford/commom/widgets/loaders/animation_loader.dart';

class TFullScreenLoader {
  // static final _loader = CustomLoadingOverlay(message: 'Please wait...');

  /// Show full screen loading overlay
  static void show({String? message}) {
    if (Get.isDialogOpen != true) {
      Get.dialog(
        CustomLoadingOverlay(message: message),
        barrierDismissible: false,
        useSafeArea: true,
      );
    }
  }

  /// Hide full screen loading
  static void hide() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }
}
