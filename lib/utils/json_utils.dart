import 'dart:convert';
import 'dart:developer';

/// NOTE
/// example use: mapToJsonString(ModelData.toJson());
String mapToJsonString(
  Map<String, dynamic> data, {
  String? defaultValue,
  bool printLog = false,
  bool pretty = false,
}) {
  try {
    return pretty == true
        ? const JsonEncoder.withIndent('\t').convert(data)
        : const JsonEncoder().convert(data);
  } catch (e) {
    if (printLog) {
      log('mapToJsonString: ${e.toString()}');
    }
    return defaultValue ?? '#NA';
  }
}

Map<String, dynamic> jsonStringToMap(
  String json, {
  Map<String, dynamic>? defaultValue,
  bool printLog = false,
}) {
  try {
    return const JsonDecoder().convert(json) as Map<String, dynamic>;
  } on FormatException catch (e) {
    if (printLog) {
      log('jsonStringToMap: ${e.toString()}');
    }

    return defaultValue ?? <String, dynamic>{};
  }
}
