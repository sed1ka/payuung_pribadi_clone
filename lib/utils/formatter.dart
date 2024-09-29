import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:payuung_pribadi_clone/commons/colors.dart';
import 'package:payuung_pribadi_clone/utils/helper.dart';


final NumberFormat _thousandSeparatorFormat = NumberFormat('#,###', 'id_ID');

extension KreduitDateTimeFormatter on DateTime {
  String toStringFormatted({String dateTimeFormat = 'dd/MM/yyyy | HH:mm'}) {
    final String dateTimeFormatted = DateFormat(dateTimeFormat).format(this);
    return dateTimeFormatted;
  }
}

extension KreduitDateIntFormatter on int {
  ///[toDateFromEpoch] is extension to convert int to Formatted DateTime
  String toDateFromEpoch({String dateTimeFormat = 'dd/MM/yyyy'}) {
    int milliseconds = '$this'.length == 10 ? this * 1000 : this;
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    final String dateTimeFormatted =
        DateFormat(dateTimeFormat).format(dateTime);
    return dateTimeFormatted;
  }

  String toTimeFromEpoch({String timeFormat = 'HH:mm'}) {
    int milliseconds = '$this'.length == 10 ? this * 1000 : this;
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    final String timeFormatted = DateFormat(timeFormat).format(dateTime);
    return timeFormatted;
  }

  String toTimeLeftFromEpoch({
    String? currentTimeText,
    bool useSimpleDateFormat = false,
    bool useSpecificTimeAfterDay = false,
  }) {
    return _countTimeLeft(
      this,
      'lagi',
      currentTimeText: currentTimeText,
      useSimpleDateFormat: useSimpleDateFormat,
      useSpecificTimeAfterDay: useSpecificTimeAfterDay,
    );
  }

  String toTimeAgoFromEpoch({
    String? currentTimeText,
    bool useSimpleDateFormat = false,
    bool useSpecificTimeAfterDay = false,
  }) {
    return _countTimeLeft(
      this,
      'yang lalu',
      currentTimeText: currentTimeText ?? 'Baru saja',
      useSimpleDateFormat: useSimpleDateFormat,
      useSpecificTimeAfterDay: useSpecificTimeAfterDay,
    );
  }

  int customRound({required int min, required int max, required int multiple}) {
    log('customRound raw value: $this', name: 'Formatter');
    log('customRound multiple: $multiple', name: 'Formatter');
    if (this <= min) return min;
    if (this >= max) return max;

    int remainder = this % multiple;

    int lowerBound = (multiple * 20 / 100).round();
    int upperBound = (multiple * 80 / 100).round();

    log('customRound remainded: $remainder', name: 'Formatter');
    log('customRound lowerBound: $lowerBound', name: 'Formatter');
    log('customRound upperBound: $upperBound', name: 'Formatter');
    log('remainder <= lowerBound): ${remainder <= lowerBound} | return: ${this - remainder}',
        name: 'Formatter');
    log('remainder >= upperBound): ${remainder >= (upperBound - multiple)} | return: ${this + (multiple - remainder)}',
        name: 'Formatter');

    if (remainder <= lowerBound) {
      return (this ~/ multiple) * multiple;
    }

    if (remainder >= (multiple - upperBound)) {
      return ((this ~/ multiple) + 1) * multiple;
    }

    return this;
  }
}

extension KreduitStringManipulations on String {
  /// Example usage: 'hello world'.toCapitalized()
  /// result: 'Hello world'
  ///
  /// Example usage: 'HELLO WORLD'.toCapitalized() with frontOnly set to false
  /// result : 'HELLO WORLD'
  ///
  /// Example usage: 'HELLO WORLD'.toCapitalized() with frontOnly set to true
  /// result : 'Hello world'
  String toCapitalized({bool forceFrontOnly = false}) {
    if (isEmpty) return '';
    return '${this[0].toUpperCase()}${!forceFrontOnly ? substring(1) : substring(1).toLowerCase()}';
  }

  /// Example usage: 'hello world'.toTitleCase()
  /// result: 'Hello World'
  String toTitleCase() {
    if (isEmpty) return '';
    return replaceAll(RegExp(' +'), ' ')
        .split(' ')
        .map((String str) => str.toCapitalized())
        .join(' ');
  }

  /// /////////////////////////
  /// Obscure - Censor Text ///
  /// /////////////////////////
  /// Example input: 081282128101
  /// [obscureText] output: 081*****101
  String obscureText({String? nullValue}) {
    if (isEmpty || this == '') return nullValue ?? '-';

    String obsecure = '*****';

    if (length <= 3) {
      /// Kurang dari 3
      return obsecure;
    } else if (length <= 6 && length > 3) {
      /// Lebih dari 3 dan kurang dari 6
      return replaceRange(1, length - 2, '*' * (length - 3));
    } else if (length > 6) {
      /// lebih dari 7
      return replaceRange(3, length - 3, '*****');
    }

    log('#Helper WARNING! obscureText: [$this] length not more than 3. or maybe contains Null');
    return '****';
  }

  /// Example input: example@gmail.com
  /// [obscureEmail] output: ex****e@g***l.com
  ///
  /// but if input: this is not a email
  /// output: th*****ail
  String obscureEmail() {
    if (contains('@')) {
      final List<String> splitEmail = split('@');
      String emailAddress = splitEmail.first;
      String emailDomain = splitEmail.last;

      int firstReplace = 0;
      int secondReplace = 0;
      if (emailAddress.length <= 3 && emailAddress.length > 1) {
        firstReplace = 1;
        secondReplace = emailAddress.length - 1;
      } else if (emailAddress.length <= 5 && emailAddress.length > 3) {
        firstReplace = 2;
        secondReplace = emailAddress.length - 1;
      } else if (emailAddress.length <= 6 && emailAddress.length > 5) {
        firstReplace = 2;
        secondReplace = emailAddress.length - 2;
      } else if (emailAddress.length <= 10 && emailAddress.length > 6) {
        firstReplace = 3;
        secondReplace = emailAddress.length - 3;
      } else if (emailAddress.length > 10) {
        firstReplace = 4;
        secondReplace = emailAddress.length - 4;
      }

      emailAddress = emailAddress.replaceRange(
        firstReplace,
        secondReplace,
        '*' * ((secondReplace - firstReplace)),
      );

      final List<String> splitDomain = emailDomain.split('.');
      String mainDomain = splitDomain.sublist(1).join('.');
      String subDomain = splitDomain.first.obscureText();

      emailDomain = '$subDomain.$mainDomain';
      return '$emailAddress@$emailDomain';
    } else {
      log('#Helper WARNING! obscureEmail: [$this] is not indicated email format, or maybe contains Null');
      return obscureText();
    }
  }

  String trimInstaceFlag() {
    if (contains("Instance of '")) {
      return substring(13, length - 1);
    } else {
      return this;
    }
  }

  num toNumFromThousandString({bool forceToInt = true}) {
    String stringWithoutDots = replaceAll('.', '');
    if (!forceToInt && stringWithoutDots.contains(',')) {
      String stringChangeComaToDot = stringWithoutDots.replaceAll(',', '.');
      return double.parse(stringChangeComaToDot);
    }
    return int.parse(stringWithoutDots);
  }
}

extension HexColor on Color {
  static Color fromHex(
    String? hexString, {
    Color defaultColor = AppColors.white,
  }) {
    if (hexString == null) return defaultColor;
    if (hexString.length < 6 || hexString.length > 7) {
      log(
        'fromHex: Hex Color format is Wrong. The hex value is $hexString',
        name: 'Formatter',
        level: 1000,
      );
      return defaultColor;
    }
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('FF');
    buffer.write(hexString.replaceFirst('#', '').toUpperCase());
    int? formattedColor = int.tryParse(buffer.toString(), radix: 16);
    if (formattedColor == null) {
      return defaultColor;
    } else {
      return Color(formattedColor);
    }
  }

  bool isDarkColor() {
    const flipEstimatedScreenLightness =
        0.342; // based on APCA™ 0.98G middle contrast BG

    const double transferCurve = 2.4,
        redCoefficient = 0.2126729,
        greenCoefficient = 0.7151522,
        blueCoefficient = 0.0721750; // 0.98G

    double estimatedScreenLightness =
        (math.pow(red / 255.0, transferCurve) * redCoefficient) +
            (math.pow(green / 255.0, transferCurve) * greenCoefficient) +
            (math.pow(blue / 255.0, transferCurve) * blueCoefficient);

    return estimatedScreenLightness < flipEstimatedScreenLightness;
  }
}

String _countTimeLeft(
  int epochValue,
  String suffix, {
  String? currentTimeText,
  bool useSimpleDateFormat = false,
  bool useSpecificTimeAfterDay = false,
}) {
  int milliseconds =
      '$epochValue'.length == 10 ? epochValue * 1000 : epochValue;
  final DateTime dateData = DateTime.fromMillisecondsSinceEpoch(milliseconds);
  final DateTime now = DateTime.now();
  final Duration difference = dateData.difference(now);
  final Duration absoluteDifference = difference.abs();
  final bool isPast = difference.isNegative;

  String timeFormat =
      useSpecificTimeAfterDay ? ' \u2022 ${epochValue.toTimeFromEpoch()}' : '';

  if (absoluteDifference.inDays > 1) {
    if (useSimpleDateFormat ||
        useSpecificTimeAfterDay ||
        absoluteDifference.inDays > 7) {
      if (now.year == dateData.year) {
        String dateFormat = DateFormat(useSimpleDateFormat ? 'dd/MM' : 'dd MMM')
            .format(dateData);
        return '$dateFormat$timeFormat';
      } else {
        String dateFormat =
            DateFormat(useSimpleDateFormat ? 'dd/MM/yyyy' : 'dd MMM yyyy')
                .format(dateData);
        return '$dateFormat$timeFormat';
      }
    } else {
      return '${absoluteDifference.inDays} hari $suffix';
    }
  } else if (absoluteDifference.inDays == 1) {
    return isPast ? 'Kemarin$timeFormat' : 'Besok$timeFormat';
  } else if (absoluteDifference.inHours > 1) {
    return '${absoluteDifference.inHours} jam $suffix';
  } else if (absoluteDifference.inHours == 1) {
    return '1 jam $suffix';
  } else if (absoluteDifference.inMinutes > 1) {
    return '${absoluteDifference.inMinutes} menit $suffix';
  } else if (absoluteDifference.inMinutes == 1) {
    return '1 menit $suffix';
  } else if (absoluteDifference.inSeconds >= 3) {
    return '${absoluteDifference.inSeconds} detik $suffix';
  } else {
    return currentTimeText ?? '';
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text.toUpperCase();

    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
  }
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text.toLowerCase();

    return TextEditingValue(
      text: value,
      selection: newValue.selection,
    );
  }
}

// value = value.trim();
// var singleSpaces = value.replaceAll();

class SingleSpaceTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text.replaceAll('  ', ' ');

    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
  }
}

class RupiahTextFormatter extends TextInputFormatter {
  RupiahTextFormatter({this.useDefaultValue = false});

  /// set [useDefaultValue] to true if want to set default value is 0 when
  /// value is empty.
  final bool useDefaultValue;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newerValue = newValue.text.isEmpty
        ? ''
        : newValue.text.replaceAll(regExpSymbolExceptDot, '');

    if (newerValue.isEmpty) {
      return TextEditingValue(
        text: useDefaultValue ? '0' : '',
        selection: TextSelection.fromPosition(const TextPosition(
          offset: 1,
        )),
      );
    }

    if (newerValue.compareTo(oldValue.text) == 0) {
      return TextEditingValue(
        text: useDefaultValue ? '0' : '',
        selection: TextSelection.fromPosition(const TextPosition(
          offset: 1,
        )),
      );
    }

    int selectionIndexFromTheRight =
        newValue.text.length - newValue.selection.end;

    /// If user pressing delete when pointer is behind DOT.
    /// need to delete Character in front of the DOT
    if (oldValue.text.isNotEmpty) {
      if (oldValue.text[oldValue.selection.end - 1] == '.' &&
          oldValue.text.length >= newValue.text.length) {
        /// prefert [getIndexOfTextFrontDot] lower than 0
        int getIndexOfTextFrontDot = oldValue.selection.end - 1 - 1;
        getIndexOfTextFrontDot =
            getIndexOfTextFrontDot >= 0 ? getIndexOfTextFrontDot : 0;

        List<String> splitedText = newValue.text.split('');
        splitedText.removeAt(getIndexOfTextFrontDot);
        newerValue = splitedText.join();
      }
    }

    final int number = newerValue.toNumFromThousandString().toInt();
    final String thousandValue = _thousandSeparatorFormat.format(number);
    return TextEditingValue(
      text: thousandValue,
      selection: TextSelection.collapsed(
        offset: thousandValue.length - selectionIndexFromTheRight,
      ),
    );
  }
}
