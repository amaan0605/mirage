import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:wallpaperhub/api/FireBase/fireBaseData.dart';
import 'package:wallpaperhub/api/Pixels/pixelsData.dart';
import 'package:wallpaperhub/api/Unsplash/unSplash_data.dart';
import 'package:wallpaperhub/ui/screens/categories/category_data.dart';
import 'package:wallpaperhub/api/Pixels/wallpaper_model.dart';
import 'package:wallpaperhub/ui/widgets/loadMoreButton.dart';
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

    wallpaper.clear();
    var response = await http.get(
      Uri.parse(unsplashSearchUrl),
    );
    setState(() {
      unsplashSearchData = json.decode(response.body);
    });
  }

  getMoreSearchWallpaper(String query, int page) async {
    String _unsplashSearchUrl =
        'https://api.unsplash.com/search/photos?page=$page&per_page=30&query=$query&client_id=$apiID';

    wallpaper.clear();
    var response = await http.get(
      Uri.parse(_unsplashSearchUrl),
    );
    setState(() {
      unsplashMoreSearchData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    setState(() {
      getSearchWallpaper(widget.searchQuery, page);
      searchController.text = widget.searchQuery;
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
                ],
              ),
            ),
    );
  }

  void searchedPexelWallpaper(String query) async {
    var response = await http.get(
        Uri.parse(
            'https://api.pexels.com/v1/search?query=$query&orientation=portrait&page=$page&per_page=10'),
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
}
