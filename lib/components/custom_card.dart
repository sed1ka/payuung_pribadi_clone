import 'package:flutter/material.dart';
import 'package:payuung_pribadi_clone/commons/colors.dart';
import 'package:payuung_pribadi_clone/commons/themes.dart';
import 'package:payuung_pribadi_clone/components/custom_inkwell.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    this.backgroundColor = AppColors.white,
    this.shadowColor = AppColors.grey,
    this.highlightColor,
    this.boxShadows,
    this.padding,
    this.margin,
    this.image,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
  });

  final Widget child;
  final Color backgroundColor;
  final Color shadowColor;
  final Color? highlightColor;
  final List<BoxShadow>? boxShadows;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final DecorationImage? image;
  final Function()? onTap;
  final Function()? onDoubleTap;
  final Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        image: image,
        boxShadow: boxShadows ?? <BoxShadow>[kBoxShadow(color: shadowColor)],
      ),
      child: CustomInkWell(
        onTap: onTap,
        onDoubleTap: onDoubleTap,
        onLongPress: onLongPress,
        highlightColor: highlightColor,
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: child,
        ),
      ),
    );
  }
}
