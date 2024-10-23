import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ad_Icon.dart';
import 'native_ad_type.dart';
import 'native_shimmer_color.dart';


/// A widget that displays a native ad with various customizable options.
class NativeAdWidget extends StatelessWidget {
  /// The background color of the native ad.
  final String? backgroundColor;

  /// The text color of the button in the native ad.
  final String? textColorButton;

  /// The background color of the button in the native ad.
  final String? buttonColor;

  /// The shimmer background color used when the ad is loading.
  final String? shimmerBackgroundColor;

  /// The ad unit ID for loading the native ad.
  final String adUnit;

  /// The roundness of the button's corners in the native ad.
  final int? buttonRoundness;

  /// The height of the button in the native ad.
  final int? buttonHeight;

  /// The total height of the native ad widget.
  final double height;

  /// The roundness of the ad's borders.
  final double? borderRoundness;

  /// Whether to enable the shimmer effect for the ad loading state.
  final bool enableShimmerEffect;

  /// The icon color for the ad. Can be black or white.
  final AdIcon? adIcon;

  /// The shimmer color for the ad loading state.
  final NativeShimmerColor? shimmerColor;

  /// The type of native ad to display (small or advanced).
  final NativeAdType? adType;

  /// Constructs a [NativeAdWidget].
  ///
  /// The [adUnit], [adType], and [height] are required.
  /// You can customize the appearance of the ad with parameters like
  /// [backgroundColor], [textColorButton], [buttonColor], [buttonRoundness],
  /// [buttonHeight], [borderRoundness], [enableShimmerEffect], [adIcon],
  /// and [shimmerColor].
  NativeAdWidget({
    required this.adUnit,
    required this.adType,
    required this.height,
    this.borderRoundness,
    this.backgroundColor,
    this.textColorButton,
    this.buttonColor,
    this.shimmerBackgroundColor,
    this.buttonRoundness,
    this.buttonHeight,
    this.enableShimmerEffect = false,
    this.adIcon,
    this.shimmerColor,
  });

  /// The view type for the native ad in the platform view.
  static const String viewType = 'nativeAd';

  @override
  Widget build(BuildContext context) {
    /// Determine the native ad type.
    int type;
    switch (adType) {
      case NativeAdType.nativeSmall:
        type = 0;
        break;
      case NativeAdType.nativeAdvance:
        type = 1;
        break;
      case null:
        type = -1;
    }

    /// Determine the icon color for the ad.
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

    /// Determine the shimmer color for the loading state.
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
      padding: const EdgeInsets.all(3),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRoundness ?? 0),
        child: AndroidView(
          viewType: viewType,
          onPlatformViewCreated: (int id) {
            // Handle view creation for the native ad platform view.
          },
          layoutDirection: TextDirection.ltr,
          creationParams: <String, dynamic>{
            "backgroundColor": backgroundColor,
            "textColorButton": textColorButton,
            "buttonColor": buttonColor,
            "buttonRoundness": buttonRoundness,
            "buttonHeight": buttonHeight,
            "adIcon": icon,
            "enableShimmerEffect": enableShimmerEffect,
            "shimmerColor": color,
            "shimmerBackgroundColor": shimmerBackgroundColor,
            "adType": type,
            "adUnit": adUnit,
          },
          creationParamsCodec: const StandardMessageCodec(),
        ),
      ),
    );
  }
}

