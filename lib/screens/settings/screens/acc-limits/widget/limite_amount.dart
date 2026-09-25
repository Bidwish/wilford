import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wilford/auth/controllers/user_controller/user_controller.dart';
import 'package:wilford/commom/widgets/containers/container_widget.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/amount_function.dart';

class TTierContainer extends StatelessWidget {
  const TTierContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());

    return Obx(() {
      final user = userController.user.value;
      final tier = user?.tier ?? '';

      if (tier == '1') {
        return TContainer(
          chlid: Padding(
            padding: const EdgeInsets.all(TSizes.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Tier 1',
                      style: Theme.of(context).textTheme.bodyLarge!.apply(
                            fontWeightDelta: 2,
                          ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: TSizes.spaceBtwItems / 2),
                      padding: EdgeInsets.symmetric(
                        horizontal: TSizes.sm,
                        vertical: TSizes.xs / 2,
                      ),
                      decoration: BoxDecoration(
                        color: TColors.warning.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Current',
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                              fontWeightDelta: 1,
                              color: TColors.warning,
                            ),
                      ),
                    ),
                  ],
                ),
                Divider(thickness: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Daily transaction limit',
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                            fontWeightDelta: 1, color: TColors.darkGrey)),
                    Text(
                      formatCurrency(10000),
                      style: TextStyle(
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems / 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Maximum account balance',
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                            fontWeightDelta: 1, color: TColors.darkGrey)),
                    Text(
                      formatCurrency(50000),
                      style: TextStyle(
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }

      return TContainer(
        chlid: Padding(
          padding: const EdgeInsets.all(TSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tier 0',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .apply(fontWeightDelta: 2)),
              Divider(thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Daily transaction limit',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .apply(fontWeightDelta: 1, color: TColors.darkGrey)),
                  Text(formatCurrency(1000),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .apply(fontWeightDelta: 1))
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Maximum account balance',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .apply(fontWeightDelta: 1, color: TColors.darkGrey)),
                  Text(formatCurrency(5000),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .apply(fontWeightDelta: 1))
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
