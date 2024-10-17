package com.example.mobipixels_flutter
import android.app.Activity
import android.content.Context
import android.view.ViewGroup
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import io.flutter.plugin.common.StandardMessageCodec
import android.widget.FrameLayout
import android.util.Log
import com.mobi.pixels.enums.ShimmerColor
import com.mobi.pixels.enums.BannerAdType
import com.mobi.pixels.adBannerOnDemand.loadOnDemandBannerAd
import com.mobi.pixels.adBannerOnDemand.AdBannerOnDemandListeners

class LoadBannerAd(context: Context, private val activity: Activity,args: Map<String, Any>?) : PlatformView {

        private val frameLayout = FrameLayout(context)

    // Declare variables to hold the parameter values
    private var enableShimmerEffect: Boolean? = null
    private var setShimmerColor: Int? = null
    private var setShimmerBackgroundColor: String? = null
    private var adType: Int? = null
    private var adUnit: String? = null

    init {
        enableShimmerEffect = args?.get("enableShimmerEffect") as? Boolean
        setShimmerColor = args?.get("shimmerColor") as? Int // 0 = black, 1 = white, 2 = grey
        setShimmerBackgroundColor = args?.get("shimmerBackgroundColor") as? String
        adType = args?.get("adType") as? Int // 0 = banner, 1 = collapsibleBanner
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
        var type :BannerAdType? = null
        when(adType){
            0-> type= BannerAdType.Banner
            1-> type =BannerAdType.CollapsibleBanner
        }

        val adBuilder = loadOnDemandBannerAd(activity, frameLayout, adUnit!!, type!!)

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
        adBuilder.adListeners(object : AdBannerOnDemandListeners {
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
                return LoadBannerAd(context, activity, args as? Map<String, Any>)
            }
        }
    }