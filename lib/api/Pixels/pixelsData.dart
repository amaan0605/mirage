import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:wallpaperhub/api/Pixels/wallpaper_model.dart';
import 'package:wallpaperhub/ui/views/image_view.dart';

String pexelURL =
    'https://api.pexels.com/v1/search?query=wallpaper&orientation=portrait&per_page=10';

Widget pexelwallpaperGrid({List<WallpaperModel> wallpaper, context}) {
  return GridView.count(
    padding: EdgeInsets.symmetric(horizontal: 16),
    shrinkWrap: true,
    physics: ClampingScrollPhysics(),
    crossAxisCount: 2,
    mainAxisSpacing: 6.0,
    crossAxisSpacing: 6.0,
    childAspectRatio: 0.6,
    children: wallpaper.map((wallpaper) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImageView(
                imgUrl: wallpaper.src.large2x,
              ),
            ),
          );
        },
        child: Container(
          child: GridTile(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                child: CachedNetworkImage(
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  placeholder: (context, url) => Center(
                      child: GFLoader(
                    type: GFLoaderType.circle,
                  )),
                  imageUrl: wallpaper.src.portrait,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      );
    }).toList(),
  );
}
