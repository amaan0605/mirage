import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wallpaperhub/data/adhelper.dart';
import 'package:wallpaperhub/ui/views/theme_mode.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sizer/sizer.dart';
import 'package:wallpaperhub/data/socialMedia_URL.dart';
import 'package:wallpaperhub/ui/widgets/widget.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool themeSwitch = false;
  RewardedAd _rewardedAd;
  bool _isAdReady = false;

  _initRewardAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: onAdLoaded,
          onAdFailedToLoad: (err) {
            print(err);
          }),
    );
  }

  void onAdLoaded(RewardedAd ad) {
    _rewardedAd = ad;
    _isAdReady = true;
    _rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) => _rewardedAd.dispose(),
      onAdFailedToShowFullScreenContent: (ad, error) => _rewardedAd.dispose(),
    );
  }

  @override
  void initState() {
    _initRewardAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: currentTheme.isLightMode
                ? kSecondaryColor
                : Colors.grey.shade800,
            height: 40.h,
            child: Center(
              child: Image(
                image: AssetImage('images/splash_logo.png'),
                height: 40.h,
                width: 40.h,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              currentTheme.isLightMode
                  ? Text(
                      'LIGHT MODE',
                      style: GoogleFonts.oswald(
                        fontSize: 15.sp,
                      ),
                    )
                  : Text(
                      'DARK MODE',
                      style: GoogleFonts.oswald(fontSize: 15.sp),
                    ),
              Switch(
                  inactiveThumbColor: Colors.black,
                  activeColor:
                      currentTheme.isLightMode ? kSecondaryColor : kMainColor,
                  value: themeSwitch,
                  onChanged: (value) {
                    setState(() {
                      currentTheme.toggleMode();
                      themeSwitch = value;
                    });
                  }),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'FOLLOW US ON',
                  style: GoogleFonts.lato(
                      fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          GFButton(
            onPressed: () {
              launchURL('instagram');
            },
            text: "INSTAGRAM",
            color: Colors.pink[400],
            icon: Icon(
              FontAwesomeIcons.instagram,
              color: Colors.white,
            ),
            type: GFButtonType.solid,
            blockButton: true,
          ),
          GFButton(
            onPressed: () {
              launchURL('facebook');
            },
            text: "FACEBOOK",
            icon: Icon(
              FontAwesomeIcons.facebook,
              color: Colors.white,
            ),
            type: GFButtonType.solid,
            blockButton: true,
          ),
          GFButton(
            onPressed: () {
              launchURL('twitter');
            },
            text: "TWITTER",
            color: Colors.blue,
            icon: Icon(
              FontAwesomeIcons.twitter,
              color: Colors.white,
            ),
            type: GFButtonType.solid,
            blockButton: true,
          ),
          GFButton(
            onPressed: () {
              launchURL('youtube');
            },
            text: "YOUTUBE",
            color: Colors.red[600],
            icon: Icon(
              FontAwesomeIcons.youtube,
              color: Colors.white,
            ),
            type: GFButtonType.solid,
            blockButton: true,
          ),
          TextButton(
            onPressed: () {
              if (_isAdReady) {
                _rewardedAd.show(
                  onUserEarnedReward: GFToast.showToast(
                      'Thanks for Supporing Us', context,
                      toastDuration: 3),
                );
              }
            },
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all<Size>(Size(40.5.h, 10)),
              backgroundColor: MaterialStateProperty.all<Color>(kMainColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 6),
                  child: Icon(
                    Icons.support,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'SUPPORT US',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            'Made With ❤️',
            style: GoogleFonts.oswald(fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
