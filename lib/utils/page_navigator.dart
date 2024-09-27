import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payuung_pribadi_clone/commons/colors.dart';
import 'package:payuung_pribadi_clone/commons/constants.dart';
import 'package:payuung_pribadi_clone/commons/device_measurement.dart';

/// set [opaque] to false to Give Transparent Page
Future<dynamic> goToPage({
  required Widget nextPage,
  required String routeName,
  required BuildContext context,
  bool isRootNavigator = false,
  bool dismissTransitionAnimation = false,
  bool? opaque,
}) async {
  return Navigator.of(
    context,
    rootNavigator: isRootNavigator,
  ).push(
    dismissTransitionAnimation
        ? pageRouteWithNoTransition(
            nextPage,
            routeName: routeName,
            opaque: opaque ?? false,
          )
        : pageRoute(
            nextPage,
            name: routeName,
          ),
  );
}

/// set [opaque] to false to Give Transparent Page
Future<dynamic> goToPageReplacement({
  required Widget nextPage,
  required String routeName,
  required BuildContext context,
  bool isRootNavigator = false,
  bool dismissTransitionAnimation = false,
  bool? opaque,
}) async {
  return Navigator.of(
    context,
    rootNavigator: isRootNavigator,
  ).pushReplacement(
    dismissTransitionAnimation
        ? pageRouteWithNoTransition(
            nextPage,
            routeName: routeName,
            opaque: opaque ?? true,
          )
        : pageRoute(
            nextPage,
            name: routeName,
          ),
  );
}

Future<dynamic> goToPageWithRemoveUntil({
  required Widget nextPage,
  required String routeName,
  required BuildContext context,
  bool isRootNavigator = true,
  bool dismissTransitionAnimation = false,
  String? routePredicate,
}) async {
  return Navigator.of(
    context,
    rootNavigator: isRootNavigator,
  ).pushAndRemoveUntil(
    dismissTransitionAnimation
        ? pageRouteWithNoTransition(
            nextPage,
            routeName: routeName,
            opaque: true,
          )
        : pageRoute(nextPage, name: routeName),
    (Route<dynamic> route) {
      if (routePredicate != null) {
        return route.settings.name == routePredicate;
      } else {
        return false;
      }
    },
  );
}

dynamic pageRoute(
  Widget page, {
  required String name,
  bool fullscreenDialog = false,
}) {
  if (Platform.isIOS) {
    return CupertinoPageRoute<dynamic>(
      builder: (_) => page,
      settings: RouteSettings(name: name),
      fullscreenDialog: fullscreenDialog,
    );
  } else {
    return MaterialPageRoute<dynamic>(
      builder: (_) => page,
      settings: RouteSettings(name: name),
      fullscreenDialog: fullscreenDialog,
    );
  }
}

dynamic pageRouteWithNoTransition(
  Widget page, {
  String routeName = '',
  bool? opaque,
}) {
  return PageRouteBuilder<dynamic>(
    transitionDuration: Duration.zero,
    reverseTransitionDuration: Duration.zero,
    opaque: opaque ?? true,
    pageBuilder: (BuildContext context, _, __) => page,
    settings: RouteSettings(name: routeName),
  );
}

Future<dynamic> showKreduitDialog({
  required BuildContext context,
  required WidgetBuilder builder,
  bool? barrierDismissible,
  String? routeName,
}) {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible ?? false,
    useRootNavigator: true,
    barrierColor: AppColors.black10,
    routeSettings: RouteSettings(name: routeName),
    builder: builder,
  );
}

Future<dynamic> showKreduitFullscreenDialog({
  required BuildContext context,
  required RoutePageBuilder builder,
  bool? barrierDismissible,
  String? routeName,
}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: barrierDismissible ?? false,
    useRootNavigator: true,
    barrierColor: AppColors.black10,
    routeSettings: RouteSettings(name: routeName),
    pageBuilder: builder,
  );
}

Future<dynamic> showKreduitModalBottom({
  required BuildContext context,
  required WidgetBuilder builder,
  String? routeName,
  bool? isScrollControlled,
  bool? isDismissible,
  bool? enableDrag,
  bool isRootNavigator = true,
  double? maxHeight,
  double? minHeight,
}) async {
  return showModalBottomSheet(
    context: context,
    useRootNavigator: isRootNavigator,
    routeSettings: RouteSettings(name: routeName),
    constraints: BoxConstraints(
      minHeight: minHeight ?? 0,
      maxHeight: maxHeight ??
          kDeviceLogicalHeight - (kAppBarHeight + kDevicePadding.top),
      minWidth: kDeviceLogicalWidth,
    ),
    isScrollControlled: isScrollControlled ?? true,
    isDismissible: isDismissible ?? true,
    enableDrag: enableDrag ?? true,
    elevation: 10,
    barrierColor: AppColors.black10,
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15),
      ),
    ),
    builder: builder,
  );
}
