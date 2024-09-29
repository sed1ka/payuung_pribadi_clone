class Jajal {
  Jajal({
    this.example,});

  Jajal.fromJson(dynamic json) {
    example =
    json['example'] != null ? Example.fromJson(json['example']) : null;
  }

  Example? example;

  Jajal copyWith({ Example? example,
  }) =>
      Jajal(example: example ?? this.example,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (example != null) {
      map['example'] = example?.toJson();
    }
    return map;
  }

}

class Example {
  Example({
    this.jajal,});

  Example.fromJson(dynamic json) {
    jajal = json['jajal'];
  }

  String? jajal;

  Example copyWith({ String? jajal,
  }) =>
      Example(jajal: jajal ?? this.jajal,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['jajal'] = jajal;
    return map;
  }

}