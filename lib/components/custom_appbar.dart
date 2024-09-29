import 'package:flutter/material.dart';
import 'package:payuung_pribadi_clone/commons/colors.dart';
import 'package:payuung_pribadi_clone/commons/constants.dart';
import 'package:payuung_pribadi_clone/components/custom_back_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.bottom,
    this.titleSpacing,
    this.elevation,
    this.leadingWidth,
    this.backgroundColor,
    this.shadowColor,
    this.useAccentTheme = false,
    this.centerTitle = true,
    this.backButtonBackgroundColor,
    this.useCloseButton,
    this.flexibleSpace,
    this.forceTransparency = false,
  }) : preferredSize = _PreferredAppBarSize(bottom?.preferredSize.height);

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final PreferredSizeWidget? bottom;
  final double? titleSpacing;
  final double? elevation;
  final double? leadingWidth;
  final Color? backgroundColor;
  final Color? shadowColor;
  final Color? backButtonBackgroundColor;
  final bool useAccentTheme;
  final bool centerTitle;
  final bool? useCloseButton;
  final Widget? flexibleSpace;
  final bool forceTransparency;

  @override
  Widget build(BuildContext context) {
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final bool useCloseIconButton = useCloseButton ??
        parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;
    final bool hasEndDrawer = scaffold?.hasEndDrawer ?? false;
    final bool canPop = parentRoute?.canPop ?? false;

    Widget? getLeading = leading;
    if (getLeading == null && automaticallyImplyLeading) {
      if ((!hasEndDrawer && canPop) ||
          (parentRoute?.impliesAppBarDismissal ?? false)) {
        getLeading = useCloseIconButton
            ? const CloseButton()
            : CustomBackButton(
                color: useAccentTheme ? AppColors.white : AppColors.black,
                backgroundColor: backButtonBackgroundColor,
              );
      }
    }
    if (getLeading != null) {
      getLeading = ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: leadingWidth ?? 56),
        child: getLeading,
      );
    }

    return AppBar(
      key: key,
      title: title,
      forceMaterialTransparency: forceTransparency,
      backgroundColor: backgroundColor ??
          (useAccentTheme ? AppColors.primary : AppColors.white),
      shadowColor: shadowColor,
      centerTitle: centerTitle,
      titleSpacing: (getLeading != null ? (titleSpacing ?? 0) : 15),
      elevation: elevation,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leadingWidth: leadingWidth,
      leading: getLeading,
      actions: actions,
      bottom: bottom,
      flexibleSpace: flexibleSpace,
    );
  }

  @override
  final Size preferredSize;
}

class _PreferredAppBarSize extends Size {
  _PreferredAppBarSize(this.bottomHeight)
      : super.fromHeight(kAppBarHeight + (bottomHeight ?? 0));

  final double? bottomHeight;
}
