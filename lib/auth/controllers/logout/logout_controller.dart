import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wilford/routes/app_routes.dart';
import 'package:wilford/utils/constants/sizes.dart';

Future<void> logoutUser() async {
  final box = GetStorage();
  final lastPhone = box.read('last_login_phone');

  await Supabase.instance.client.auth.signOut();
  box.erase(); 

  if (lastPhone != null) {
    box.write('last_login_phone', lastPhone); // Store last phone number
  }
  Get.offAllNamed(AppRoutes.login); // Redirect to login page
}

void showLogoutDialog() {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.borderRadiusLg)),
      child: Padding(
        padding: const EdgeInsets.all(TSizes.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              size: 60,
              color: Colors.red,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            const Text(
              "Logout",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "Are you sure you want to logout?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Get.back(), // Close the dialog
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.grey[300], // Light grey for Cancel
                      foregroundColor: Colors.black, // Text color black
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: logoutUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Red for Logout
                      foregroundColor: Colors.white, // Text color white
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Logout'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}
