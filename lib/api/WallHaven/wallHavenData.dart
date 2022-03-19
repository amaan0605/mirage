import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/getwidget.dart';
import 'package:wallpaperhub/ui/views/image_view.dart';

const wallHavenApiKey = 'P1IzsYnxxvAqk8Zq0jGn5TbWYOvun4It';
String wallHavenURL =
    'https://wallhaven.cc/api/v1/search?apikey=$wallHavenApiKey&per_page=24&page=1&purity=100&categories=100&sorting=toplist';

Widget wallHavenWallpaperGrid({var wallHavenData}) {
  return GridView.builder(
    padding: EdgeInsets.symmetric(horizontal: 16),
    physics: ClampingScrollPhysics(),
    shrinkWrap: true,
    itemCount: 24,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 9 / 16,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6),
    itemBuilder: (context, i) => GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ImageView(imgUrl: wallHavenData['data'][i]['path']),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          child: CachedNetworkImage(
            errorWidget: (context, url, error) => Icon(Icons.error),
            placeholder: (context, url) => GFLoader(
              type: GFLoaderType.circle,
            ),
            imageUrl: wallHavenData["data"][i]['path'],
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}
