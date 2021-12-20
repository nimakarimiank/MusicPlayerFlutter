import 'package:flutter/material.dart';

class MyStyles {
  static var songTitleLight = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: MyColors.textPrimaryLight,
  );

  static var songTitleDark = songTitleLight.copyWith(
    color: MyColors.textPrimaryDark,
  );

  static var songArtistLight = TextStyle(
      fontSize: 12,
      color: MyColors.textSecondaryLight,
      fontWeight: FontWeight.bold);

  static var songArtistDark = songArtistLight.copyWith(
    color: MyColors.textSecondaryDark,
  );

  static var artistName = songTitleDark.copyWith(fontSize: 16);

  static var artistDetails =
      TextStyle(fontSize: 14, color: MyColors.textSecondaryDark);

  static var albumsTitle = artistName.copyWith(color: Colors.white);

  static var appbarTitle = TextStyle(
    color: MyColors.textPrimaryDark,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static var verticalTabsSelected = TextStyle(
    color: MyColors.textPrimaryDark,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static var verticalTabsUnSelected = verticalTabsSelected.copyWith(
    color: MyColors.textSecondaryDark,
  );

  static var playingArtistBegin =
      MyStyles.songTitleDark.copyWith(color: MyColors.textSecondaryDark);
}

class MyColors {
  static var colorPrimary = Color(0xff273350);
  static var textPrimaryDark = Colors.black;
  static var textSecondaryDark = Color(0xffbdbdbd);

  static var textPrimaryLight = Colors.white;
  static var textSecondaryLight = Colors.white.withOpacity(0.7);
  static var border = Color(0xffe0e0e0);
  static var folders = Color(0xfff2994a);
}

class Consts {
  // extents for bottomNavBar and PlayingBar height
  static double firstExtent = 74;
  static double secondExtent = 148;
}
