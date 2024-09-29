import 'dart:math' as math;
import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:payuung_pribadi_clone/commons/colors.dart';
import 'package:payuung_pribadi_clone/commons/constants.dart';
import 'package:payuung_pribadi_clone/commons/device_measurement.dart';
import 'package:payuung_pribadi_clone/components/custom_text.dart';

/// use [CustomSnackBar] for give the user general info.
///
/// Need to be note use [KreduitToast] in only for system message info,
/// example: "Text Copied"
class CustomSnackBar {
  static void _showSnackBar({
    required String message,
    String? title,
    required Duration duration,
    Function()? onTap,
    Function()? onClose,
    Color? barColor,
    Color? barIndicatorColor,
    Color? shadowColor,
    Color? textColor,
    required Widget icon,
  }) {
    BotToast.showCustomNotification(
      duration: duration,
      crossPage: true,
      onlyOne: true,
      animationDuration: const Duration(milliseconds: 120),
      useSafeArea: false,
      dismissDirections: [DismissDirection.up],
      onClose: () {
        if (onClose != null) onClose();
      },
      toastBuilder: (cancel) => _CustomSnackBar(
        message: message,
        title: title,
        textColor: textColor,
        barIndicatorColor: barIndicatorColor,
        barColor: barColor,
        shadowColor: shadowColor,
        icon: icon,
        onTap: () {
          if (onTap != null) {
            cancel();
            onTap();
          }
        },
      ),
    );
  }

  /// calculate snackbar duration in milliseconds
  static Duration _getDuration(String message) {
    // Ambil value tertinggi, diantara (message.length * 116) atau 3000
    // jika (message.length * 116) kurang dari 3000, maka return 3000
    // jika value lebih dari 3000 maka return (message.length * 116)
    // jika value lebih dari 9500 maka return 9500
    final int milliseconds = math.max(message.length * 116, 3000);
    if (milliseconds > 9500) {
      return const Duration(milliseconds: 9500);
    }

    return Duration(milliseconds: milliseconds);
  }

  static void success(
    String message, {
    String? title,
    Duration? duration,
    GestureTapCallback? onTap,
    Function()? onClose,
  }) =>
      _showSnackBar(
        duration: duration ?? _getDuration('$title$message'),
        message: message,
        title: title,
        textColor: AppColors.white,
        barColor: AppColors.green,
        shadowColor: AppColors.green,
        icon: const Icon(
          Icons.check_circle_rounded,
          color: AppColors.white,
        ),
        onClose: onClose,
        onTap: () {
          if (onTap != null) onTap();
        },
      );

  static void error(
    String message, {
    String? title,
    Duration? duration,
    GestureTapCallback? onTap,
    Function()? onClose,
  }) =>
      _showSnackBar(
        duration: duration ?? _getDuration('$title$message'),
        message: message,
        title: title,
        textColor: AppColors.white,
        barColor: AppColors.red,
        shadowColor: AppColors.red,
        onClose: onClose,
        icon: const Icon(
          Icons.info_rounded,
          color: AppColors.white,
        ),
      );

  static void info(
    String message, {
    String? title,
    Duration? duration,
    GestureTapCallback? onTap,
    bool onlyShowOneNotif = false,
    Function()? onClose,
  }) =>
      _showSnackBar(
        duration: duration ?? _getDuration('$title$message'),
        message: message,
        title: title,
        barColor: AppColors.lightBlack,
        shadowColor: AppColors.primary,
        textColor: AppColors.white,
        icon: const Icon(
          Icons.info,
          color: AppColors.white,
        ),
        onClose: onClose,
        onTap: () {
          if (onTap != null) onTap();
        },
      );
}

class _CustomSnackBar extends StatelessWidget {
  const _CustomSnackBar({
    required this.message,
    this.title,
    this.barIndicatorColor,
    this.barColor,
    this.textColor,
    this.shadowColor,
    required this.icon,
    this.onTap,
  });

  final VoidCallback? onTap;
  final String? title;
  final String message;
  final Color? barIndicatorColor;
  final Color? barColor;
  final Color? textColor;
  final Color? shadowColor;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    const double sigmaBlur = 16;
    const double borderRadius = 8;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        15,
        kAppBarHeight + kDevicePadding.top + 20,
        15,
        0,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: sigmaBlur, sigmaY: sigmaBlur),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: (barColor ?? AppColors.white).withOpacity(0.7),
                borderRadius: BorderRadius.circular(8),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: (shadowColor ?? AppColors.grey).withOpacity(0.24),
                    blurRadius: 10,
                    spreadRadius: -1,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  if (barIndicatorColor != null)
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      width: 5,
                      child: ColoredBox(color: barIndicatorColor!),
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 16, 15, 16),
                    child: Row(
                      children: [
                        icon,
                        const SizedBox(width: 8),
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (title != null) ...[
                                CustomText.title(
                                  title!,
                                  fontSize: bodyMediumTextSize,
                                  color: textColor ?? AppColors.lightBlack,
                                  maxLines: 2,
                                ),
                                const SizedBox(height: 2),
                              ],
                              CustomText.body(
                                message,
                                fontSize: title == null
                                    ? bodyMediumTextSize
                                    : bodySmallTextSize,
                                color: textColor ?? AppColors.lightBlack,
                                maxLines: 5,
                                medium: title == null,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
