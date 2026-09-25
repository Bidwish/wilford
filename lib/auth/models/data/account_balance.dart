import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wilford/routes/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountController extends GetxController {
  var accountBalance = 0.0.obs;
  var isLoading = true.obs;
  var isHidden = true.obs;

  final storage = GetStorage();
  final String _hideKey = 'hide_balance';

  @override
  void onInit() {
    super.onInit();

    // Load persisted toggle state
    isHidden.value = storage.read(_hideKey) ?? true;

    fatchAccountBalance();
  }

  void toggleHidden() {
    isHidden.toggle();
    storage.write(_hideKey, isHidden.value); // Save to storage
  }

  void fatchAccountBalance() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      Get.offAllNamed(AppRoutes.login);
      return;
    }

    try {
      isLoading(true);

      final result = await Supabase.instance.client
          .from('wallets')
          .select('balance')
          .eq('user_id', userId)
          .single();
      accountBalance.value = double.tryParse(result['balance'].toString()) ?? 0.0;
    } catch (e) {
      // Optional: Add error handling/snackbars
    } finally {
      isLoading(false);
    }
  }
}
