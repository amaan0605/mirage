import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:wallpaperhub/data/adhelper.dart';
import 'package:wallpaperhub/ui/screens/categories/category_data.dart';
import 'package:wallpaperhub/ui/screens/categories/categories_model.dart';
import 'package:wallpaperhub/api/Pixels/wallpaper_model.dart';
import 'package:wallpaperhub/ui/widgets/widget.dart';

class Categories extends StatefulWidget {
  final String categorieName;
  Categories({this.categorieName});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<CategoriesModel> categories = [];
  List<WallpaperModel> wallpaper = [];
  ScrollController _controller = ScrollController();
  BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  //ADMOB ADS
  _initBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.largeBanner,
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
    categories = getCategories();
    _initBannerAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 3.h,
              ),
              mainHeading('CATEGORIES'),
              SizedBox(
                height: 2.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                width: double.infinity,
                child: ListView.builder(
                    controller: _controller,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoriesTile(
                          imgUrl: categories[index].imgUrl,
                          title: categories[index].categoriesName);
                    }),
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
            ],
          ),
        ),
      ),
    );
  }
}
