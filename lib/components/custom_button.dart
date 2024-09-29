import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payuung_pribadi_clone/commons/colors.dart';
import 'package:payuung_pribadi_clone/commons/constants.dart';
import 'package:payuung_pribadi_clone/components/custom_text.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onLongTap;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? style;
  final Clip clipBehavior;
  final FocusNode? focusNode;
  final bool autofocus;
  final WidgetStatesController? statesController;
  final Widget? child;

  /// set [isSecondaryButton] to True for using OutlinedButton type
  final bool isSecondaryButton;

  final EdgeInsets? padding;
  final OutlinedBorder? shape;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? overlayColor;
  final BorderSide? side;
  final Size? minimumSize;
  final Size? maximumSize;
  final bool smallButton;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.child,
    this.onLongTap,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.statesController,
    this.isSecondaryButton = false,
    this.padding,
    this.shape,
    this.backgroundColor,
    this.foregroundColor,
    this.overlayColor,
    this.side,
    this.minimumSize,
    this.maximumSize,
    this.smallButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: key,
      onPressed: onTap,
      onLongPress: onLongTap,
      onHover: onHover,
      onFocusChange: onFocusChange,
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(
            smallButton ? const Size(25, 28) : minimumSize),
        maximumSize: WidgetStateProperty.all(maximumSize),
        foregroundColor:
            WidgetStateProperty.all(overlayColor ?? Colors.transparent),
        // backgroundColor: WidgetStateProperty.all(backgroundColor ??
        //     (isSecondaryButton ? KreduitColors.white : backgroundColor)),
        backgroundColor: WidgetStateProperty.resolveWith(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return backgroundColor != null
                  ? backgroundColor!.withOpacity(0.55)
                  : isSecondaryButton
                      ? AppColors.white
                      : AppColors.primary30;
            }

            return backgroundColor ??
                (isSecondaryButton ? AppColors.white : backgroundColor);
          },
        ),
        overlayColor: WidgetStateProperty.resolveWith(
          (Set<WidgetState> states) {
            return states.contains(WidgetState.pressed)
                ? overlayColor ??
                    (isSecondaryButton
                        ? AppColors.primary15
                        : AppColors.black10)
                : null;
          },
        ),
        elevation: WidgetStateProperty.all(0),
        padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(padding),
        shape: ButtonStyleButton.allOrNull<OutlinedBorder>(shape),
        side: WidgetStateProperty.resolveWith(
          (Set<WidgetState> states) {
            bool wasDisabled = states.contains(WidgetState.disabled);
            Color sideColor = isSecondaryButton
                ? wasDisabled
                    ? AppColors.primary30
                    : AppColors.primary
                : Colors.transparent;

            return side ??
                BorderSide(
                  color: sideColor,
                  width: isSecondaryButton ? 1.2 : 0,
                );
          },
        ),
        // side: ButtonStyleButton.allOrNull<BorderSide>(
        //   side ??
        //       BorderSide(
        //         color: isSecondaryButton
        //             ? KreduitColors.orange
        //             : Colors.transparent,
        //         width: isSecondaryButton ? 1.2 : 0,
        //       ),
        // ),
        splashFactory: InkRipple.splashFactory,
      ),
      autofocus: autofocus,
      focusNode: focusNode,
      clipBehavior: clipBehavior,
      statesController: statesController,
      child: child,
    );
  }

  factory CustomButton.text({
    required String label,
    required VoidCallback? onTap,
    VoidCallback? onLongTap,
    bool isSecondaryButton = false,
    Color? labelColor,
    double? labelSize,
    bool boldLabel = false,
    EdgeInsets? padding,
    OutlinedBorder? shape,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? overlayColor,
    BorderSide? side,
    Size? minimumSize,
    Size? maximumSize,
    bool smallButton = false,
    BoxFit? fit,
  }) =>
      CustomButton(
        onTap: onTap,
        onLongTap: onLongTap,
        isSecondaryButton: isSecondaryButton,
        padding: smallButton
            ? const EdgeInsets.symmetric(horizontal: 13, vertical: 7)
            : padding,
        maximumSize: Size.infinite,
        shape: shape,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        overlayColor: overlayColor,
        side: side,
        minimumSize: smallButton ? const Size(25, 28) : minimumSize,
        child: Opacity(
          opacity: onTap == null ? 0.70 : 1,
          child: CustomText.title(
            label,
            color: labelColor ??
                (isSecondaryButton ? AppColors.primary : AppColors.white),
            fontSize: smallButton ? bodySmallTextSize : labelSize,
            fontWeight: !boldLabel ? FontWeight.w600 : FontWeight.bold,
          ),
        ),
      );

  static Widget link({
    VoidCallback? onTap,
    required Widget child,
    EdgeInsets? padding,
    Color? color,
    Alignment? alignment,
  }) {
    return CupertinoButton(
      onPressed: onTap,
      alignment: alignment ?? Alignment.center,
      padding: padding ?? EdgeInsets.zero,
      minSize: 0,
      color: color ?? Colors.transparent,
      child: Material(
        color: Colors.transparent,
        child: child,
      ),
    );
  }
}
