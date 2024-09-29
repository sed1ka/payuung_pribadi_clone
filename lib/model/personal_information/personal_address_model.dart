import 'package:payuung_pribadi_clone/model/base64_model.dart';
import 'package:payuung_pribadi_clone/model/personal_information/address_model.dart';
import 'package:payuung_pribadi_clone/utils/json_utils.dart';

class PersonalAddressModel {
  PersonalAddressModel({
    this.ktpFile,
    this.nik,
    this.alamatKtp,
    this.alamatDomisili,
  });

  Base64Model? ktpFile;
  String? nik;
  AddressModel? alamatKtp;
  AddressModel? alamatDomisili;

  PersonalAddressModel.fromJson(dynamic json) {
    if (json is String) {
      json = jsonStringToMap(json);
    }

    ktpFile = json['ktpFile'] != null
        ? Base64Model.fromJson(json['ktpFile'])
        : null;
    nik = json['nik'];
    alamatKtp = json['alamatKtp'] != null
        ? AddressModel.fromJson(json['alamatKtp'])
        : null;
    alamatDomisili = json['alamatDomisili'] != null
        ? AddressModel.fromJson(json['alamatDomisili'])
        : null;
  }

  PersonalAddressModel copyWith({
    Base64Model? ktpFile,
    String? nik,
    AddressModel? alamatKtp,
    AddressModel? alamatDomisili,
  }) {
    return PersonalAddressModel(
      ktpFile: ktpFile ?? this.ktpFile,
      nik: nik ?? this.nik,
      alamatKtp: alamatKtp ?? this.alamatKtp,
      alamatDomisili: alamatDomisili ?? this.alamatDomisili,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ktpFile'] = ktpFile?.toJson();
    map['nik'] = nik;
    map['alamatKtp'] = alamatKtp?.toJson();
    map['alamatDomisili'] = alamatDomisili?.toJson();
    return map;
  }

  String toJsonString() => mapToJsonString(toJson());

  @override
  String toString() => toJson().toString();
}
