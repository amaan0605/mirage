import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wallpaperhub/data/adhelper.dart';
import 'package:wallpaperhub/ui/views/theme_mode.dart';
import 'package:wallpaperhub/ui/widgets/widget.dart';
import 'package:sizer/sizer.dart';
import 'package:async_wallpaper/async_wallpaper.dart';

//SET AS HOMESCREEN.....

class SetAsWallpapers extends StatefulWidget {
  SetAsWallpapers({this.imgURL});
  final String imgURL;
  @override
  _SetAsWallpapersState createState() => _SetAsWallpapersState();
}

class _SetAsWallpapersState extends State<SetAsWallpapers> {
  //For HomeScreen
  Future<void> setWallpaperFromFileAsHome() async {
    String result;
    var file = await DefaultCacheManager().getSingleFile(widget.imgURL);
    try {
      result = await AsyncWallpaper.setWallpaperFromFile(
          file.path, AsyncWallpaper.HOME_SCREEN);
    } on PlatformException {
      result = 'Failed to get wallpaper.';
      GFToast.showToast('Error Occured! Please Try Again...', context,
          toastDuration: 3);
    }
    if (!mounted) return;
  }

  //For LockScreen
  Future<void> setWallpaperFromFileAsLockScreen() async {
    String result;
    var file = await DefaultCacheManager().getSingleFile(widget.imgURL);
    try {
      result = await AsyncWallpaper.setWallpaperFromFile(
          file.path, AsyncWallpaper.LOCK_SCREEN);
      print(result);
    } on PlatformException {
      result = 'Failed to get wallpaper.';
      GFToast.showToast('Error Occured! Please Try Again...', context,
          toastDuration: 3);
    }
    if (!mounted) return;
  }

  //For BothScreen
  Future<void> setWallpaperFromFileAsBoth() async {
    String result;
    var file = await DefaultCacheManager().getSingleFile(widget.imgURL);
    try {
      result = await AsyncWallpaper.setWallpaperFromFile(
          file.path, AsyncWallpaper.BOTH_SCREENS);

      print(result);
    } on PlatformException {
      result = 'Failed to get wallpaper...';
      GFToast.showToast('Error Occured! Please Try Again...', context,
          toastDuration: 3);
    }
    if (!mounted) return;
  }

  InterstitialAd _interstitialAd;
  bool _isAdReady = false;
  _initAD() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: (err) {
          print(err);
        },
      ),
    );
  }

  void onAdLoaded(InterstitialAd ad) {
    _interstitialAd = ad;
    _isAdReady = true;
  }

  @override
  void initState() {
    _initAD();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      backgroundColor: Colors.transparent,
      enableDrag: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: currentTheme.isLightMode ? Colors.white : Colors.grey[900],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        height: 30.h,
        child: ListView(
          children: [
            ListTile(
              onTap: () => Navigator.pop(context),
              leading: pageButtonStyle(text: 'SET WALLPAPER AS:'),
              trailing: Icon(Icons.close_rounded),
            ),

            //HOMETILE
            ListTile(
              onTap: () {
                GFToast.showToast(
                    'Please Wait! Wallpaper Will be Set...', context,
                    toastDuration: 4);
                if (_isAdReady) {
                  _interstitialAd.show();
                }
                setWallpaperFromFileAsHome();
                Navigator.pop(context);
              },
              leading: Icon(
                Icons.home_filled,
                color: kMainColor,
              ),
              title: pageButtonStyle(text: 'HOME SCREEN'),
            ),

            //LOCKTILE
            ListTile(
              onTap: () {
                GFToast.showToast(
                    'Please Wait! Wallpaper Will be Set...', context,
                    toastDuration: 4);
                if (_isAdReady) {
                  _interstitialAd.show();
                }
                setWallpaperFromFileAsLockScreen();
                Navigator.pop(context);
              },
              leading: Icon(
                Icons.lock_open,
                color: kMainColor,
              ),
              title: pageButtonStyle(text: 'LOCK SCREEN'),
            ),

            //BOTHTILE
            ListTile(
              onTap: () {
                GFToast.showToast(
                    'Please Wait! Wallpaper Will be Set...', context,
                    toastDuration: 4);
                if (_isAdReady) {
                  _interstitialAd.show();
                }
                setWallpaperFromFileAsBoth();
                Navigator.pop(context);
              },
              leading: Icon(
                Icons.screen_lock_landscape,
                color: kMainColor,
              ),
              title: pageButtonStyle(text: 'BOTH SCREEN'),
            ),
          ],
        ),
      ),
      onClosing: () {},
    );
  }
}
