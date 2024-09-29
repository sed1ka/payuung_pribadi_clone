

import 'package:payuung_pribadi_clone/utils/helper.dart';

class FormValidator {
  static const String _cantBeEmpty = 'Tidak boleh kosong';

  static String? checkEmptyValue(
    String? value, {
    String? emptyMessage,
    minLength = 0,
  }) {
    if (value?.isEmpty ?? true) {
      return emptyMessage ?? _cantBeEmpty;
    } else {
      if (minLength > 0) {
        if ((value?.length ?? 0) < minLength) {
          return 'Minimal $minLength karakter';
        }
      }

      return null;
    }
  }

  static String? checkPhoneNumber(String? value, {bool emptyCheck = false}) {
    if (value?.isEmpty ?? true) {
      return emptyCheck ? _cantBeEmpty : null;
    } else {
      if (!regExpPhoneNumber.hasMatch(value!)) {
        if (value.length >= 2 && value.substring(0, 2) == '08') {
          return 'Nomor telepon harus 10-14 digit ';
        }

        return 'Nomor telepon harus diawali 08';
      }
    }
    return null;
  }

  static String? checkPassword(String? value, {bool emptyCheck = false}) {
    if (value?.isEmpty ?? true) {
      return emptyCheck ? _cantBeEmpty : null;
    } else {
      if (value!.length < 8 &&
          !regExpLetterLowerCase.hasMatch(value) &&
          !regExpLetterUpperCase.hasMatch(value) &&
          !regExpNumber.hasMatch(value) &&
          !regExpContainSymbol.hasMatch(value)) {
        return 'Format password tidak sesuai';
      }
    }
    return null;
  }

  static String? checkEmail(String? value, {bool emptyCheck = false}) {
    if (value?.isEmpty ?? true) {
      return emptyCheck ? _cantBeEmpty : null;
    } else {
      if (!regExpMail.hasMatch(value!)) {


        return 'Format email tidak sesuai';
      }
    }

    return null;
  }
}
