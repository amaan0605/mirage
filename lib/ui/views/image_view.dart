import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wallpaperhub/ui/widgets/viewPageButtonData.dart';

class ImageView extends StatefulWidget {
  final String imgUrl;
  ImageView({@required this.imgUrl});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            InteractiveViewer(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: CachedNetworkImage(
                  placeholder: (context, url) => GFLoader(
                    type: GFLoaderType.circle,
                    loaderColorOne: Colors.black,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  imageUrl: widget.imgUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 38.h, 85.h),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white70,
                ),
              ),
            ),
            ViewPageButtonData(
              imgURL: widget.imgUrl,
            ),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }
}
