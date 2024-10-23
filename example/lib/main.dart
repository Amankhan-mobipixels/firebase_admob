
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mobi_firebase_admob/banner/banner_ad_type.dart';
import 'package:mobi_firebase_admob/banner/banner_ad_widget.dart';
import 'package:mobi_firebase_admob/banner/banner_shimmer_color.dart';
import 'package:mobi_firebase_admob/fire/firebase.dart';
import 'package:mobi_firebase_admob/inAppReview/in_app_review.dart';
import 'package:mobi_firebase_admob/initializeOpenAd/initialize_open_ad.dart';
import 'package:mobi_firebase_admob/interstitial/interstitial_ad.dart';

import 'package:mobi_firebase_admob/native/ad_Icon.dart';
import 'package:mobi_firebase_admob/native/native_ad_type.dart';
import 'package:mobi_firebase_admob/native/native_ad_widget.dart';
import 'package:mobi_firebase_admob/native/native_shimmer_color.dart';
import 'package:mobi_firebase_admob/updateApp/updateApp.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  final AdInterstitial ad = AdInterstitial();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((a) {
      ad.load("ca-app-pub-3940256099942544/1033173712");
      initializeFirebaseMessaging("mobi");
      initializeOpenAd("ca-app-pub-3940256099942544/9257395921","splash");
      inAppReview();
      updateApp();
    });
  }

  @override
  Widget build(BuildContext context) {
    fireEvent("screenOpen");
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Title"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(onPressed: ad.show, child: Text("Show")),
            // ElevatedButton(
            //     onPressed: () {
            //       ad.show();
            //     },
            //     child: Text("Show")),
            // NativeAdWidget(
            //   height: 120,
            //   borderRoundness: 5,
            //   adUnit: "ca-app-pub-3940256099942544/2247696110",
            //   adType: NativeAdType.NativeSmall,
            //   backgroundColor: "#FFFFECB3",
            //   buttonColor: "#FF3347FF",
            //   adIcon: AdIcon.black,
            //   buttonRoundness: 30,
            //   buttonHeight: 40,
            //   enableShimmerEffect: true,
            //   shimmerColor: NativeShimmerColor.black,
            //   textColorButton: "#F2F3E65E",
            //   shimmerBackgroundColor: "#5EFF33D1",
            // ),
            //
            // ),
            BannerAdWidget(
              height: 100,
              borderRoundness: 5,
              adUnit: "ca-app-pub-3940256099942544/2014213617",
              adType: BannerAdType.collapsibleBanner,
              enableShimmerEffect: true,
              shimmerColor: BannerShimmerColor.black,
              shimmerBackgroundColor: "#5EFF33D1",
            ),
            // BannerAdWidget(
            //   height: 100,
            //   borderRoundness: 5,
            //   adUnit: "ca-app-pub-3940256099942544/9214589741",
            //   adType: BannerAdType.Banner,
            //   enableShimmerEffect: true,
            //   shimmerColor: BannerShimmerColor.black,
            //   shimmerBackgroundColor: "#5EFF33D1",
            // ),
            NativeAdWidget(
              height: 120,
              borderRoundness: 5,
              adUnit: "ca-app-pub-3940256099942544/2247696110",
              adType: NativeAdType.nativeSmall,
              backgroundColor: "#FFFFECB3",
              buttonColor: "#FF3347FF",
              adIcon: AdIcon.black,
              buttonRoundness: 30,
              buttonHeight: 40,
              enableShimmerEffect: true,
              shimmerColor: NativeShimmerColor.black,
              textColorButton: "#F2F3E65E",
              shimmerBackgroundColor: "#5EFF33D1",
            ),
          ],
        ),
      ),
    );
  }
}