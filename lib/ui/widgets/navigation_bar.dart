import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:wallpaperhub/ui/screens/categories/category.dart';
import 'package:wallpaperhub/ui/screens/home/home.dart';
import 'package:wallpaperhub/ui/screens/search/search_screen.dart';
import 'package:wallpaperhub/ui/screens/user/userScreen.dart';
import 'package:wallpaperhub/ui/views/theme_mode.dart';
import 'package:sizer/sizer.dart';
import 'package:wallpaperhub/ui/widgets/widget.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int _selectedPage = 0;
  final pageData = [HomeScreen(), Categories(), SearchScreen(), UserScreen()];
  var navigationBarIconSize = 20.sp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _selectedPage,
        children: pageData,
      ),
      bottomNavigationBar: Theme(
        // CustomTheme.lightTheme,
        data: Theme.of(context).copyWith(
          iconTheme: currentTheme.isLightMode
              ? IconThemeData(color: kSecondaryColor)
              : IconThemeData(color: kMainColor),
        ),
        child: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: _selectedPage,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.home, size: navigationBarIconSize),
            Icon(Icons.compare_arrows, size: navigationBarIconSize),
            Icon(Icons.search, size: navigationBarIconSize),
            Icon(Icons.perm_identity, size: navigationBarIconSize),
          ],
          color: currentTheme.isLightMode ? kMainColor : Colors.grey[850],
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _selectedPage = index;
            });
          },
          letIndexChange: (index) => true,
        ),
      ),
    );
  }
}
