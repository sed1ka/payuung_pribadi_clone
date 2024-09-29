import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payuung_pribadi_clone/utils/form_validator.dart';

class NomorHpTextField extends StatelessWidget {
  const NomorHpTextField({
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      canRequestFocus: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'\d')),
        LengthLimitingTextInputFormatter(14),
      ],
      validator: (String? value) =>
          FormValidator.checkPhoneNumber(
            value,
            emptyCheck: false,
          ),
      decoration: const InputDecoration(
        labelText: 'Nomor HP',
        hintText: 'Masukkan data',
      ),
    );
  }
}
