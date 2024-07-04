// import 'package:flutter/material.dart';
// import 'package:teego/utils/theme/colors_constant.dart';

// class ThemeHelper {
//   static ThemeData lightTheme = ThemeData(
//     brightness: Brightness.light,
//       scaffoldBackgroundColor: Colors.transparent,
//       textTheme:  TextTheme(
//         titleLarge: const TextStyle(color: Colors.black,fontSize: 36,fontWeight: FontWeight.w700),
//            titleSmall: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),
//           bodySmall:  TextStyle(color: AppColors.lHintColor,fontSize: 12,fontWeight: FontWeight.w400),
//           bodyMedium:  TextStyle(color: AppColors.lHintColor,fontSize: 14,fontWeight: FontWeight.w400)
//   ),
//       iconTheme: IconThemeData(
//         color: AppColors.lHintColor
//       ),
//       textSelectionTheme: TextSelectionThemeData(
//         cursorColor: AppColors.lHintColor
//       ),
//       inputDecorationTheme:InputDecorationTheme(
//         filled: true,
//         fillColor:AppColors.lTextFieldFilled ,
//       ),
//   );

//   static ThemeData darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     scaffoldBackgroundColor: Colors.transparent,
//     textTheme:  const TextTheme(
//         titleLarge: TextStyle(color: Colors.white,fontSize: 36,fontWeight: FontWeight.w700),
//         titleSmall: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w700),
//         bodySmall:  TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w400),
//         bodyMedium:  TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400)
//     ),
//     iconTheme: IconThemeData(
//         color: AppColors.dHintColor
//     ),
//     textSelectionTheme: TextSelectionThemeData(
//         cursorColor: AppColors.lHintColor
//     ),
//     inputDecorationTheme:InputDecorationTheme(
//       filled: true,
//       fillColor:AppColors.dTextFieldFilled,
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:teego/utils/theme/colors_constant.dart';

class ThemeHelper {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.transparent,
    textTheme: TextTheme(
      titleLarge: const TextStyle(
          color: AppColors.kBlack, fontSize: 36, fontWeight: FontWeight.w700),
      titleSmall: const TextStyle(
          color: AppColors.kBlack, fontSize: 16, fontWeight: FontWeight.w600),
      bodySmall: TextStyle(
          color: AppColors.greyT, fontSize: 12, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(
          color: AppColors.lHintColor,
          fontSize: 14,
          fontWeight: FontWeight.w400),
      bodyLarge: TextStyle(
          color: AppColors.kBlack, fontSize: 12, fontWeight: FontWeight.w700),
      labelSmall: TextStyle(
          color: AppColors.kBlack, fontSize: 16, fontWeight: FontWeight.bold),
    ),
    iconTheme: IconThemeData(color: AppColors.greyT),
    textSelectionTheme:
    TextSelectionThemeData(cursorColor: AppColors.lHintColor),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lTextFieldFilled,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.transparent,
    textTheme: const TextTheme(
        titleLarge: TextStyle(
            color: AppColors.kWhite, fontSize: 36, fontWeight: FontWeight.w700),
        titleSmall: TextStyle(
            color: AppColors.kWhite, fontSize: 16, fontWeight: FontWeight.w700),
        bodySmall: TextStyle(
            color: AppColors.kWhite, fontSize: 12, fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(
            color: AppColors.kWhite,
            fontSize: 14,
            fontWeight: FontWeight.w400)),
    iconTheme: IconThemeData(color: AppColors.dHintColor),
    textSelectionTheme:
    TextSelectionThemeData(cursorColor: AppColors.lHintColor),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.dTextFieldFilled,
    ),
  );
}