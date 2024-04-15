import 'package:flutter/material.dart';
import 'package:mango_ent/utils/theme/app_export.dart';

class AppDecoration {
  // Brand decorations
  static BoxDecoration get brand => BoxDecoration(
        color: theme.colorScheme.primary,
      );

  // Fill decorations
  static BoxDecoration get fillBlack => BoxDecoration(
        color: appTheme.black90001.withOpacity(0.5),
      );
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray90003,
      );
  static BoxDecoration get fillOnPrimary => BoxDecoration(
        color: theme.colorScheme.onPrimary,
      );

  // Gradient decorations
  static BoxDecoration get gradientBlackToOnPrimaryContainer => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.51, 1.05),
          end: const Alignment(0.5, -2.18),
          colors: [
            appTheme.black90001.withOpacity(0.3),
            theme.colorScheme.onPrimaryContainer.withOpacity(0.3),
          ],
        ),
      );
  static BoxDecoration get gradientDeepPurpleAToOnErrorContainer =>
      BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.79, 0.11),
          end: const Alignment(0.8, 1.21),
          colors: [
            appTheme.deepPurpleA200,
            theme.colorScheme.onErrorContainer,
          ],
        ),
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder10 => BorderRadius.circular(
        10.h,
      );
  static BorderRadius get circleBorder16 => BorderRadius.circular(
        16.h,
      );
  static BorderRadius get circleBorder20 => BorderRadius.circular(
        20.h,
      );
  static BorderRadius get circleBorder34 => BorderRadius.circular(
        34.h,
      );
  static BorderRadius get circleBorder41 => BorderRadius.circular(
        41.h,
      );

  // Custom borders
  static BorderRadius get customBorderLR4 => BorderRadius.horizontal(
        right: Radius.circular(4.h),
      );

  // Rounded borders
  static BorderRadius get roundedBorder5 => BorderRadius.circular(
        5.h,
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
