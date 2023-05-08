import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/fonts.dart';

class InAppAlert {
  // static String iconUrl(AlertType alertType) => alertType == AlertType.success
  //     ? 'assets/svg/checkmark-circle.svg'
  //     : alertType == AlertType.warning
  //         ? 'assets/svg/alert-triangle.svg'
  //         : 'assets/svg/close-circle.svg';

  static Color backgroundColor(AlertType alertType) =>
      alertType == AlertType.success
          ? const Color(0xffE6FFE8)
          : alertType == AlertType.warning
              ? const Color(0xffFFFAE2)
              : const Color(0xffFFF4EE);

  static double get kBarHeight => 48;

  static Duration get kDialogueDuration => const Duration(seconds: 5);

  static Color get kCloseIconColor => const Color(0xff0D1C2E);

  static TextStyle get kTextStyle => AppFonts.nunito.copyWith(
        color: AppColors.white.withOpacity(.7),
        fontWeight: FontWeight.w400,
        fontSize: 14,
        letterSpacing: 1,
        height: AppFonts.lineHeight,
      );
}

enum AlertType {
  success,
  warning,
  error,
}
