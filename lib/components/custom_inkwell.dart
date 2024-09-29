import 'package:flutter/material.dart';
import 'package:payuung_pribadi_clone/commons/colors.dart';

class CustomInkWell extends StatelessWidget {
  const CustomInkWell({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.highlightColor,
    this.backgroundColor,
    this.border,
    this.clip,
  });

  final Function()? onTap;
  final Function()? onLongPress;
  final Function()? onDoubleTap;
  final Widget child;
  final Color? highlightColor;
  final Color? backgroundColor;
  final ShapeBorder? border;
  final Clip? clip;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Colors.transparent,
      clipBehavior: clip ?? Clip.antiAlias,
      shape: border,
      child: InkWell(
        splashColor: highlightColor ?? AppColors.primary15,
        highlightColor:
            highlightColor ?? AppColors.primary15,
        onTap: onTap,
        onLongPress: onLongPress,
        onDoubleTap: onDoubleTap,
        customBorder: border,
        child: child,
      ),
    );
  }
}
