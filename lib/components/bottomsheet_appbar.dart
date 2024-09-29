import 'package:flutter/material.dart';
import 'package:payuung_pribadi_clone/commons/colors.dart';
import 'package:payuung_pribadi_clone/commons/constants.dart';
import 'package:payuung_pribadi_clone/commons/device_measurement.dart';
import 'package:payuung_pribadi_clone/components/custom_text.dart';


class BottomSheetAppBar extends StatelessWidget {
  const BottomSheetAppBar({
    super.key,
    this.title,
    this.actions,
  });

  final String? title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    const double appBarHeight = 40;
    Widget? trailing;
    if (title?.isNotEmpty ?? false) {
      if (actions != null) {
        trailing = Theme(
          data: Theme.of(context).copyWith(
            iconTheme: IconTheme.of(context).copyWith(
              size: mediumIconSize,
            ),
            iconButtonTheme: IconButtonThemeData(
              style: ButtonStyle(
                iconSize: WidgetStateProperty.resolveWith<double>(
                  (_) => largeIconSize,
                ),
                minimumSize: WidgetStateProperty.resolveWith<Size>(
                  (_) => const Size(smallIconSize, smallIconSize),
                ),
                maximumSize: WidgetStateProperty.resolveWith<Size>(
                  (_) => const Size(largeIconSize + 12, largeIconSize + 12),
                ),
                padding: WidgetStateProperty.resolveWith<EdgeInsets>(
                  (_) => const EdgeInsets.all(4),
                ),
              ),
            ),
          ),
          child: SizedBox(
            height: appBarHeight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: actions!,
            ),
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: MediaQuery.of(context).size.width),
        Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: kDeviceLogicalWidth * 0.10,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            if (title?.isEmpty ?? true) const SizedBox(height: 8),
            if (title?.isNotEmpty ?? false)
              SizedBox(
                height: appBarHeight,
                child: NavigationToolbar(
                  middleSpacing: 15,
                  middle: CustomText.title(
                    title!,
                    fontSize: bodyLargeTextSize,
                    maxLines: 1,
                  ),
                  trailing: trailing,
                ),
              ),
          ],
        ),
        if (title?.isNotEmpty ?? false) const Divider(height: 1),
      ],
    );
  }
}
