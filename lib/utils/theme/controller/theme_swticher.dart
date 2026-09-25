import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/theme/controller/theme_controller.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ThemeController>();

    return Obx(
      () {
        final mode = controller.themeMode.value;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'App Theme',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),

              /// --- Theme Options ---
              _themeTile(
                icon: Icons.wb_sunny_outlined,
                title: 'Light Mode',
                isSelected: mode == ThemeMode.light,
                onTap: () {
                  controller.setThemeMode(ThemeMode.light);
                  Get.back();
                },
              ),
              _themeTile(
                icon: Icons.nightlight_outlined,
                title: 'Dark Mode',
                isSelected: mode == ThemeMode.dark,
                onTap: () {
                  controller.setThemeMode(ThemeMode.dark);
                  Get.back();
                },
              ),
              _themeTile(
                icon: Icons.phone_android_outlined,
                title: 'System Default',
                isSelected: mode == ThemeMode.system,
                onTap: () {
                  controller.setThemeMode(ThemeMode.system);
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// Reusable theme option tile
  Widget _themeTile({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: isSelected ? TColors.primary : null),
      title: Text(title),
      trailing: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: isSelected
            ? Icon(
                Icons.check_circle,
                color: TColors.primary,
                key: const ValueKey(true),
              )
            : Icon(
                Icons.circle_outlined,
                color: Colors.grey,
                key: const ValueKey(false),
              ),
      ),
      onTap: onTap,
    );
  }
}
