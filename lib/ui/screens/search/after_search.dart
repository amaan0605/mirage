import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wallpaperhub/data/category_data.dart';
import 'package:wallpaperhub/model/wallpaper_model.dart';
import 'package:wallpaperhub/ui/views/wallpaper_grid.dart';
import 'package:wallpaperhub/ui/widgets/widget.dart';

class Search extends StatefulWidget {
  final String searchQuery;
  Search({this.searchQuery});
  @override
  _SearchState createState() => _SearchState();
}

List<WallpaperModel> wallpaper = [];
TextEditingController searchController = TextEditingController();

class _SearchState extends State<Search> {
  getSearchWallpaper(String query) async {
    wallpaper.clear();
    var response = await get(
        Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=40"),
        headers: {"Authorization": apiKey});
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      WallpaperModel wallpaperModel = WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpaper.add(wallpaperModel);
    });
    setState(() {});
  }

  @override
  void initState() {
    setState(() {
      getSearchWallpaper(widget.searchQuery);
      searchController.text = widget.searchQuery;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            child: wallpaperGrid(wallpaper: wallpaper, context: context),
          ),
        ),
      ),
    );
  }
}
