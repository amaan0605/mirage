import 'package:flutter/material.dart';
import 'package:wallpaperhub/ui/widgets/widget.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  bool isLightMode = true;
  ThemeMode get currentTheme => isLightMode ? ThemeMode.light : ThemeMode.dark;

  void toggleMode() {
    isLightMode = !isLightMode;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    // themeIcon = Icon(Icons.wb_sunny);
    return ThemeData(
      appBarTheme: AppBarTheme(
        color: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
    );
  }

  static ThemeData get darkTheme {
    // themeIcon = Icon(Icons.nightlight_round_outlined);
    return ThemeData.dark().copyWith(
      appBarTheme: AppBarTheme(color: Colors.grey[900]),
      scaffoldBackgroundColor: Colors.grey[900],
    );
  }
}
