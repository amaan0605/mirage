import 'package:flutter/material.dart';
import 'package:wallpaperhub/ui/widgets/navigation_bar.dart';
import 'package:wallpaperhub/ui/widgets/widget.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 120.0),
            child: SplashScreenView(
              navigateRoute: NavigationBar(),
              pageRouteTransition: PageRouteTransition.SlideTransition,
              imageSrc: 'images/splash_logo.png',
              imageSize: 250,
              textType: TextType.TyperAnimatedText,
              text: 'EVERYDAY SOMETHING NEW',
              textStyle: TextStyle(
                letterSpacing: 2,
                fontSize: 15.0,
                fontFamily: 'DancingScript',
                color: kMainColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
                alignment: Alignment.bottomCenter,
                child: splashText(
                    text: "THE ETHIX INC.", size: 10.0, color: kMainColor)),
          ),
        ],
      ),
    );
  }
}
