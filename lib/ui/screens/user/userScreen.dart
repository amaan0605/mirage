import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaperhub/ui/views/theme_mode.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sizer/sizer.dart';
import 'package:wallpaperhub/data/socialMedia_URL.dart';
import 'package:wallpaperhub/ui/widgets/widget.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool themeSwitch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: currentTheme.isLightMode
                ? kSecondaryColor
                : Colors.grey.shade800,
            height: 40.h,
            child: Center(
              child: Image(
                image: AssetImage('images/splash_logo.png'),
                height: 40.h,
                width: 40.h,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              currentTheme.isLightMode
                  ? Text(
                      'LIGHT MODE',
                      style: GoogleFonts.oswald(
                        fontSize: 15.sp,
                      ),
                    )
                  : Text(
                      'DARK MODE',
                      style: GoogleFonts.oswald(fontSize: 15.sp),
                    ),
              Switch(
                  inactiveThumbColor: Colors.black,
                  activeColor:
                      currentTheme.isLightMode ? kSecondaryColor : kMainColor,
                  value: themeSwitch,
                  onChanged: (value) {
                    setState(() {
                      currentTheme.toggleMode();
                      themeSwitch = value;
                    });
                  }),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'FOLLOW US ON',
                  style: GoogleFonts.lato(
                      fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          GFButton(
            onPressed: () {
              launchURL('instagram');
            },
            text: "INSTAGRAM",
            color: Colors.pink[400],
            icon: Icon(
              FontAwesomeIcons.instagram,
              color: Colors.white,
            ),
            type: GFButtonType.solid,
            blockButton: true,
          ),
          GFButton(
            onPressed: () {
              launchURL('facebook');
            },
            text: "FACEBOOK",
            icon: Icon(
              FontAwesomeIcons.facebook,
              color: Colors.white,
            ),
            type: GFButtonType.solid,
            blockButton: true,
          ),
          GFButton(
            onPressed: () {
              GFToast.showToast('THANKS FOR TESTING', context,
                  toastPosition: GFToastPosition.BOTTOM,
                  backgroundColor: GFColors.FOCUS);
            },
            text: "TWITTER",
            color: Colors.blue,
            icon: Icon(
              FontAwesomeIcons.twitter,
              color: Colors.white,
            ),
            type: GFButtonType.solid,
            blockButton: true,
          ),
          GFButton(
            onPressed: () {
              GFToast.showToast('THANKS FOR TESTING', context,
                  toastPosition: GFToastPosition.BOTTOM,
                  backgroundColor: GFColors.FOCUS);
            },
            text: "YOUTUBE",
            color: Colors.red[600],
            icon: Icon(
              FontAwesomeIcons.youtube,
              color: Colors.white,
            ),
            type: GFButtonType.solid,
            blockButton: true,
          ),
          SizedBox(
            height: 3.h,
          ),
          Text(
            'Made With ❤️',
            style: GoogleFonts.oswald(fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
