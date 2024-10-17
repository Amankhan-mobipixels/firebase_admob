package com.example.mobi_firebase_admob

import com.example.mobipixels_flutter.LoadBannerAd
import com.example.mobipixels_flutter.LoadNativeAd
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import com.example.mobipixels_flutter.AdsInterstitial.loadInterstitial
import com.example.mobipixels_flutter.AdsInterstitial.showInterstitial
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import android.app.Activity
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

class MobiFirebaseAdmobPlugin:FlutterPlugin, MethodCallHandler, ActivityAware {
  private lateinit var channel : MethodChannel
  private var activity: Activity? = null
  private var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    this.flutterPluginBinding = flutterPluginBinding
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "firebase_admob")
    channel.setMethodCallHandler(this)

  }

  override fun onMethodCall(call: MethodCall, result: Result) {

    when (call.method) {
      "loadInterstitial" -> {
        val id = call.argument<String>("id") ?: ""
        loadInterstitial(activity!!,id)
      }
      "showInterstitial" -> {
        showInterstitial(activity!!)

      }
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    flutterPluginBinding = null
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity

    flutterPluginBinding!!.platformViewRegistry.registerViewFactory("nativeAd", LoadNativeAd.Factory(activity!!))
    flutterPluginBinding!!.platformViewRegistry.registerViewFactory("bannerAd", LoadBannerAd.Factory(activity!!))
  }

  override fun onDetachedFromActivity() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }
}




//
//import io.flutter.embedding.android.FlutterActivity
//import io.flutter.plugin.common.MethodChannel
//import io.flutter.embedding.engine.FlutterEngine
//
//
//
//
//class MainActivity: FlutterActivity() {
//  private val CHANNEL = "com.example.mobipixels_flutter"
//
//  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//    super.configureFlutterEngine(flutterEngine)
//
//    // Set up the MethodChannel using flutterEngine
//    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
//      when (call.method) {
//        "loadInterstitial" -> {
//          val id = call.argument<String>("id") ?: ""
//          loadInterstitial(this,id)
//        }
//        "showInterstitial" -> {
//          showInterstitial(this)
//        }
//      }
//    }
//
//    flutterEngine.platformViewsController.registry.registerViewFactory("nativeAd", LoadNativeAd.Factory(this))
//    flutterEngine.platformViewsController.registry.registerViewFactory("bannerAd", LoadBannerAd.Factory(this))
//  }
//
//
//}
