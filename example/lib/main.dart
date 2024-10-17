import 'package:mobi_firebase_admob/banner/BannerAdType.dart';
import 'package:mobi_firebase_admob/banner/BannerAdWidget.dart';
import 'package:mobi_firebase_admob/banner/BannerShimmerColor.dart';
import 'package:flutter/material.dart';
import 'package:mobi_firebase_admob/interstitial/InterstitialAd.dart';
import 'package:flutter/scheduler.dart';

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
    });
  }

  @override
  Widget build(BuildContext context) {
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
              adType: BannerAdType.CollapsibleBanner,
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
          ],
        ),
      ),
    );
  }
}