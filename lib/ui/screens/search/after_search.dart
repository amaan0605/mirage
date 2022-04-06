import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaperhub/api/Unsplash/unSplash_data.dart';
import 'package:wallpaperhub/api/Pixels/wallpaper_model.dart';
import 'package:wallpaperhub/data/adhelper.dart';
import 'package:wallpaperhub/ui/widgets/widget.dart';

class AfterSearchScreen extends StatefulWidget {
  final String searchQuery;
  AfterSearchScreen({this.searchQuery});
  @override
  _AfterSearchScreenState createState() => _AfterSearchScreenState();
}

List<WallpaperModel> wallpaper = [];
int page = 1;
var unsplashSearchData;
var unsplashMoreSearchData;
TextEditingController searchController = TextEditingController();

class _AfterSearchScreenState extends State<AfterSearchScreen> {
  getSearchWallpaper(String query, int page) async {
    String unsplashSearchUrl =
        'https://api.unsplash.com/search/photos?page=1&per_page=30&query=$query&client_id=$apiID';

    var response = await http.get(
      Uri.parse(unsplashSearchUrl),
    );
    setState(() {
      unsplashSearchData = json.decode(response.body);
    });
  }

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
    setState(() {
      getSearchWallpaper(widget.searchQuery, page);
      searchController.text = widget.searchQuery;
      _initBannerAd();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: unsplashSearchData == null
          ? Center(
              child: GFLoader(
                type: GFLoaderType.circle,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 15),
                    child: Container(
                      child: unsplashWallpaperData(unsplashSearchData, 30),
                    ),
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
    );
  }
}
