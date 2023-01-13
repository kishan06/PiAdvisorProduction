import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final box = GetStorage();
  final key = 'isDarkMode';
  saveThemeToBox(bool isDarkMode) => box.write(key, isDarkMode);

  bool loadThemeFromBox() => box.read(key) ?? true;
  ThemeMode get theme => loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;
  void switchTheme() {
    Get.changeThemeMode(loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    saveThemeToBox(!loadThemeFromBox());
  }
}

// class MyThemes {
//   static final darkTheme = ThemeData(
//     scaffoldBackgroundColor: Colors.grey.shade900,
//     primaryColor: Colors.black,
//     colorScheme: const ColorScheme.light(),
//   );

//   static final lightTheme = ThemeData(
//     scaffoldBackgroundColor: Colors.white,
//     primaryColor: Colors.white,
//     colorScheme: const ColorScheme.light(),
//   );
// }

abstract class AppColors {
  static const primary = Color(0xffCC9900);
  static const secondary = Color(0xFFF40000);
  static const textDark = Color(0xFF000000);
  static const textLigth = Color(0xFFffffff);
  static const iconLight = Color(0xFF000000);
  static const iconDark = textLigth;
  static const textHighlight = secondary;
  static const cardLight = Color(0xFFF9FAFE);
  static const cardDark = Color(0xFF303334);
  static const backgroundDark = Color(0xFF303334);
}

abstract class _LightColors {
  static const background = Color(0xffffffff);
}

abstract class _DarkColors {
  static const background = Color(0xFF000000);
  static const card = AppColors.cardDark;
}

/// Reference to the application theme.
abstract class AppTheme {
  static final visualDensity = VisualDensity.adaptivePlatformDensity;

  /// Light theme and its settings.
  static ThemeData light() => ThemeData(
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
              fontSize: 20.sm,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
        brightness: Brightness.light,
        visualDensity: visualDensity,
        backgroundColor: _LightColors.background,
        scaffoldBackgroundColor: _LightColors.background,
        primaryColor: const Color(0xff000000),
        fontFamily: 'Product sans',
        primarySwatch: Colors.orange,
        textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 18.sm,
                fontWeight: FontWeight.w600,
                color: Colors.black),
            headline4: TextStyle(fontSize: 18.sm, color: Colors.black),
            headline2: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF303030)),
            headline3: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
            headline5: TextStyle(
              color: Colors.black,
              fontSize: 12.sm,
            ),
            headline6: TextStyle(
              color: Color(0xFF6B6B6B),
              fontSize: 10.sm,
            ),
            bodyText1: TextStyle(fontSize: 16.sm, color: Colors.black),
            bodyText2: TextStyle(color: const Color(0xFF6B6B6B), fontSize: 14)),
        iconTheme: const IconThemeData(color: Colors.black),
      );

  /// Dark theme and its settings.
  static ThemeData dark() => ThemeData(
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
              fontSize: 20.sm,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
        brightness: Brightness.dark,
        visualDensity: visualDensity,
        fontFamily: 'Product sans',
        backgroundColor: _DarkColors.background,
        scaffoldBackgroundColor: _DarkColors.background,
        //  cardColor: _DarkColors.card,
        primaryColor: const Color(0xff000000),
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 18.sm,
              fontWeight: FontWeight.w600,
              color: Colors.white),
          headline4: TextStyle(fontSize: 18, color: Colors.white),
          headline2: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
          headline3: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
          headline5: TextStyle(
            color: Colors.white,
            fontSize: 12.sm,
          ),
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 10.sm,
          ),
          // bodyLarge: TextStyle(fontSize: 18.sm, color: Colors.white),
          bodyText1: TextStyle(fontSize: 16.sm, color: Colors.white),
          bodyText2: TextStyle(color: Colors.white, fontSize: 14),
        ),
        // bodySmall:TextStyle(color: Colors.white,fontSize: 10.sm,)),

        iconTheme: const IconThemeData(color: Colors.white),
      );
}
