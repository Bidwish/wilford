import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/commom/widgets/containers/container_widget.dart';
import 'package:wilford/commom/widgets/profile_Image/circuler_image.dart';
import 'package:wilford/screens/settings/screens/refer_and_earn/controller/generate_refer_code.dart';
import 'package:wilford/screens/settings/screens/refer_and_earn/controller/get_refer_controller.dart';
import 'package:wilford/screens/settings/screens/refer_and_earn/widget/shera_and_copy.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/image_strings.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class ReferScreen extends StatefulWidget {
  const ReferScreen({super.key});

  @override
  State<ReferScreen> createState() => _ReferScreenState();
}

class _ReferScreenState extends State<ReferScreen> {
  final getReferController = Get.put(GetReferController());
  final generateReferCode = Get.put(GenerateReferCode());

  @override
  void initState() {
    super.initState();
    generateReferCode.generateReferCode();
    getReferController.fatchReferDetails();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final box = GetStorage();

    return Scaffold(
      appBar: TAppBar(
        title: Text("Refer & Earn"),
        showBackArrow: true,
        leadingOnPressed: () => Get.back,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image.asset(
                TImages.referral,
                width: 170,
                height: 170,
              )),
              const SizedBox(height: TSizes.md / 2),
              Center(
                child: Text('Invite friend!',
                    style: Theme.of(context).textTheme.headlineLarge),
              ),
              const SizedBox(height: TSizes.md / 2),
              Center(
                child: Text(
                  'The More You Share, The More Your Earn!',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: TSizes.md),
              Text(
                'List of your friends (${getReferController.refer.length})',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .apply(fontWeightDelta: 2),
              ),
              const SizedBox(height: TSizes.sm),
              Obx(() {
                // --- Loading State ---
                if (getReferController.isLoading.value) {
                  return TContainer(
                    chlid: Padding(
                      padding: const EdgeInsets.all(TSizes.sm),
                      child: Column(
                        children: List.generate(
                          5,
                          (index) {
                            return Shimmer.fromColors(
                              baseColor: isDark ? TColors.dark : TColors.grey,
                              highlightColor:
                                  isDark ? TColors.darkerGrey : TColors.white,
                              child: ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: TColors.grey,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                title: Container(
                                  height: 10,
                                  width: 170,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: TColors.grey,
                                  ),
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: TColors.grey,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                }

                if (getReferController.refer.isEmpty) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(TSizes.md),
                    decoration: BoxDecoration(
                      color: isDark
                          ? TColors.darkContainer
                          : TColors.lightContainer,
                      borderRadius:
                          BorderRadius.circular(TSizes.borderRadiusMd),
                    ),
                    child: Center(
                        child: Text(
                      'You haven\'t invited anyone yet',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(color: TColors.darkGrey),
                    )),
                  );
                }

                return TContainer(
                  chlid: Padding(
                    padding: const EdgeInsets.symmetric(vertical: TSizes.sm),
                    child: Column(
                      children: List.generate(
                        getReferController.refer.length,
                        (index) {
                          final refer = getReferController.refer[index];
                          return ListTile(
                            leading: TCirculerImage(
                              width: 45,
                              height: 45,
                              padding: 0,
                              isNetworkImage: true,
                              image: refer.image,
                            ),
                            title: Text(
                              refer.name,
                              style:
                                  Theme.of(context).textTheme.labelLarge!.apply(
                                        fontWeightDelta: 2,
                                        fontSizeDelta: 1,
                                      ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),

      // --- Bottom Button
      bottomNavigationBar: ReferralActions(
        referralCode: '${box.read('referral')}',
      ),
    );
  }
}
