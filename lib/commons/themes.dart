import 'package:flutter/material.dart';
import 'package:payuung_pribadi_clone/commons/colors.dart';
import 'package:payuung_pribadi_clone/commons/constants.dart';

ThemeData themeData(BuildContext context, {bool useMaterial3 = true}) {
  return ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.white,
    highlightColor: AppColors.primary15,
    splashColor: AppColors.lightBlack15,
    hoverColor: AppColors.lightBlack15,
    appBarTheme: appBarTheme(),
    elevatedButtonTheme: elevatedButtonTheme(),
    checkboxTheme: checkboxThemeData(),
    textSelectionTheme: textSelectionThemeData(),
    inputDecorationTheme: outlineDecorationTheme(),
    textTheme: textTheme(),
  );
}

TextSelectionThemeData textSelectionThemeData() {
  return const TextSelectionThemeData(
    cursorColor: AppColors.black,
    selectionHandleColor: AppColors.primary,
    selectionColor: AppColors.primary15,
  );
}

CheckboxThemeData checkboxThemeData() {
  return CheckboxThemeData(
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    visualDensity: VisualDensity.compact,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    side: WidgetStateBorderSide.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return const BorderSide(
          color: AppColors.primary15,
          width: 1.25,
        );
      }
      if (states.contains(WidgetState.selected)) {
        return const BorderSide(
          color: AppColors.primary,
          width: 1.25,
        );
      }

      return const BorderSide(
        color: AppColors.primary,
        width: 1.25,
      );
    }),
    fillColor:
        WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return AppColors.primary15;
      }
      if (states.contains(WidgetState.selected)) {
        return AppColors.primary;
      }
      return null;
    }),
  );
}

ElevatedButtonThemeData elevatedButtonTheme() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.primary,
      disabledBackgroundColor: AppColors.primary,
      shadowColor: AppColors.primary,
      minimumSize: const Size(50, 48),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      textStyle: const TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.normal,
        fontSize: bodyMediumTextSize,
      ),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: AppColors.white,
    iconTheme: iconThemeData(),
    centerTitle: true,
    elevation: 0,
    shadowColor: Colors.transparent,
    toolbarHeight: kAppBarHeight,
  );
}

IconThemeData iconThemeData() {
  return const IconThemeData(
    size: largeIconSize,
    color: AppColors.lightBlack,
  );
}

InputDecorationTheme outlineDecorationTheme({
  bool ignoreFocusBorder = false,
}) {
  const BorderRadius borderRadius = BorderRadius.all(Radius.circular(8));
  OutlineInputBorder inputBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.grey, width: 0.9),
    borderRadius: borderRadius,
  );
  OutlineInputBorder focusedInputBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.primary, width: 0.9),
    borderRadius: borderRadius,
  );
  OutlineInputBorder disableInputBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.lightGrey, width: 0.4),
    borderRadius: borderRadius,
  );
  OutlineInputBorder errorInputBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.redOpa55, width: 0.9),
    borderRadius: borderRadius,
  );
  OutlineInputBorder focusedErrorInputBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.red, width: 1.1),
    borderRadius: borderRadius,
  );
  return InputDecorationTheme(
    filled: true,
    fillColor: WidgetStateColor.resolveWith((Set<WidgetState> state) {
      if (state.contains(WidgetState.disabled)) {
        return AppColors.lightBlack15;
      }

      return Colors.transparent;
    }),
    hoverColor: AppColors.primary30,
    contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
    border: inputBorder,
    enabledBorder: inputBorder,
    focusedBorder: ignoreFocusBorder ? inputBorder : focusedInputBorder,
    errorBorder: errorInputBorder,
    focusedErrorBorder:
        ignoreFocusBorder ? errorInputBorder : focusedErrorInputBorder,
    disabledBorder: disableInputBorder,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    hintStyle: const TextStyle(
      color: AppColors.lightBlack80,
    ),
    labelStyle: WidgetStateTextStyle.resolveWith((Set<WidgetState> state) {
      if (state.contains(WidgetState.disabled)) {
        return const TextStyle(
          color: AppColors.lightBlack15,
          fontSize: bodyLargeTextSize,
        );
      }
      return const TextStyle(
        color: AppColors.grey,
        fontSize: bodyLargeTextSize,
      );
    }),
    errorStyle: const TextStyle(
      color: AppColors.red,
      fontSize: bodyMediumTextSize,
    ),
    floatingLabelStyle: const TextStyle(
      color: AppColors.grey,
      fontSize: bodyLargeTextSize,
    ),
    prefixStyle: const TextStyle(
      color: AppColors.grey,
      fontSize: titleSmallTextSize,
    ),
    suffixIconColor: WidgetStateColor.resolveWith((Set<WidgetState> state) {
      if (state.contains(WidgetState.disabled)) {
        return AppColors.lightGrey;
      }

      return AppColors.grey;
    }),
  );
}

TextTheme textTheme() {
  return const TextTheme(
    displaySmall: TextStyle(color: AppColors.lightBlack),
    displayMedium: TextStyle(color: AppColors.lightBlack),
    displayLarge: TextStyle(color: AppColors.lightBlack),
    headlineSmall: TextStyle(color: AppColors.lightBlack),
    headlineMedium: TextStyle(color: AppColors.lightBlack),
    headlineLarge: TextStyle(color: AppColors.lightBlack),
    titleSmall: TextStyle(color: AppColors.lightBlack),
    titleMedium: TextStyle(color: AppColors.lightBlack),
    titleLarge: TextStyle(color: AppColors.lightBlack),
    bodySmall: TextStyle(color: AppColors.lightBlack),
    bodyMedium: TextStyle(color: AppColors.lightBlack),
    bodyLarge: TextStyle(color: AppColors.lightBlack),
    labelLarge: TextStyle(color: AppColors.lightBlack),
    labelMedium: TextStyle(color: AppColors.lightBlack),
    labelSmall: TextStyle(color: AppColors.lightBlack),
  ).apply(
    decorationColor: AppColors.lightBlack,
    bodyColor: AppColors.lightBlack,
    displayColor: AppColors.lightBlack,
  );
}

ProgressIndicatorThemeData progressIndicatorThemeData() {
  return const ProgressIndicatorThemeData(
    color: AppColors.primary,
    refreshBackgroundColor: AppColors.white,
    circularTrackColor: Colors.transparent,
    linearTrackColor: Colors.transparent,
    linearMinHeight: 2.2,
  );
}
