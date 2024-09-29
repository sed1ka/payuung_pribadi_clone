import 'dart:io';
import 'dart:math' as math;

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:payuung_pribadi_clone/commons/colors.dart';
import 'package:payuung_pribadi_clone/commons/constants.dart';
import 'package:payuung_pribadi_clone/commons/local_image.dart';
import 'package:payuung_pribadi_clone/commons/themes.dart';
import 'package:payuung_pribadi_clone/components/custom_text.dart';

class CustomToast {
  static Duration _getDuration(String message) {
    // Ambil value tertinggi, diantara (message.length * 100) atau 3000
    // jika (message.length * 100) kurang dari 3000, maka return 3000
    // jika value lebih dari 3000 maka return (message.length * 100)
    // jika value lebih dari 9500 maka return 7500
    final int milliseconds = math.max(message.length * 100, 3000);
    if (milliseconds > 7500) {
      return const Duration(milliseconds: 7500);
    }

    return Duration(milliseconds: milliseconds);
  }

  static void show(String message, {Duration? duration}) {
    BotToast.showCustomText(
      ignoreContentClick: false,
      onlyOne: true,
      crossPage: true,
      align: const Alignment(0, 0.5),
      duration: duration ?? _getDuration(message),
      animationDuration: const Duration(milliseconds: 160),
      backgroundColor: Colors.transparent,
      toastBuilder: (_) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        padding: !Platform.isIOS
            ? const EdgeInsets.symmetric(horizontal: 14, vertical: 8)
            : const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
        decoration: BoxDecoration(
          color: !Platform.isIOS
              ? const Color(0xFF404040)
              : const Color(0xFAFBFBFB),
          shape: !Platform.isIOS ? BoxShape.rectangle : BoxShape.circle,
          borderRadius: !Platform.isIOS ? BorderRadius.circular(12) : null,
          boxShadow: !Platform.isIOS ? null : [kBoxShadow()],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!Platform.isIOS) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: SizedBox(
                  width: labelLargeTextSize * 2,
                  height: labelLargeTextSize * 2,
                  child: Image.asset(
                    LocalImage.payuungPribadi,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
            Flexible(
              child: CustomText.body(
                message,
                fontSize:
                    !Platform.isIOS ? bodySmallTextSize : bodyMediumTextSize,
                fontWeight: FontWeight.w500,
                color: !Platform.isIOS ? AppColors.white : AppColors.lightBlack,
                maxLines: 3,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
