import 'package:payuung_pribadi_clone/utils/json_utils.dart';

class AddressModel {
  AddressModel({
    this.alamat,
    this.provinsi,
    this.kota,
    this.kecamatan,
    this.kelurahan,
    this.kodepos,
  });

  AddressModel.fromJson(dynamic json) {
    if (json is String) {
      json = jsonStringToMap(json);
    }

    alamat = json['alamat'];
    provinsi = json['provinsi'];
    kota = json['kota'];
    kecamatan = json['kecamatan'];
    kelurahan = json['kelurahan'];
    kodepos = json['kodepos'];
  }

  String? alamat;
  String? provinsi;
  String? kota;
  String? kecamatan;
  String? kelurahan;
  String? kodepos;

  AddressModel copyWith({
    String? alamat,
    String? provinsi,
    String? kota,
    String? kecamatan,
    String? kelurahan,
    String? kodepos,
  }) =>
      AddressModel(
        alamat: alamat ?? this.alamat,
        provinsi: provinsi ?? this.provinsi,
        kota: kota ?? this.kota,
        kecamatan: kecamatan ?? this.kecamatan,
        kelurahan: kelurahan ?? this.kelurahan,
        kodepos: kodepos ?? this.kodepos,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['alamat'] = alamat;
    map['provinsi'] = provinsi;
    map['kota'] = kota;
    map['kecamatan'] = kecamatan;
    map['kelurahan'] = kelurahan;
    map['kodepos'] = kodepos;
    return map;
  }

  String toJsonString() => mapToJsonString(toJson());

  @override
  String toString() => toJson().toString();
}
