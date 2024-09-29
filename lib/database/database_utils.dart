import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StorageBase {
  static late Box _box;

  static Future<dynamic> simpan<T>(String key, {T? value}) async {
    if (value == null) {
      ErrorDescription(
        '#StorageBase Error: value of $key key contains Null or'
        " '' - empty when use $simpan",
      );
      return;
    }

    await _box.put(key, value);
    return value;
  }

  static Future<dynamic> baca(String key) async {
    return await _box.get(key);
  }

  static Future<bool> cekKey(String key) async {
    return _box.containsKey(key);
  }

  static Future<void> hapus(String key) async {
    await _box.delete(key);
  }

  static Future<void> bersihkan() async {
    await _box.clear();
  }

  static Future<void> init() async {
    log(
      '==== Starting Initial ====',
      name: 'MainStorage',
    );
    await Hive.initFlutter();
    _box = await Hive.openBox(
      StorageBox.general,
    );
  }
}

class StorageKey {
  static const String biodata = 'contacts';
  static const String address = 'address';
  static const String company = 'company';
}

class StorageBox {
  static const String general = 'generalBox';
}
