import 'package:click/helpers/color_extension.dart';
import 'package:flutter/material.dart';

Color appBarColor = '#0d223f'.toColor();
Color primaryColor = '#fb501a'.toColor();
Color unselectedColor = '#2C5760'.toColor();
Color whitecolor = Colors.white;
Color blackcolor = Colors.black;
Color redcolor = Colors.red;
Color bluecolor = Colors.yellow.shade900;
Color greyshade300 = Colors.grey.shade300;
Color greyshade400 = Colors.grey.shade400;
Map<int, Color> colors = {
  for (var item in List.generate(10, (index) {
    return index == 0 ? 50 : index * 100;
  }))
    item: primaryColor.withOpacity(item == 50 ? 0.1 : item / 1000 + 0.1)
};
MaterialColor primarySwatch = MaterialColor(0xFF880E4F, colors);

TextStyle whiteText(double fs) => TextStyle(color: Colors.white, fontSize: fs);
TextStyle blackText(double fs) => TextStyle(color: Colors.black, fontSize: fs);