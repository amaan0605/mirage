import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/getwidget.dart';
import 'package:wallpaperhub/api/Pixels/pixelsData.dart';
import 'package:wallpaperhub/api/Unsplash/unSplash_data.dart';
import 'package:wallpaperhub/api/WallHaven/wallHavenData.dart';
import 'package:wallpaperhub/data/adhelper.dart';
import 'package:wallpaperhub/ui/screens/categories/category_data.dart';
import 'package:wallpaperhub/api/Pixels/wallpaper_model.dart';
import 'package:wallpaperhub/ui/screens/home/carousel_slider.dart';
import 'package:wallpaperhub/ui/widgets/loadMoreButton.dart';
import 'package:wallpaperhub/ui/widgets/widget.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

//HomeScreen Class
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  //Variables
  List<WallpaperModel> wallpaper = [];
  dynamic pexelWallpaper = [];
  int gridNumber = 1;
  int pageNumber = 1;
  int itemCount = 10;
  DateTime timeBackPress = DateTime.now();
  ScrollController scrollController = ScrollController();
  BannerAd _bannerAd;
  bool isBannerAdReady = false;

  //API DATA
  pexelWallpapers() async {
    var response = await http.get(Uri.parse(pexelURL), headers: {
      'Authorization': apiKey,
    });
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      WallpaperModel wallpaperModel = WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpaper.add(wallpaperModel);
    });
    if (this.mounted) {
      setState(() {});
    }
  }

//UNSPLASH DATA
  var unsplashData;
  unsplashWallpapers() async {
    var response = await http.get(
      Uri.parse(unsplashUrl),
    );
    setState(() {
      unsplashData = json.decode(response.body);
    });
  }

  var wallHavenData;
  wallHavenWallpaper() async {
    var res = await http.get(Uri.parse(wallHavenURL));
    setState(() {
      wallHavenData = json.decode(res.body);
    });
  }

  // Load More Wallpaper from API
  loadMorePexelWallpaper() async {
    var response = await http.get(
        Uri.parse(
            'https://api.pexels.com/v1/search?query=wallpaper&orientation=portrait&page=$pageNumber&per_page=10'),
        headers: {
          'Authorization': apiKey,
          'Content-Type': 'application/json',
          'Charset': 'utf-8'
        });
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData['photos'].forEach((element) {
      WallpaperModel wallpaperModal = WallpaperModel();
      wallpaperModal = WallpaperModel.fromMap(element);
      wallpaper.add(wallpaperModal);
    });
    setState(() {});
  }

  //OnWIllPop Function
  Future<bool> onWillPop() async {
    final differnce = DateTime.now().difference(timeBackPress);
    final isExitWarning = differnce >= Duration(seconds: 2);

    timeBackPress = DateTime.now();
    if (isExitWarning) {
      GFToast.showToast(
        'Press Again to Exit',
        context,
      );
      return false;
    } else {
      return exit(0);
    }
  }

  //INIT STATE FUNCTION
  @override
  void initState() {
    _initBannerAd();
    unsplashWallpapers();
    wallHavenWallpaper();
    pexelWallpapers();
    super.initState();
  }

  //ADMOB ADS
  _initBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.bannerAdUnitId,
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {
          isBannerAdReady = true;
        });
      }, onAdFailedToLoad: (ad, error) {
        print('Failed to load Banner ad: ${error.message}\n\n\n');

        ad.dispose();
      }),
      request: AdRequest(),
    );
    _bannerAd.load();
  }

  //SCAFFOLD OF APPLICATION
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //APPBAR
      appBar: appBar(),
      //FLOATING ACTION BUTTON
      floatingActionButton: floatingActionButton(),

      //BODY
      body: unsplashData == null || wallHavenData == null
          ? Center(
              child: GFLoader(
                type: GFLoaderType.circle,
              ),
            )
          : WillPopScope(
              onWillPop: onWillPop,
              child: SafeArea(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          height: 25.h,
                          child: carouselSlider(),
                        ),
                        //Main Heading
                        mainHeading('EXPLORE'),
                        SizedBox(
                          height: 3.h,
                        ),

                        unsplashWallpaperData(unsplashData, 20),
                        SizedBox(
                          height: 1.h,
                        ),
                        if (isBannerAdReady)
                          Container(
                            height: _bannerAd.size.height.toDouble(),
                            width: _bannerAd.size.width.toDouble(),
                            child: AdWidget(
                              ad: _bannerAd,
                            ),
                          ),
                        SizedBox(
                          height: 1.h,
                        ),
                        wallHavenWallpaperGrid(wallHavenData: wallHavenData),
                        SizedBox(
                          height: 1.h,
                        ),

                        pexelwallpaperGrid(
                            wallpaper: wallpaper, context: context),

                        // Load More Button
                        loadMoreButton(
                          onTap: () {
                            pageNumber++;
                            loadMorePexelWallpaper();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  //FLOATING ACTION BUTTON
  floatingActionButton() {
    return Padding(
        padding: EdgeInsets.only(bottom: 40),
        child: Opacity(
            opacity: 0.8,
            child: FloatingActionButton(
              tooltip: 'Scroll To Top',
              backgroundColor: kMainColor,
              elevation: 0,
              mini: true,
              child: Icon(
                Icons.arrow_drop_up,
                color: kSecondaryColor,
              ),
              onPressed: () {
                setState(() {
                  scrollController.animateTo(0,
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.linear);
                });
              },
            )));
  }
}
