package com.example.mobipixels_flutter
import android.app.Activity
import android.content.Context
import android.view.ViewGroup
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import io.flutter.plugin.common.StandardMessageCodec
import android.widget.FrameLayout
import android.util.Log

import com.mobi.pixels.adNativeOnDemand.AdNativeOnDemandListeners
import com.mobi.pixels.adNativeOnDemand.loadOnDemandNativeAd
import com.mobi.pixels.enums.NativeAdIcon
import com.mobi.pixels.enums.NativeAdType
import com.mobi.pixels.enums.ShimmerColor

class LoadNativeAd(context: Context, private val activity: Activity, args: Map<String, Any>?) : PlatformView {

        private val frameLayout = FrameLayout(context)

    // Declare variables to hold the parameter values
    private var setBackgroundColor: String? = null
    private var setTextColorButton: String? = null
    private var setButtonColor: String? = null
    private var setButtonRoundness: Int? = null
    private var setButtonHeight: Int? = null
    private var setAdIcon: Int? = null
    private var enableShimmerEffect: Boolean? = null
    private var setShimmerColor: Int? = null
    private var setShimmerBackgroundColor: String? = null
    private var adType: Int? = null
    private var adUnit: String? = null

    init {
        setBackgroundColor = args?.get("backgroundColor") as? String
        setTextColorButton = args?.get("textColorButton") as? String
        setButtonColor = args?.get("buttonColor") as? String
        setButtonRoundness = args?.get("buttonRoundness") as? Int
        setButtonHeight = args?.get("buttonHeight") as? Int
        setAdIcon = args?.get("adIcon") as? Int // 0 = black, 1 = white
        enableShimmerEffect = args?.get("enableShimmerEffect") as? Boolean
        setShimmerColor = args?.get("shimmerColor") as? Int // 0 = black, 1 = white, 2 = grey
        setShimmerBackgroundColor = args?.get("shimmerBackgroundColor") as? String
        adType = args?.get("adType") as? Int // 0 = NativeSmall, 1 = NativeAdvance
        adUnit = args?.get("adUnit") as? String

        frameLayout.layoutParams = FrameLayout.LayoutParams(
            ViewGroup.LayoutParams.WRAP_CONTENT,
            ViewGroup.LayoutParams.MATCH_PARENT
        )
        showNativeSmallActivities()
    }
        override fun getView(): FrameLayout { return frameLayout }
        override fun dispose() {  }

    private fun showNativeSmallActivities() {
        var type :NativeAdType? = null
        when(adType){
            0-> type= NativeAdType.NativeSmall
            1-> type =NativeAdType.NativeAdvance
        }


        val adBuilder = loadOnDemandNativeAd(activity, frameLayout, adUnit!!, type!!)

        // Apply parameters only if they are not null
        setBackgroundColor?.let { adBuilder.setBackgroundColor(it) }
        setTextColorButton?.let { adBuilder.setTextColorButton(it) }
        setButtonColor?.let { adBuilder.setButtonColor(it) }
        setButtonRoundness?.let { adBuilder.setButtonRoundness(it) }
        setButtonHeight?.let { adBuilder.setButtonHeight(it) }

        // For adIcon, use a condition to handle the 0 or 1 value
        when (setAdIcon) {
            0 -> adBuilder.setAdIcon(NativeAdIcon.Black)
            1 -> adBuilder.setAdIcon(NativeAdIcon.White)
        }

        // If shimmer effect is enabled, apply the shimmer settings
        enableShimmerEffect?.let {
            if (it) {
                adBuilder.enableShimmerEffect(true)
                setShimmerBackgroundColor?.let { color -> adBuilder.setShimmerBackgroundColor(color) }
                when (setShimmerColor) {
                        0 -> adBuilder.setShimmerColor(ShimmerColor.Black)
                        1 -> adBuilder.setShimmerColor(ShimmerColor.White)
                        2 -> adBuilder.setShimmerColor(ShimmerColor.Gray)
                }
            }
        }


        // Add ad listeners and load the ad
        adBuilder.adListeners(object : AdNativeOnDemandListeners {
            override fun onAdLoaded() {
                // Handle ad loaded event
            }

            override fun onAdFailedToLoad(error: String) {
                // Handle ad load failure
            }
        }).load()
    }
        internal class Factory(private val activity: Activity) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
            override fun create(context: Context, id: Int, args: Any?): PlatformView {
                return LoadNativeAd(context, activity, args as? Map<String, Any>)
            }
        }
    }