import 'package:flutter/material.dart';
import 'package:payuung_pribadi_clone/commons/constants.dart';
import 'package:payuung_pribadi_clone/utils/form_validator.dart';
import 'package:payuung_pribadi_clone/utils/unfocus_node.dart';

class DataSelectorTextField extends StatefulWidget {
  const DataSelectorTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.onTap,
    this.formFieldKey,
    this.enabled,
    this.onChanged,
    this.errorFontSize,
    this.suffixIcon,
  });

  final GlobalKey<FormFieldState>? formFieldKey;
  final TextEditingController controller;
  final bool? enabled;
  final String title;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final double? errorFontSize;
  final Widget? suffixIcon;

  @override
  State<DataSelectorTextField> createState() => _DataSelectorTextFieldState();
}

class _DataSelectorTextFieldState extends State<DataSelectorTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // todo: enhancement for auto scroll in DataSelectorTextField
      // Auto Scroll cant be approach with FocusNode
      // because if using focusNode the TextField will trigger
      // the label on InputDecoration a unwanted behaviour
      key: widget.formFieldKey,
      focusNode: AlwaysDisabledFocusNode(),
      enabled: widget.enabled,
      controller: widget.controller,
      enableInteractiveSelection: false,
      keyboardType: TextInputType.none,
      autovalidateMode: AutovalidateMode.disabled,
      validator: (String? value) => FormValidator.checkEmptyValue(
        value,
        emptyMessage: 'Tidak boleh kosong',
      ),
      onChanged: widget.onChanged,
      style: const TextStyle(fontSize: bodyLargeTextSize),
      decoration: InputDecoration(
        labelText: widget.title,
        suffixIconConstraints: const BoxConstraints(
          minWidth: smallIconSize,
          maxHeight: largeIconSize,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 8, 0),
          child: widget.suffixIcon ??
              const Icon(
                Icons.expand_more,
                size: mediumIconSize + 4,
              ),
        ),
        errorStyle: TextStyle(
          fontSize: widget.errorFontSize,
        ),
      ),
      onTap: () {
        if (widget.onTap != null) {
          unfocusNode(context);
          widget.onTap!();
        }
      },
    );
  }
}
