import 'package:flutter/material.dart';
import 'package:mango_ent/utils/theme/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyMediumBlack90001 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.black90001,
      );
  static get bodyMediumOnPrimaryContainer =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static get bodySmall8 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 8.sp,
      );
  static get bodySmallLight => theme.textTheme.bodySmall!.copyWith(
        fontSize: 10.sp,
        fontWeight: FontWeight.w300,
      );
  static get bodySmallMontserratGray700 =>
      theme.textTheme.bodySmall!.montserrat.copyWith(
        color: appTheme.gray700,
      );
  static get bodySmallPrimary => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get bodySmallff676767 => theme.textTheme.bodySmall!.copyWith(
        color: const Color(0XFF676767),
      );
  static get bodySmallfff9c034 => theme.textTheme.bodySmall!.copyWith(
        color: const Color(0XFFF9C034),
      );
  // Label text style
  static get labelLargeOnPrimaryContainer =>
      theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.w500,
      );
  static get labelLargeOnPrimaryContainerMedium =>
      theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(0.6),
        fontWeight: FontWeight.w500,
      );
  // Title text style
  static get titleMediumBold => theme.textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w700,
      );
  static get titleMediumMedium => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumOnPrimaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumOnPrimaryContainer_1 =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static get titleSmallPrimary => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w600,
      );
}

extension on TextStyle {
  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get montserrat {
    return copyWith(
      fontFamily: 'Montserrat',
    );
  }

  TextStyle get sFProDisplay {
    return copyWith(
      fontFamily: 'SF Pro Display',
    );
  }
}
