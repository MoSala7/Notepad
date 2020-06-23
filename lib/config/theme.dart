import 'package:flutter/material.dart';

class StyleCustom {
  static int _offlineTheme = 0;
  static Color bg, txtPrimary, txtSecondry, boxColor,boxShadow;
  static Color blue, green, pink, red, orange,cyan;
  StyleCustom() {
    cyan = Color(0xff00d0c1);
    blue = Color(0xff3379f6);
    green = Color(0xff139810);
    pink = Color(0xffca1354);
    red = Color(0xffc42121);
    orange = Color(0xfff3a643);
    if (_offlineTheme == 0) {
      boxShadow = Color(0xffb2b2b2);
      bg = Color(0xffffffff);
      txtPrimary = Color(0xff000000);
      txtSecondry = Color(0xff313131);
      boxColor = Color(0xfff4f4f4);
    } else if (_offlineTheme == 1) {
      boxShadow = Color(0xff37334d);
      bg = Color(0xff242133);
      txtPrimary = Color(0xffffffff);
      txtSecondry = Color(0xffb8b7c0);
      boxColor = Color(0xff37334d);
    }else if (_offlineTheme == 2){
      boxShadow = Color(0xff37334d);
      bg = Color(0xff000000);
      txtPrimary = Color(0xfffbfbfb);
      txtSecondry = Color(0xff909090);
      boxColor = Color(0xff252525);
    }
  }
  static setThemeStyle(int x) {
    if (x == 0) {
      _offlineTheme = 0;
    } else if (x == 1) {
      _offlineTheme = 1;
    }else if (x == 2) {
      _offlineTheme = 2;
    }
  }
}