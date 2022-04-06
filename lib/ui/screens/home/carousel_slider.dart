import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaperhub/ui/widgets/widget.dart';

/* welcome to Mirage
new wallpaper(new page)
what's in your mind(search page)
rate us(play store)
help us to improve(google form)*/

//<a href="https://www.vecteezy.com/free-vector/mirage">Mirage Vectors by Vecteezy</a>

//Carousel Slider
Widget carouselSlider() {
  return CarouselSlider(
    items: [
      SliderData(
          size: 20.sp,
          onTap: () {},
          title: 'Welcome to \nMIRAGE',
          source: 'images/mirage2.jpg'),
      SliderData(
          onTap: () {},
          title: 'New Wallpapers\nEveryday',
          source: 'images/mirage.jpg'),
      SliderData(
          onTap: () {},
          title: 'Rate us on\nPlaystore',
          source: 'images/mirage4.jpg'),
      SliderData(
          onTap: () {
            _luanchUrl();
          },
          title: 'Help us to improve\nMIRAGE',
          source: 'images/mirage3.jpg'),
    ],
    //Slider Container properties

    options: CarouselOptions(
      height: 150.0,
      enlargeCenterPage: true,
      autoPlay: false,
      aspectRatio: 16 / 9,
      autoPlayCurve: Curves.easeInCubic,
      enableInfiniteScroll: true,
      autoPlayAnimationDuration: Duration(milliseconds: 500),
      viewportFraction: 0.8,
    ),
  );
}

//Carousel SLider Data
class SliderData extends StatelessWidget {
  final String source;
  final String title;
  final Function onTap;
  final double size;
  SliderData(
      {@required this.source,
      @required this.onTap,
      this.title,
      this.size,
      BuildContext context});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Stack(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3.0,
                    fontSize: 13.sp),
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kMainColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3.0,
                ),
              )
            ],
          ),
        ),
        margin: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
            image: AssetImage(source),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

_luanchUrl() async {
  const String url = 'https://forms.gle/7NYdGuGBWa66b13e6';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not $url';
  }
}
