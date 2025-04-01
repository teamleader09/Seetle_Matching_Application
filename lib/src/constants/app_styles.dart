import 'dart:math';

import 'package:flutter/material.dart';

const Color kColorWhite = Color(0xFFFFFFFF);
const Color kColorBlack = Color(0xFF000000);
const Color kColorPrimary = Color(0xFFE76245);
const Color kColorBorder = Color(0xFF8B8F8E);
const Color kColorTransparent = Colors.transparent;
const Color kColorBlue = Colors.blue;
const Color kColorLightGray = Color(0XFFE4E5E8);
const Color kColorStrongBlue = Color(0XFF006BE7);
const Color kColorMediumBlue = Color(0XFF5864F2);

Color getRandomColor() {
  Random random = Random();
  return Color.fromRGBO(
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
    1,
  );
}

const kEnableSearchBorder = OutlineInputBorder(
  borderSide: BorderSide(color: kColorPrimary, width: 1),
  borderRadius: BorderRadius.all(Radius.circular(10)),
);
const kFocusSearchBorder = OutlineInputBorder(
  borderSide: BorderSide(color: kColorPrimary, width: 1),
  borderRadius: BorderRadius.all(Radius.circular(10)),
);
