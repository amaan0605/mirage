import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:wallpaperhub/ui/screens/splashScreen/splash_screen.dart';
import 'package:wallpaperhub/ui/views/theme_mode.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static final String oneSignalId = '4c209f94-ebda-4bca-bab6-dd730afeed86';
  @override
  void initState() {
    initOneSignal();
    currentTheme.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  Future<void> initOneSignal() async {
    OneSignal.shared.setAppId(oneSignalId);
  }

  //Main Function
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mirage',
        theme: CustomTheme.lightTheme,
        darkTheme: CustomTheme.darkTheme,
        themeMode: currentTheme.currentTheme,
        home: SplashScreen(),
      );
    });
  }
}
