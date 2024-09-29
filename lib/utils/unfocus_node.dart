import 'package:flutter/widgets.dart';

/// [unfocusNode] is used For unfocus node of TextField
void unfocusNode(BuildContext context) {
  final FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

/// [unfocus] is used For unfocus node of TextField
void unfocus(BuildContext context) {
  final FocusNode currentFocus = Focus.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus == true) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}