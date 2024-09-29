import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

/// /////////
/// Regex ///
/// /////////
/// Regex Letter
final RegExp regExpLetter = RegExp(r'[A-Za-z]');
final RegExp regExpLetterLowerCase = RegExp(r'[a-z]');
final RegExp regExpLetterUpperCase = RegExp(r'[A-Z]');

final RegExp regExpLetterWithSpace = RegExp(r'[A-Za-z ]');
final RegExp regExpLetterLowerCaseWithSpace = RegExp(r'[a-z ]');
final RegExp regExpLetterUpperCaseWithSpace = RegExp(r'[A-Z ]');

/// Regex Number
final RegExp regExpNumber = RegExp(r'\d');
final RegExp regExpPhoneNumber = RegExp(r'(08(\d{8,12}))$');
final RegExp regExpNumeric = RegExp(r'[\d.]');

/// Regex Email / Mail
final RegExp regExpEmail = regExpMail;
final RegExp regExpMail = RegExp(
  r'^([a-zA-Z0-9](?:[a-zA-Z0-9.]{4,62}[a-zA-Z0-9])?)@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,190}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,63}$',
);

final RegExp regExpEmailUsername = RegExp(r'^[\w\d]+(?:\.[\w\d]+)*$');
final RegExp regExpDomain =
    RegExp(r'[a-zA-Z0-9]+\.[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)?$');

/// Regex Symbol
final RegExp regExpContainSymbol = RegExp(r'[^\w\d]');
final RegExp regExpSymbolOnly = RegExp(r'[^\w\d]+$');
final RegExp regExpSymbolExceptDot = RegExp(
  r'[\^$*\[\]{}()?\-"!@#%&/\,><:;_~`+='
  "'"
  ']',
);

/// Regex PIN
final RegExp regExpPIN = RegExp(r'(\d)(?!\1+$)\d{5}');
const notAllowListPin = [
  '123123',
  '456456',
  '789789',
  '012345',
  '123456',
  '234567',
  '345678',
  '456789',
  '567890',
  '098765',
  '987654',
  '876543',
  '765432',
  '654321',
  '543210'
];

/// Regex for iOS custom deeplink
// final RegExp iOSDeeplinkAPN = RegExp('apn=([^&]*)');
// final RegExp iOSDeeplinkLink = RegExp('link=https://foodoo.id([^&]*)');

/// ////////////////////////
/// String Manipulations ///
/// ////////////////////////
String generateRandomString(int lengthOfString, {bool dontUseSymbol = false}) {
  if (lengthOfString < 2) {
    log('#Helper getRandomString: lengthOfString gak boleh kurang dari 2');
    lengthOfString = 2;
  }

  final math.Random random = math.Random();
  String allChars;
  if (dontUseSymbol) {
    allChars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  } else {
    allChars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890'
        '`~!@#%^&*()-_=+[{]};:,<.>/?'
        r'\'
        "'"
        '"';
  }

  // below statement will generate a random string of length using the characters
  // and length provided to it
  final String randomString = List<String>.generate(lengthOfString,
      (int index) => allChars[random.nextInt(allChars.length)]).join();
  return randomString; // return the generated string
}

String generateRandomNumber(int length) {
  if (length < 2) {
    log('#Helper getRandomString: lengthOfString gak boleh kurang dari 2');
    length = 3;
  }

  final math.Random random = math.Random();
  const String allChars = '1234567890';

  // below statement will generate a random string of length using the characters
  // and length provided to it
  final String randomString = List<String>.generate(
      length, (int index) => allChars[random.nextInt(allChars.length)]).join();
  return randomString; // return the generated string
}

String getFirstWords(String sentence, {int wordCounts = 1}) {
  if (sentence.isEmpty) {
    log('#Helper getFirstWords: sentence kosong');
    return '';
  }

  if (wordCounts < 1) {
    log('#Helper getFirstWords: wordCounts gak boleh kurang dari 1');
    wordCounts = 1;
  }

  List<String> words = sentence.split(' ');
  if (words.length >= wordCounts) {
    return words.take(wordCounts).join(' ');
  }

  if (words.length < wordCounts) {
    log('#Helper getFirstWords: panjang word.length lebih kecil dari wordCounts');
  }

  return words.take(1).join();
}

/// Get whatsApp URL
String whatsAppUrl(String phoneNumber, {String message = ''}) {
  String androidUrl = 'whatsapp://send?phone=$phoneNumber&text=$message';
  String iosUrl = 'https://wa.me/$phoneNumber?text=${Uri.parse(message)}';

  if (Platform.isAndroid) {
    return androidUrl;
  } else if (Platform.isIOS) {
    return iosUrl;
  } else {
    return iosUrl;
  }
}
