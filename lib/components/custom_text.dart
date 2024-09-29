import 'package:flutter/material.dart';
import 'package:payuung_pribadi_clone/commons/colors.dart';
import 'package:payuung_pribadi_clone/commons/constants.dart';

class CustomText extends Text {
  const CustomText._(
    super.data, {
    super.key,
    super.textAlign,
    super.style,
    super.overflow,
    super.maxLines,
  });

  static const double bodyHeight = 1.38;
  static const double bodyWordSpacing = 1.45;

  factory CustomText.title(
    String data, {
    Key? key,
    bool italic = false,
    bool underline = false,
    bool useAccentColor = false,
    double? fontSize,
    Color? color,
    TextAlign? textAlign,
    TextStyle? style,
    TextOverflow? overflow,
    int? maxLines,
    double? textScalefactor,
    double? letterSpacing,
    double? height,
    FontWeight? fontWeight,
  }) {
    return CustomText._(
      data,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow:
          maxLines != null ? (overflow ?? TextOverflow.ellipsis) : overflow,
      style: TextStyle(
        color: color ?? (useAccentColor ? AppColors.primary : AppColors.black),
        fontSize: fontSize ?? titleMediumTextSize,
        fontWeight: fontWeight ?? FontWeight.bold,
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
        letterSpacing: letterSpacing,
        height: height,
      ),
    );
  }

  factory CustomText.body(
    String data, {
    Key? key,
    bool bold = false,
    bool medium = false,
    bool italic = false,
    bool underline = false,
    bool accentColor = false,
    double? fontSize,
    Color? color,
    TextAlign? textAlign,
    TextStyle? style,
    TextOverflow? overflow,
    int? maxLines,
    double? textScalefactor,
    double? letterSpacing,
    double? height,
    FontWeight? fontWeight,
  }) {
    if (fontWeight == null) {
      if (bold) {
        fontWeight = FontWeight.bold;
      } else if (medium) {
        fontWeight = FontWeight.w600;
      }
    }

    return CustomText._(
      data,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? overflow ?? TextOverflow.ellipsis : overflow,
      style: TextStyle(
        color:
            color ?? (accentColor ? AppColors.primary : AppColors.lightBlack),
        fontSize: fontSize ?? bodyMediumTextSize,
        fontWeight: fontWeight,
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
        letterSpacing: letterSpacing,
        wordSpacing: bodyWordSpacing,
        height: height ?? bodyHeight,
      ),
    );
  }
}
