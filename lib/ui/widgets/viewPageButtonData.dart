import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wallpaperhub/data/adhelper.dart';
import 'package:wallpaperhub/model/setAsWallpaper.dart';
import 'package:wallpaperhub/ui/views/theme_mode.dart';
import 'package:wallpaperhub/ui/widgets/viewPageButtons.dart';
import 'package:sizer/sizer.dart';
import 'package:wallpaperhub/ui/widgets/widget.dart';

class ViewPageButtonData extends StatefulWidget {
  ViewPageButtonData({this.imgURL});
  final String imgURL;
  @override
  _ViewPageButtonDataState createState() => _ViewPageButtonDataState();
}

class _ViewPageButtonDataState extends State<ViewPageButtonData> {
  //Varibales
  PermissionStatus status;
  var receiveData;
  InterstitialAd _interstitialAd;
  bool _isAdReady = false;

  Future<void> share() async {
    await FlutterShare.share(
        title: 'MIRAGE WALLPAPER',
        text:
            'HEY, TAKE A LOOK!!! I FOUND AWESOME WALLPAPER ON MIRAGE: WALLPAPER APP',
        linkUrl: widget.imgURL,
        chooserTitle: 'Share Wallpaper to...');
  }

  _save() async {
    // ignore: await_only_futures
    await _askPermission();

    var response = await Dio().get(widget.imgURL,
        options: Options(
          responseType: ResponseType.bytes,
          receiveTimeout: receiveData,
        ));

    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    GFToast.showToast('Saved In Gallery', context, toastDuration: 3);
  }

  void _initIntertitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: onAdLoaded,
          onAdFailedToLoad: (err) {
            print(err);
          }),
    );
  }

  void onAdLoaded(InterstitialAd ad) {
    _interstitialAd = ad;
    _isAdReady = true;
    _interstitialAd.fullScreenContentCallback =
        FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
      _interstitialAd.dispose();
    }, onAdFailedToShowFullScreenContent: (ad, err) {
      _interstitialAd.dispose();
    });
  }

  @override
  void initState() {
    _initIntertitialAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            backgroundColor:
                currentTheme.isLightMode ? kMainColor : Colors.grey[850],
            child: ViewPageButtons(
              onpressed: () {
                showAlertDialog(context, 'Downloading');
                _save();
                if (_isAdReady) {
                  _interstitialAd.show();
                }
              },
              icon: Icon(
                FontAwesomeIcons.download,
                color: currentTheme.isLightMode ? kSecondaryColor : kMainColor,
                size: 12.sp,
              ),
            ),
          ),

          //SET AS BUTTON
          InkWell(
            onTap: () {
              showBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => SetAsWallpapers(imgURL: widget.imgURL));
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 80),
              child: splashText(
                  text: 'SET AS',
                  color:
                      currentTheme.isLightMode ? kSecondaryColor : kMainColor,
                  size: 15.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: currentTheme.isLightMode ? kMainColor : Colors.grey[850],
              ),
            ),
          ),

          //FAVOURITE BUTTON
          CircleAvatar(
            backgroundColor:
                currentTheme.isLightMode ? kMainColor : Colors.grey[850],
            child: ViewPageButtons(
              icon: Icon(
                Icons.share_outlined,
                color: currentTheme.isLightMode ? kSecondaryColor : kMainColor,
              ),
              onpressed: () {
                share();
                if (_isAdReady) {
                  _interstitialAd.show();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

//Permission Handler
void _askPermission() async {
  var status = await Permission.storage.status;
  print(status);
  if (!status.isGranted) {
    await Permission.storage.request();
  }
}
