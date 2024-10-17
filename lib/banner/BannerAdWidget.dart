import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'BannerAdType.dart';
import 'BannerShimmerColor.dart';

class BannerAdWidget extends StatelessWidget {
  final String adUnit;
  final double height;
  final BannerAdType? adType;
  double? borderRoundness;
  final String? shimmerBackgroundColor;
  final bool? enableShimmerEffect;
  final BannerShimmerColor? shimmerColor;

  BannerAdWidget(
      {required this.adUnit,
      required this.adType,
      required this.height,
      this.borderRoundness,
      this.shimmerBackgroundColor,
      this.enableShimmerEffect,
      this.shimmerColor});

  static const String viewType = 'bannerAd';

  @override
  Widget build(BuildContext context) {
    int Type;
    switch (adType) {
      case BannerAdType.Banner:
        Type = 0;
        break;
      case BannerAdType.CollapsibleBanner:
        Type = 1;
        break;
      case null:
        Type = -1;
    }

    int color;
    switch (shimmerColor) {
      case BannerShimmerColor.black:
        color = 0;
        break;
      case BannerShimmerColor.white:
        color = 1;
        break;
      case BannerShimmerColor.gray:
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
