import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:wilford/auth/controllers/user_controller/refersh_user_data.dart';
import 'package:wilford/utils/network/network_manager.dart';
import 'package:wilford/utils/popups/loaders.dart';

class ProfileImageController extends GetxController {
  static ProfileImageController get instance => Get.find();

  var isLoading = false.obs;

  /// Function to pick an image from the gallery and upload it
  Future<void> pickerImageAndUpload() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage == null) return;

      /// Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackbar(
          title: "No Internet",
          message: "Please check your internet connection and try again.",
        );
        return;
      }

      isLoading.value = true;

      final token = GetStorage().read('token');
      if (token == null) {
        TLoaders.errorSnackbar(title: 'Error', message: 'Token not found');
        return;
      }

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://api.wilford.ng/v1/user/upload/'),
      );

      request.headers['Authorization'] = 'Bearer $token';
      request.files
          .add(await http.MultipartFile.fromPath('avatar', pickedImage.path));

      // Send the multipart request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      debugPrint('Status code: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        TLoaders.successSnackbar(
            title: 'Success', message: 'Profile image updated');
        await refreshUserData(); // Refresh the user model
      } else {
        TLoaders.errorSnackbar(
            title: 'Upload failed', message: 'Please try again');
      }
    } catch (e) {
      debugPrint('Upload error: $e');
      TLoaders.errorSnackbar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
