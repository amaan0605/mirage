import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wallpaperhub/api/FireBase/fireBaseData.dart';
import 'package:wallpaperhub/data/adhelper.dart';
import 'package:wallpaperhub/ui/widgets/widget.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({this.query});
  final String query;
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List fireBaseWallpaper = [];
  BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  //ADMOB ADS
  _initBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.bannerAdUnitId,
      listener: BannerAdListener(onAdLoaded: (_) {
        setState(() {
          _isBannerAdReady = true;
        });
      }, onAdFailedToLoad: (ad, error) {
        print('Failed to load Banner ad: ${error.message}');
        _isBannerAdReady = false;
        ad.dispose();
      }),
      request: AdRequest(),
    );
    _bannerAd.load();
  }

  @override
  void initState() {
    _initBannerAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Scaffold(
        appBar: appBar(),
        body: fireBaseWallpaper == null
            ? GFLoader(
                type: GFLoaderType.circle,
              )
            : SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 10, right: 10, bottom: 10),
                        child: fireBaseWallpaperGrid(
                            wallpaper: fireBaseWallpaper,
                            context: context,
                            query: widget.query),
                      ),
                      if (_isBannerAdReady)
                        Container(
                          height: _bannerAd.size.height.toDouble(),
                          width: _bannerAd.size.width.toDouble(),
                          child: AdWidget(
                            ad: _bannerAd,
                          ),
                        ),
                      SizedBox(height: 10),
                      comingSoonContainer()
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
