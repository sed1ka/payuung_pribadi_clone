import 'package:flutter/material.dart';
import 'package:payuung_pribadi_clone/commons/colors.dart';
import 'package:payuung_pribadi_clone/commons/constants.dart';
import 'package:payuung_pribadi_clone/components/custom_inkwell.dart';
import 'package:payuung_pribadi_clone/components/custom_text.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    this.title,
    this.titleFontSize,
    this.titleColor,
    this.subtitle,
    this.subtitleColor,
    this.color,
    this.subtitleFontSize,
    this.titleBold = true,
    this.subtitleOnBottom = true,
    this.subtitleBold = false,
    this.subtitleMedium = false,
    this.padding,
    this.leading,
    this.content,
    this.trailing,
    this.useDefaultTrail = true,
    this.gapBetweenTitleAndSubtitle,
    this.gapBetweenTextWithLeading,
    this.gapBetweenTextWithTrailing,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.border,
  });

  /// Note
  /// set [subtitleOnBottom] to false, to make subtitle on Right side
  /// set [subtitleOnBottom] to true, to make subtitle on Bottom side
  final bool subtitleOnBottom;

  final bool titleBold;
  final bool subtitleBold;
  final bool subtitleMedium;

  final double? titleFontSize;
  final double? subtitleFontSize;

  final String? title;
  final String? subtitle;
  final Color? titleColor;
  final Color? subtitleColor;
  final Color? color;
  final Widget? leading;
  final Widget? content;
  final Widget? trailing;
  final bool useDefaultTrail;
  final double? gapBetweenTitleAndSubtitle;
  final double? gapBetweenTextWithLeading;
  final double? gapBetweenTextWithTrailing;
  final EdgeInsets? padding;
  final Function()? onTap;
  final Function()? onDoubleTap;
  final Function()? onLongPress;
  final ShapeBorder? border;

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      border: border,
      key: key,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      backgroundColor: color ?? Colors.transparent,
      child: Padding(
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 16,
            ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (leading != null) ...<Widget>[
              FittedBox(
                fit: BoxFit.scaleDown,
                child: leading ?? const SizedBox.shrink(),
              ),
              SizedBox(width: gapBetweenTextWithLeading ?? 14),
            ],
            Expanded(
              child: content != null
                  ? content ?? const SizedBox.shrink()
                  : !subtitleOnBottom
                  ? _contentInRow()
                  : _contentInBottom(),
            ),
            if (trailing == null) ...<Widget>[
              if (useDefaultTrail) ...<Widget>[
                SizedBox(width: gapBetweenTextWithTrailing ?? 4),
                const Icon(
                  Icons.keyboard_arrow_right_rounded,
                  size: smallIconSize,
                  color: AppColors.lightBlack,
                ),
              ],
            ] else ...<Widget>[
              SizedBox(width: gapBetweenTextWithTrailing ?? 4),
              trailing ?? const SizedBox.shrink(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _contentInRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        if (title?.isNotEmpty ?? false)
          CustomText.body(
            title ?? '',
            fontSize: titleFontSize ??
                (titleBold ? bodyLargeTextSize : bodySmallTextSize),
            bold: titleBold,
            color: titleColor,
            maxLines: 1,
          ),
        if (subtitle?.isNotEmpty ?? false) ...<Widget>[
          SizedBox(width: gapBetweenTitleAndSubtitle ?? 4),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: CustomText.body(
                subtitle ?? '',
                color: subtitleColor ?? AppColors.lightBlack,
                fontSize: subtitleFontSize ??
                    (!titleBold ? bodyLargeTextSize : bodySmallTextSize),
                bold: !titleBold,
                medium: subtitleMedium,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _contentInBottom() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (title?.isNotEmpty ?? false)
          CustomText.body(
            title ?? '',
            fontSize: titleFontSize ??
                (titleBold ? bodyLargeTextSize : bodySmallTextSize),
            bold: titleBold,
            color: titleColor,
            maxLines: 2,
          ),
        if (subtitle?.isNotEmpty ?? false) ...<Widget>[
          SizedBox(height: gapBetweenTitleAndSubtitle ?? 4),
          CustomText.body(
            subtitle ?? '',
            color: subtitleColor,
            fontSize: subtitleFontSize ??
                (!titleBold ? bodyLargeTextSize : bodySmallTextSize),
            bold: !titleBold,
            medium: subtitleMedium,
          ),
        ],
      ],
    );
  }
}
