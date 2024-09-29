import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:payuung_pribadi_clone/components/custom_snackbar.dart';

class ExitAppHandler {
  static DateTime? backButtonPressedTime;

  static Future<void> exit() async {
    const Duration exitDuration = Duration(seconds: 3);
    log('#ExitAppHandler onWillPop');
    final DateTime currentTime = DateTime.now();

    final bool doExit = backButtonPressedTime != null &&
        exitDuration > currentTime.difference(backButtonPressedTime!);

    log('#ExitAppHandler onWillPop: backButton: $doExit');

    /// check if user tapped back button again
    if (!doExit) {
      backButtonPressedTime = currentTime;
      CustomSnackBar.info(
        'Tekan lagi untuk keluar',
        duration: exitDuration,
      );
      return;
    }

    SystemNavigator.pop();
  }
}