import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payuung_pribadi_clone/utils/formatter.dart';
import 'package:payuung_pribadi_clone/utils/helper.dart';

class NamaPerusahaanTextField extends StatelessWidget {
  const NamaPerusahaanTextField({
    super.key,
    this.focusNode,
    required this.controller,
    this.onChanged,
    this.onEditingComplete,
    this.enabled = true,
    this.formFieldKey,
  });

  final FocusNode? focusNode;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final GlobalKey<FormFieldState>? formFieldKey;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: formFieldKey,
      enabled: enabled,
      autofocus: false,
      focusNode: focusNode,
      controller: controller,
      autovalidateMode: AutovalidateMode.disabled,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      canRequestFocus: true,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(regExpLetterWithSpace),
        LengthLimitingTextInputFormatter(60),
        UpperCaseTextFormatter(),
        SingleSpaceTextFormatter(),
      ],
      decoration: const InputDecoration(
        labelText: 'Nama Perusahaan',
        hintText: 'Masukkan data',
      ),
    );
  }
}
