package com.example.mobipixels_flutter

import android.app.Activity
import android.util.Log
import com.mobi.pixels.adInterstitial.AdInterstitialLoadListeners
import com.mobi.pixels.adInterstitial.AdInterstitialShowListeners
import com.mobi.pixels.adInterstitial.Interstitial

object AdsInterstitial {

     fun loadInterstitial(activity: Activity, id: String){

        Interstitial.load(activity, id,object : AdInterstitialLoadListeners{
            override fun onFailedToLoad(error: String) {Log.d("fdsj4hg", "failed")}
            override fun onLoaded() {    Log.d("fdsj4hg", "loaded")}
            override fun onPreviousAdLoading() {Log.d("fdsj4hg", "loading")}

        })
    }

    fun showInterstitial(activity : Activity){
        Interstitial.show(activity, object : AdInterstitialShowListeners {
            override fun onDismissed() {     }
            override fun onError() { Log.d("fdsj4hg", "error")}
            override fun onShowed() {Log.d("fdsj4hg", "showed")}
        })
    }

}