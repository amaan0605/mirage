import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:wallpaperhub/ui/views/theme_mode.dart';

//CONSTANTS
const Color kMainColor = Color(0xFFf5a285);
const Color kSecondaryColor = Color(0xFF3a0064);

//HEAD TITLE
Widget mainHeading(String heading) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        width: double.infinity,
        height: 4.h,
        color: Colors.black12,
      ),
      Text(
        heading,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 15.sp, fontFamily: 'DancingScript', color: kMainColor),
      ),
    ],
  );
}

//APPBAR IMAGE
Widget brandImage() {
  return Center(
    child: Container(
      height: 50,
      child: Image(
        image: AssetImage('images/appbar_logo.png'),
      ),
    ),
  );
}

//APPBAR
Widget appBar() {
  return AppBar(
    excludeHeaderSemantics: true,
    title: brandImage(),
    automaticallyImplyLeading: false,
    centerTitle: true,
    elevation: 0.0,
  );
}

//SplashScreen TextStyle
Widget splashText({@required String text, double size, Color color}) {
  return Text(
    text,
    style: TextStyle(
      letterSpacing: 2,
      fontSize: size,
      fontFamily: 'DancingScript',
      color: color,
    ),
  );
}

//STYLING OF SET AS WALLPAPER BUTTON
Widget pageButtonStyle({String text, double fontSize}) {
  return Text(
    text,
    style: GoogleFonts.lato(
        color: currentTheme.isLightMode ? kSecondaryColor : kMainColor,
        fontWeight: FontWeight.bold,
        fontSize: fontSize),
  );
}

//COMING SOON
Widget comingSoonContainer() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0, left: 22, right: 22),
    child: Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('images/mirage3.jpg'),
              ),
            ),
          ),
        ),
        Center(
          child: Text(
            'COMING SOON...',
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}

//Failed To load Image

Widget failedToLoad() {
  return Center(
    child: Column(
      children: [
        Icon(Icons.error_outline_sharp),
        Text(
          'Failed to load Walllpaper\nRelaunch the Page',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )
      ],
    ),
  );
}

showAlertDialog(BuildContext context, String screen) {
  // set up the button
  Widget okButton = TextButton(
    child: Text(
      "OK",
      style: TextStyle(
          color: currentTheme.isLightMode ? kSecondaryColor : kMainColor),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: currentTheme.isLightMode ? kMainColor : Colors.grey[900],
    title: Text(
      "Please Wait...",
      style: TextStyle(
          color: currentTheme.isLightMode ? kSecondaryColor : kMainColor),
    ),
    content: Text(
      "Wallpaper is $screen!!!",
      style: TextStyle(
          color: currentTheme.isLightMode ? kSecondaryColor : kMainColor),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
