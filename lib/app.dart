import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/bindings/grneral_bindings.dart';
import 'package:wilford/routes/app_routes.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/theme/controller/theme_controller.dart';
import 'package:wilford/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());

    return Obx(
      () => GetMaterialApp(
        title: 'Wilford',
        themeMode: themeController.themeMode.value,
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        initialBinding: GrneralBindings(),
        getPages: AppRoutes.routes,
        debugShowCheckedModeBanner: false,
        home: const Scaffold(
          backgroundColor: TColors.primary,
          body: Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
