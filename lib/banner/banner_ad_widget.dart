import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'banner_ad_type.dart';
import 'banner_shimmer_color.dart';

/// A widget that displays a banner ad using an Android platform view.
///
/// [BannerAdWidget] can display different types of banner ads
/// with optional shimmer effects and customizable corner rounding.
class BannerAdWidget extends StatelessWidget {
  /// The ad unit ID to load and display the banner ad.
  final String adUnit;

  /// The height of the banner ad widget.
  final double height;

  /// The type of the banner ad (e.g., [BannerAdType.Banner], [BannerAdType.CollapsibleBanner]).
  final BannerAdType? adType;

  /// The amount of corner rounding for the banner ad.
  final double? borderRoundness;

  /// The background color used for the shimmer effect.
  final String? shimmerBackgroundColor;

  /// Whether to enable the shimmer effect for the banner ad.
  final bool? enableShimmerEffect;

  /// The color of the shimmer effect.
  final BannerShimmerColor? shimmerColor;

  /// Constructs a [BannerAdWidget].
  ///
  /// [adUnit] and [height] are required. All other parameters are optional.
  BannerAdWidget({
    required this.adUnit,
    required this.adType,
    required this.height,
    this.borderRoundness,
    this.shimmerBackgroundColor,
    this.enableShimmerEffect,
    this.shimmerColor,
  });

  /// The platform view type identifier for the banner ad.
  static const String viewType = 'bannerAd';

  @override
  Widget build(BuildContext context) {
    /// Determine the banner ad type as an integer.
    int type;
    switch (adType) {
      case BannerAdType.banner:
        type = 0;
        break;
      case BannerAdType.collapsibleBanner:
        type = 1;
        break;
      case null:
        type = -1;
    }

    /// Determine the shimmer color as an integer.
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
      padding: const EdgeInsets.all(3),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRoundness ?? 0),
        child: AndroidView(
          viewType: viewType,
          onPlatformViewCreated: (int id) {
            // Handle the platform view creation if needed.
          },
          layoutDirection: TextDirection.ltr,
          creationParams: <String, dynamic>{
            "enableShimmerEffect": enableShimmerEffect,
            "shimmerColor": color,
            "shimmerBackgroundColor": shimmerBackgroundColor,
            "adType": type, // Fixed the typo here (was "Type")
            "adUnit": adUnit,
          },
          creationParamsCodec: const StandardMessageCodec(),
        ),
      ),
    );
  }
}
