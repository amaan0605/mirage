import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

//Carousel Slider
Widget carouselSlider() {
  return CarouselSlider(
    items: [
      SliderData(
          url:
              'https://img.freepik.com/free-vector/colorful-palm-silhouettes-background_23-2148541792.jpg?size=626&ext=jpg'),
      SliderData(
          url:
              'https://images.unsplash.com/photo-1528819027803-5473f2bf7633?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8&w=1000&q=80'),
      SliderData(
          url:
              'https://images.pexels.com/photos/1274260/pexels-photo-1274260.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
      SliderData(
          url:
              'https://www.wallpapertip.com/wmimgs/79-796913_galaxy-wallpaper-hd-phone.jpg'),
    ],
    //Slider Container properties

    options: CarouselOptions(
      height: 150.0,
      enlargeCenterPage: true,
      autoPlay: false,
      aspectRatio: 16 / 9,
      autoPlayCurve: Curves.easeInCubic,
      enableInfiniteScroll: true,
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      viewportFraction: 0.8,
    ),
  );
}

//Carousel SLider Data
class SliderData extends StatelessWidget {
  final String url;
  SliderData({@required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        child: Center(
          child: Text(
            'BETA VERSION',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        margin: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
