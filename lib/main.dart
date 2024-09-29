import 'package:flutter/material.dart';
import 'package:payuung_pribadi_clone/app.dart';
import 'package:payuung_pribadi_clone/database/database_utils.dart';

Future<void> main() async {
  await StorageBase.init();
  runApp(const App());
}
