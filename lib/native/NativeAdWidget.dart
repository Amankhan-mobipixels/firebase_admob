import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'AdIcon.dart';
import 'NativeAdType.dart';
import 'NativeShimmerColor.dart';

class NativeAdWidget extends StatelessWidget {
  final String? backgroundColor,
      textColorButton,
      buttonColor,
      shimmerBackgroundColor;
  final String adUnit;
  final int? buttonRoundness, buttonHeight;
  final double height;
  double? borderRoundness;
  final bool? enableShimmerEffect;
  final AdIcon? adIcon;
  final NativeShimmerColor? shimmerColor;
  final NativeAdType? adType;

  NativeAdWidget(
      {required this.adUnit,
      required this.adType,
      required this.height,
      this.borderRoundness,
      this.backgroundColor,
      this.textColorButton,
      this.buttonColor,
      this.shimmerBackgroundColor,
      this.buttonRoundness,
      this.buttonHeight,
      this.enableShimmerEffect,
      this.adIcon,
      this.shimmerColor});

  static const String viewType = 'nativeAd';

  @override
  Widget build(BuildContext context) {
    int Type;
    switch (adType) {
      case NativeAdType.NativeSmall:
        Type = 0;
        break;
      case NativeAdType.NativeAdvance:
        Type = 1;
        break;
      case null:
        Type = -1;
    }

    int icon;
    switch (adIcon) {
      case AdIcon.black:
        icon = 0;
        break;
      case AdIcon.white:
        icon = 1;
        break;
      case null:
        icon = -1;
    }

    int color;
    switch (shimmerColor) {
      case NativeShimmerColor.black:
        color = 0;
        break;
      case NativeShimmerColor.white:
        color = 1;
        break;
      case NativeShimmerColor.gray:
        color = 2;
        break;
      case null:
        color = -1;
    }

    return Container(
      height: height,
      padding: EdgeInsets.all(3),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRoundness??0),
        child: AndroidView(
          viewType: viewType,
          onPlatformViewCreated: (int id) {
            // Handle view created
          },
          layoutDirection: TextDirection.ltr,
          creationParams: <String, dynamic>{
            "backgroundColor": backgroundColor, // Pass colors or other params
            "textColorButton": textColorButton,
            "buttonColor": buttonColor,
            "buttonRoundness": buttonRoundness,
            "buttonHeight": buttonHeight,
            "adIcon": icon,
            "enableShimmerEffect": enableShimmerEffect,
            "shimmerColor": color,
            "shimmerBackgroundColor": shimmerBackgroundColor,
            "adType": Type,
            "adUnit": adUnit,
          },
          creationParamsCodec: const StandardMessageCodec(),
        ),
      ),
    );
  }
}
