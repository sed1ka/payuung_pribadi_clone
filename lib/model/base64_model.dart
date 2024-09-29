import 'package:payuung_pribadi_clone/utils/json_utils.dart';

class Base64Model {
  Base64Model({
    this.name,
    this.source,
  });

  Base64Model.fromJson(dynamic json) {
    name = json['name'];
    source = json['source'];
  }

  String? name;
  String? source;

  Base64Model copyWith({
    String? name,
    String? source,
  }) =>
      Base64Model(
        name: name ?? this.name,
        source: source ?? this.source,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['source'] = source;
    return map;
  }

  String toJsonString() => mapToJsonString(toJson());

  @override
  String toString() => toJson().toString();
}
