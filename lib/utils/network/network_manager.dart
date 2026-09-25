import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wilford/utils/popups/loaders.dart';

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectivityStatus =
      ConnectivityResult.none.obs;

  /// Initialize the NetworkManager and start listening to connectivity changes
  @override
  void onInit() {
    super.onInit();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((results) {
      // The new API returns a List<ConnectivityResult>
      if (results.isNotEmpty) {
        _updateConnectionStatus(results.first);
      }
    });
  }

  /// Update the connectivity status based on changes
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectivityStatus.value = result;

    if (_connectivityStatus.value == ConnectivityResult.none) {
      TLoaders.warningSnackbar(title: 'No Internet Connection');
    }
  }

  /// Check the Internet Connection status manually
  Future<bool> isConnected() async {
    try {
      final results = await _connectivity.checkConnectivity();

      if (results.isEmpty || results.first == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Dispose or close the active connectivity stream
  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
