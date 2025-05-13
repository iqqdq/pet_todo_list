import 'package:flutter/widgets.dart';

abstract class AppTextStyles {
  static const fontFamilyOutfit = 'Outfit';
  static const height = 1.4;

  // Title
  static const title1Bold28pt = TextStyle(
    fontFamily: fontFamilyOutfit,
    fontWeight: FontWeight.bold,
    fontSize: 28.0,
    height: height,
  );
  static const title2SemiBold28pt = TextStyle(
    fontFamily: fontFamilyOutfit,
    fontWeight: FontWeight.w600,
    fontSize: 28.0,
    height: height,
  );

  // Headline
  static const headline1Semibold20pt = TextStyle(
    fontFamily: fontFamilyOutfit,
    fontWeight: FontWeight.w600,
    fontSize: 20.0,
    height: height,
  );
  static const headline2Medium18pt = TextStyle(
    fontFamily: fontFamilyOutfit,
    fontWeight: FontWeight.w500,
    fontSize: 18.0,
    height: height,
  );
  static const headline3Regular18pt = TextStyle(
    fontFamily: fontFamilyOutfit,
    fontSize: 18.0,
    height: height,
  );
  static const headline4Semibold16pt = TextStyle(
    fontFamily: fontFamilyOutfit,
    fontWeight: FontWeight.w600,
    fontSize: 16.0,
    height: height,
  );

  // Body
  static const body1Medium16pt = TextStyle(
    fontFamily: fontFamilyOutfit,
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
    height: height,
  );
  static const body2Regular16pt = TextStyle(
    fontFamily: fontFamilyOutfit,
    fontSize: 16.0,
    height: height,
  );
  static const body3Bold14pt = TextStyle(
    fontFamily: fontFamilyOutfit,
    fontWeight: FontWeight.bold,
    fontSize: 14.0,
    height: height,
  );
  static const body4Regular14pt = TextStyle(
    fontFamily: fontFamilyOutfit,
    fontSize: 14.0,
    height: height,
  );

  // Caption
  static const caption1Regular12pt = TextStyle(
    fontFamily: fontFamilyOutfit,
    fontSize: 12.0,
    height: height,
  );
}
