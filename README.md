# Firebase_Admob

**add maven in build.gradle**

````
allprojects {
	repositories {
		...
		maven { url 'https://jitpack.io' 
		}
	}
}
````
**How to use Firebase functionalities with default Crashlytics**
````
Must add 'google-services.json' file before application run

// In your setting.gradle file add

plugins {
    // Make sure that you have the AGP plugin 8.1+ dependency
    id("com.android.application") version "8.1.4" apply false

    // Make sure that you have the Google services Gradle plugin 4.4.1+ dependency
    id("com.google.gms.google-services") version "4.4.1" apply false

    // Add the dependency for the Crashlytics Gradle plugin
    id("com.google.firebase.crashlytics") version "3.0.1" apply false
}

//In your module (app-level) Gradle file add

plugins {
  // Make sure that you have the Google services Gradle plugin
  id("com.google.gms.google-services")

  // Add the Crashlytics Gradle plugin
  id("com.google.firebase.crashlytics")
}

After adding these dependencies Crashlytics and Firebase analytics added by default for built-in events of your app
````
**How to use Firebase custom events**
````
 fireEvent("AppOpenTotal") // max limit of character per event is 40
````
**How to use Firebase Messaging**
````
// add this in menefist under application tag
     <service
            android:name="com.mobi.pixels.firebase.Messaging"
            android:exported="false" >
            <intent-filter>
                <action android:name="com.google.firebase.MESSAGING_EVENT" />
            </intent-filter>
        </service>

// subscribeToTopic string is for fire notification on firebase with this topic name will immediate receive to user
//notificationIcon shows at the time of notification in app
// make sure you have post notification permission for android 13 and above

initializeFirebaseMessaging(subscribeToTopic)  //subscribeToTopic will be String i.o your app name
````
**How to use In-app review**
````
inAppReview() //it will work in release APK
````
**How to use In-app updates**
````
 updateApp(UpdateType.Force) //it will work in release APK
````
**How to use OpenAd**
````
 InitializeOpenAd(this@MyApplication,unitId,"Splash")        
````
**How to use Interstitial AD**
````
  final AdInterstitial ad = AdInterstitial();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((a) {
      ad.load("ca-app-pub-3940256099942544/1033173712");
    });
  }
  
   ElevatedButton(onPressed: ad.show, child: Text("Show")),
````
**How to use Native AD**
````
         NativeAdWidget(
              height: 120,
              borderRoundness: 5,
              adUnit: "ca-app-pub-3940256099942544/2247696110",
              adType: NativeAdType.NativeSmall,
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
````
**How to use Banner AD**
````
            BannerAdWidget(
              height: 100,
              borderRoundness: 5,
              adUnit: "ca-app-pub-3940256099942544/2014213617",
              adType: BannerAdType.CollapsibleBanner,
              enableShimmerEffect: true,
              shimmerColor: BannerShimmerColor.black,
              shimmerBackgroundColor: "#5EFF33D1",
            ),


