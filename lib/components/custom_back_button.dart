import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:payuung_pribadi_clone/commons/colors.dart';
import 'package:payuung_pribadi_clone/commons/constants.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    this.color,
    this.backgroundColor,
    this.onPressed,
    this.tooltip,
  });

  final String? tooltip;

  /// The color to use for the icon.

  final Color? color;
  final Color? backgroundColor;

  /// An override callback to perform instead of the default behavior which is
  /// to pop the [Navigator].
  ///
  /// It can, for instance, be used to pop the platform's navigation stack
  /// via [SystemNavigator] instead of Flutter's [Navigator] in add-to-app
  /// situations.
  ///
  /// Defaults to null.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: color ?? AppColors.white,
        ),
        iconSize: mediumIconSize,
        splashRadius: 22,
        constraints: const BoxConstraints(
            minHeight: 18, minWidth: 18, maxHeight: 22, maxWidth: 22),
        color: color,
        tooltip: tooltip ?? 'Kembali',
        onPressed: () {
          log('#WidgetBackButton tapped');
          if (onPressed != null) {
            onPressed!();
          } else {
            Navigator.of(context).maybePop();
          }
        },
      ),
    );
  }
}
