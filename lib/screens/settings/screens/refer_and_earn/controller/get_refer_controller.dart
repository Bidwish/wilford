import 'package:flutter/foundation.dart';
import 'package:wilford/screens/settings/screens/refer_and_earn/model/refer_model.dart';
import 'package:wilford/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GetReferController extends GetxController {
  var refer = <ReferModel>[].obs;
  var isLoading = false.obs;

  Future<void> fatchReferDetails() async {
    try {
      isLoading.value = true;

      // Delay to avoid context conflict
      await Future.delayed(const Duration(milliseconds: 200));
      // TFullScreenLoader.show();

      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) return;
      final rows = await Supabase.instance.client.from('referrals').select('referred_id, profiles!referrals_referred_id_fkey(first_name,last_name,avatar_path)').eq('referrer_id', userId);
      refer.value = rows.map((row) {
        final profile = Map<String, dynamic>.from(row['profiles'] as Map);
        return ReferModel.fromJson({'name': '${profile['first_name'] ?? ''} ${profile['last_name'] ?? ''}'.trim(), 'image': profile['avatar_path'] ?? ''});
      }).toList();
    } catch (e) {
      debugPrint(e.toString());
      TLoaders.errorSnackbar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
      // TFullScreenLoader.hide();
    }
  }
}
