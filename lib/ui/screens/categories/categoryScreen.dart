import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/getwidget.dart';
import 'package:wallpaperhub/api/FireBase/fireBaseData.dart';
import 'package:wallpaperhub/ui/screens/search/after_search.dart';
import 'package:wallpaperhub/ui/widgets/widget.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({this.query});
  final String query;
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List fireBaseWallpaper = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Scaffold(
        appBar: appBar(),
        body: fireBaseWallpaper.isNotEmpty
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
                      comingSoonContainer()
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
