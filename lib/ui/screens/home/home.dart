import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaperhub/api/WallHaven/wallHaven_data.dart';
import 'package:wallpaperhub/data/category_data.dart';
import 'package:wallpaperhub/model/wallpaper_model.dart';
import 'package:wallpaperhub/ui/screens/home/carousel_slider.dart';
import 'package:wallpaperhub/ui/views/wallpaper_grid.dart';
import 'package:wallpaperhub/ui/widgets/widget.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import 'package:wallpaperhub/api/WallHaven/wallhaven_modal.dart';

//HomeScreen Class
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  //Variables
  List<WallpaperModel> wallpaper = [];
  List<WallHavenModal> pexelWallpaper = [];
  int pageNumber = 1;
  DateTime timeBackPress = DateTime.now();
  ScrollController scrollController = ScrollController();
  // //API DATA
  // getTrendingWallpaper() async {
  //   var response = await http.get(
  //       Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
  //       headers: {
  //         'Authorization': apiKey,
  //         'Content-Type': 'application/json',
  //         'Charset': 'utf-8'
  //       });
  //   Map<String, dynamic> jsonData = jsonDecode(response.body);
  //   jsonData["photos"].forEach((element) {
  //     WallpaperModel wallpaperModel = WallpaperModel();
  //     wallpaperModel = WallpaperModel.fromMap(element);
  //     wallpaper.add(wallpaperModel);
  //   });
  //   if (this.mounted) {
  //     setState(() {});
  //   }
  // }

  //Load More Wallpaper from API
  loadMoreWallpaper() async {
    var response = await http.get(
        Uri.parse(
            'https://api.pexels.com/v1/curated?page=$pageNumber&per_page=20'),
        headers: {'Authorization': apiKey});
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData['photos'].forEach((element) {
      WallpaperModel wallpaperModal = WallpaperModel();
      wallpaperModal = WallpaperModel.fromMap(element);
      wallpaper.add(wallpaperModal);
    });
    setState(() {});
  }

  unsplashWallpaper() async {
    var response = await http.get(
      Uri.parse(
          'https://api.unsplash.com/photos/?client_id=erAT3ilt4B-hXs7EgwefwiHDe9diAT3u9lrBSWtnywY'),
    );
    print(response);
    if (response == null) {
      print('response is null\n\n\n\n');
    } else {
      Map<String, dynamic> wallData = jsonDecode(response.body);
      print(wallData);
    }
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
    unsplashWallpaper();
    wallpaperGrid();
    loadMoreWallpaper();
    super.initState();
  }

  //SCAFFOLD OF APPLICATION
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //APPBAR
      appBar: appBar(),
      //FLOATING ACTION BUTTON
      floatingActionButton: Padding(
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
          ),
        ),
      ),

      //BODY
      body: WillPopScope(
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

                  // Wallpaper Grid
                  wallpaperGrid(
                    wallpaper: wallpaper,
                    context: context,
                  ),
                  SizedBox(height: 6.0),
                  pexelwallpaperGrid(wallpaper: wallpaper, context: context),

                  // Load More Button
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey[700])),
                    onPressed: () {
                      pageNumber++;
                      loadMoreWallpaper();
                    },
                    child: Text(
                      '     Load More...      ',
                      style: GoogleFonts.lato(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
