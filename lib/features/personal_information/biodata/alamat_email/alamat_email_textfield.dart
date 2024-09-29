import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payuung_pribadi_clone/utils/form_validator.dart';
import 'package:payuung_pribadi_clone/utils/formatter.dart';

class AlamatEmailTextField extends StatelessWidget {
  const AlamatEmailTextField({
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
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      textCapitalization: TextCapitalization.none,
      validator: (String? value) =>
          FormValidator.checkEmail(value),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.deny(' '),
        LengthLimitingTextInputFormatter(256),
        LowerCaseTextFormatter(),
      ],
      decoration: const InputDecoration(
        labelText: 'Alamat Email',
        hintText: 'Masukkan data',
      ),
    );
  }
}
