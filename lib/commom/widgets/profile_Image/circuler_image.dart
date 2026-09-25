import 'package:flutter/material.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class TCirculerImage extends StatelessWidget {
  const TCirculerImage({
    super.key,
    required this.width,
    required this.height,
    required this.padding,
    this.backgrounColor,
    this.fit,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final double width, height, padding;
  final Color? backgrounColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(
          color: TColors.white,
          width: 2,
        ),
        color: backgrounColor ??
            (THelperFunctions.isDarkMode(context)
                ? TColors.black
                : TColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
          child: Image(
            fit: fit,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Shimmer.fromColors(
                baseColor: TColors.gray,
                highlightColor: TColors.lightGrey,
                child: Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: backgrounColor ??
                        (THelperFunctions.isDarkMode(context)
                            ? TColors.darkGrey
                            : TColors.darkGrey),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              );
            },
            image: isNetworkImage ? NetworkImage(image) : AssetImage(image),
            color: overlayColor,
          ),
        ),
      ),
    );
  }
}
