import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:wallpaperhub/model/wallpaper_model.dart';
import 'package:wallpaperhub/ui/views/image_view.dart';

getID(var link) {
  var wallID = 'https://drive.google.com/uc?export=download&id=';
  var count = 0;
  for (int i = 0; i < link.length; i++) {
    if (link[i] == '/') {
      count++;
      continue;
    }
    if (count > 4 && count < 6) {
      wallID += link[i];
    }
  }
  return wallID;
}

StreamBuilder<QuerySnapshot> wallpaperGrid(
    {List<WallpaperModel> wallpaper, BuildContext context}) {
  return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Humour').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return Center(child: Text('Failed to load Wallpapers...'));

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: GFLoader(
                type: GFLoaderType.circle,
              ),
            );
          default:
            return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                var link = snapshot.data.docs[index]['link'];
                var _imageUrl = getID(link);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageView(imgUrl: _imageUrl),
                        ));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      child: CachedNetworkImage(
                        errorWidget: (context, url, error) => Row(
                          children: [
                            Icon(Icons.error_outline_outlined),
                            Text('Failder to Load Wallpaper...')
                          ],
                        ),
                        placeholder: (context, url) => GFLoader(
                          type: GFLoaderType.circle,
                        ),
                        imageUrl: _imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 6.0,
                crossAxisSpacing: 6.0,
                crossAxisCount: 2,
                childAspectRatio: 0.6,
              ),
            );
        }
      });
}

//Wallpaper Grid
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
