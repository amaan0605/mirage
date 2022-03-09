import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

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
Widget pageButtonStyle({String text}) {
  return Text(
    text,
    style:
        GoogleFonts.lato(color: kSecondaryColor, fontWeight: FontWeight.bold),
  );
}
