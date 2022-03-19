import 'package:flutter/material.dart';
import 'package:wallpaperhub/api/Pixels/wallpaper_model.dart';
import 'package:wallpaperhub/ui/screens/search/after_search.dart';
import 'package:wallpaperhub/ui/views/theme_mode.dart';
import 'package:wallpaperhub/ui/widgets/widget.dart';
import 'package:sizer/sizer.dart';

class SearchScreen extends StatefulWidget {
  final String searchQuery;
  SearchScreen({this.searchQuery});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

List<WallpaperModel> wallpaper = [];
TextEditingController searchController = TextEditingController();

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Container(
              decoration: BoxDecoration(
                color: kMainColor,
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                          hintText: 'search wallpaper',
                          border: InputBorder.none),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AfterSearchScreen(
                            searchQuery: searchController.text,
                          ),
                        ),
                      );
                    },
                    child: Icon(Icons.search),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 24.h),
            child: Container(
              child: Center(
                child: Column(
                  children: [
                    Image(
                      height: 40.sp,
                      width: 40.sp,
                      image: AssetImage(
                        'images/search.png',
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      'Search Something Creative...',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: 'DancingScript',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
