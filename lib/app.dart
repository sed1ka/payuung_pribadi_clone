import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:payuung_pribadi_clone/commons/device_measurement.dart';
import 'package:payuung_pribadi_clone/commons/themes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final TransitionBuilder botToastBuilder = BotToastInit();
    return MaterialApp(
      title: 'Payuung Pribadi',

      theme: themeData(context),
      debugShowCheckedModeBanner: false,
      navigatorObservers: <NavigatorObserver>[
        BotToastNavigatorObserver(),
      ],
      builder: (BuildContext context, Widget? child) {
        if (child == null) return const SizedBox.shrink();
        child = botToastBuilder(context, child);

        setDeviceSize = MediaQuery.sizeOf(context);
        setDeviceLogicalWidth = MediaQuery.sizeOf(context).width;
        setDeviceLogicalHeight = MediaQuery.sizeOf(context).height;
        setDevicePadding = MediaQuery.viewPaddingOf(context);
        setDevicePixelRatio = MediaQuery.devicePixelRatioOf(context);
        setDevicePhysicalWidth = kDeviceLogicalWidth * kDevicePixelRatio;
        setDevicePhysicalHeight = kDeviceLogicalHeight * kDevicePixelRatio;
        final TextScaler textScaler = MediaQuery.textScalerOf(context).clamp(
          maxScaleFactor: 1.1,
          minScaleFactor: 0.9,
        );

        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: textScaler,
          ),
          child: child,
        );
      },
      home: const SizedBox(),
    );
  }
}
