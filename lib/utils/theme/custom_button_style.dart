import 'package:flutter/material.dart';
import 'package:mango_ent/utils/theme/app_export.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Filled button style
  static ButtonStyle get fillBlack => ElevatedButton.styleFrom(
        backgroundColor: appTheme.black90001.withOpacity(0.63),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(
              4.h,
            ),
          ),
        ),
      );
  static ButtonStyle get fillBlackTL10 => ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.h),
        ),
      );
  static ButtonStyle get fillPrimary => ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.h),
        ),
      );

  // Gradient button style
  static BoxDecoration get gradientDeepPurpleAToOnErrorContainerDecoration =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(6.h),
        gradient: LinearGradient(
          begin: const Alignment(0.79, 0),
          end: const Alignment(0.8, 1),
          colors: [
            appTheme.deepPurpleA200,
            theme.colorScheme.onErrorContainer,
          ],
        ),
      );
  // text button style
  static ButtonStyle get none => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
      );
}
