import 'package:flutter/material.dart';

import 'package:payuung_pribadi_clone/commons/colors.dart';
import 'package:payuung_pribadi_clone/utils/page_navigator.dart';

class AppLoading extends StatelessWidget {
  /// if you want to use loading with background
  /// use [KreduitLoading.withBackground] instead
  const AppLoading({
    super.key,
    this.color,
    this.backgroundColor,
    this.padding,
    this.size,
    this.boxShadows,
  }) : assert((size ?? 35) >= 1);

  final Color? color;
  final Color? backgroundColor;
  final double? padding;
  final double? size;
  final List<BoxShadow>? boxShadows;

  static final ValueNotifier<bool> _isOpenNotifier = ValueNotifier<bool>(false);

  static bool get isOpen => _isOpenNotifier.value;

  static void open(
    BuildContext context, {
    bool? barrierDismissible,
    bool prevertBack = false,
  }) {
    showKreduitDialog(
      context: context,
      barrierDismissible: prevertBack == true ? false : barrierDismissible,
      builder: (BuildContext context) {
        _isOpenNotifier.value = true;
        return PopScope(
          canPop: !prevertBack,
          child: Center(child: AppLoading.withBackground()),
        );
      },
    ).whenComplete(() {
      _isOpenNotifier.value = false;
    });
  }

  static void close(BuildContext context) {
    if (context.mounted) {
      Navigator.pop(context);
    }

    _isOpenNotifier.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final double finalSize = size ?? 35;

    return Container(
      height: padding != null ? (padding ?? 32) + finalSize : null,
      width: padding != null ? (padding ?? 32) + finalSize : null,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        boxShadow: boxShadows,
      ),
      child: SizedBox(
        height: finalSize,
        width: finalSize,
        child: const CircularProgressIndicator(),
      ),
    );
  }

  factory AppLoading.withBackground({
    Color? color,
    Color? backgroundColor,
    double? size,
  }) {
    return AppLoading(
      color: color,
      size: size,
      backgroundColor: backgroundColor ?? AppColors.white,
      padding: 32,
      boxShadows: const <BoxShadow>[
        BoxShadow(
          color: AppColors.lightBlack,
          spreadRadius: -3,
          blurRadius: 5,
          offset: Offset(0, 2),
        ),
      ],
    );
  }
}
