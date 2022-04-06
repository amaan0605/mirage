import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:wallpaperhub/ui/views/image_view.dart';
import 'package:wallpaperhub/ui/widgets/widget.dart';

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

StreamBuilder<QuerySnapshot> fireBaseWallpaperGrid(
    {List wallpaper, BuildContext context, String query}) {
  return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection(query).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return Center(child: Text('Failed to load Wallpapers...'));

        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Center(
              child: GFLoader(
                type: GFLoaderType.circle,
              ),
            );

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
                        errorWidget: (context, url, error) => failedToLoad(),
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
