import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/getwidget.dart';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wallpaperhub/model/setAsWallpaper.dart';
import 'package:wallpaperhub/ui/views/theme_mode.dart';
import 'package:wallpaperhub/ui/widgets/viewPageButtons.dart';
import 'package:sizer/sizer.dart';
import 'package:wallpaperhub/ui/widgets/widget.dart';

class ViewPageButtonData extends StatefulWidget {
  ViewPageButtonData({this.imgURL});
  final String imgURL;
  @override
  _ViewPageButtonDataState createState() => _ViewPageButtonDataState();
}

class _ViewPageButtonDataState extends State<ViewPageButtonData> {
  //Varibales
  PermissionStatus status;
  var receiveData;

  _save() async {
    await _askPermission();

    var response = await Dio().get(widget.imgURL,
        options: Options(
          responseType: ResponseType.bytes,
          receiveTimeout: receiveData,
        ));

    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    GFToast.showToast('Saved In Gallery', context, toastDuration: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            backgroundColor:
                currentTheme.isLightMode ? kMainColor : Colors.grey[850],
            child: ViewPageButtons(
              onpressed: () {
                _save();
              },
              icon: Icon(
                FontAwesomeIcons.download,
                color: currentTheme.isLightMode ? kSecondaryColor : kMainColor,
                size: 12.sp,
              ),
            ),
          ),

          //SET AS BUTTON
          InkWell(
            onTap: () {
              showBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) =>
                      SetAsWallpaperAsHome(imgURL: widget.imgURL));
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 80),
              child: splashText(
                  text: 'SET AS',
                  color:
                      currentTheme.isLightMode ? kSecondaryColor : kMainColor,
                  size: 15.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: currentTheme.isLightMode ? kMainColor : Colors.grey[850],
              ),
            ),
          ),

          //FAVOURITE BUTTON
          CircleAvatar(
            backgroundColor:
                currentTheme.isLightMode ? kMainColor : Colors.grey[850],
            child: ViewPageButtons(
              icon: Icon(
                Icons.close,
                color: currentTheme.isLightMode ? kSecondaryColor : kMainColor,
              ),
              onpressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

//Permission Handler
void _askPermission() async {
  var status = await Permission.storage.status;
  print(status);
  if (!status.isGranted) {
    await Permission.storage.request();
  }
}
