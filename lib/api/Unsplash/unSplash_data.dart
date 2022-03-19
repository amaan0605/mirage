import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/getwidget.dart';
import 'package:wallpaperhub/ui/views/image_view.dart';

int perPage = 10;
const String apiID = 'erAT3ilt4B-hXs7EgwefwiHDe9diAT3u9lrBSWtnywY';
String unsplashUrl =
    'https://api.unsplash.com/search/photos?page=1&per_page=20&query=wallpaper&client_id=$apiID';
//https:api.unsplash.com/search/photos?page=$page&per_page=$per_page&query=${widget.keyword}&client_id=$client_id

//UNSPLASH API
Widget unsplashWallpaperData(var urlData, int itemcount) {
  return GridView.builder(
    padding: EdgeInsets.symmetric(horizontal: 16),
    shrinkWrap: true,
    physics: ClampingScrollPhysics(),
    itemCount: itemcount,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 9 / 16,
        crossAxisCount: 2,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6),
    itemBuilder: (context, i) => ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ImageView(imgUrl: urlData['results'][i]['urls']['full']),
              ));
        },
        child: Container(
          child: CachedNetworkImage(
            errorWidget: (context, url, error) => Center(
              child: Column(
                children: [
                  Icon(Icons.error_outline_sharp),
                  Text('Failed to load Walllpaper')
                ],
              ),
            ),
            placeholder: (context, url) => GFLoader(
              type: GFLoaderType.circle,
            ),
            imageUrl: urlData['results'][i]['urls']['regular'],
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}
