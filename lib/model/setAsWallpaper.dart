import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:getwidget/getwidget.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';
import 'package:wallpaperhub/ui/widgets/widget.dart';
import 'package:sizer/sizer.dart';

//SET AS HOMESCREEN.....

class SetAsWallpaperAsHome extends StatefulWidget {
  SetAsWallpaperAsHome({this.imgURL});
  final String imgURL;
  @override
  _SetAsWallpaperAsHomeState createState() => _SetAsWallpaperAsHomeState();
}

class _SetAsWallpaperAsHomeState extends State<SetAsWallpaperAsHome> {
  //For HomeScreen
  Future<void> setWallpaperFromFileAsHome() async {
    String result;
    var file = await DefaultCacheManager().getSingleFile(widget.imgURL);
    try {
      result = await WallpaperManager.setWallpaperFromFile(
          file.path, WallpaperManager.HOME_SCREEN);
      print(result);
      if (mounted) {
        GFToast.showToast('Wallpaper Set!!!', context, toastDuration: 3);
      }
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
      result = await WallpaperManager.setWallpaperFromFile(
          file.path, WallpaperManager.LOCK_SCREEN);
      print(result);
      GFToast.showToast('Wallpaper Set!!!', context, toastDuration: 3);
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
      result = await WallpaperManager.setWallpaperFromFile(
          file.path, WallpaperManager.BOTH_SCREENS);
      GFToast.showToast('Wallpaper Set!!!', context, toastDuration: 3);
      print(result);
    } on PlatformException {
      result = 'Failed to get wallpaper.';
      GFToast.showToast('Error Occured! Please Try Again...', context,
          toastDuration: 3);
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      backgroundColor: Colors.transparent,
      enableDrag: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
