import 'package:payuung_pribadi_clone/utils/json_utils.dart';

class BiodataModel {
  BiodataModel({
    this.namaLengkap,
    this.tanggalLahir,
    this.jenisKelamin,
    this.alamatEmail,
    this.noHp,
    this.pendidikan,
    this.statusPernikahan,
  });

  BiodataModel.fromJson(dynamic json) {
    if (json is String) {
      json = jsonStringToMap(json);
    }

    namaLengkap = json['namaLengkap'];
    tanggalLahir = json['tanggalLahir'];
    jenisKelamin = json['jenisKelamin'];
    alamatEmail = json['alamatEmail'];
    noHp = json['noHp'];
    pendidikan = json['pendidikan'];
    statusPernikahan = json['statusPernikahan'];
  }

  String? namaLengkap;
  int? tanggalLahir;
  String? jenisKelamin;
  String? alamatEmail;
  String? noHp;
  String? pendidikan;
  String? statusPernikahan;

  BiodataModel copyWith({
    String? namaLengkap,
    int? tanggalLahir,
    String? jenisKelamin,
    String? alamatEmail,
    String? noHp,
    String? pendidikan,
    String? statusPernikahan,
  }) =>
      BiodataModel(
        namaLengkap: namaLengkap ?? this.namaLengkap,
        tanggalLahir: tanggalLahir ?? this.tanggalLahir,
        jenisKelamin: jenisKelamin ?? this.jenisKelamin,
        alamatEmail: alamatEmail ?? this.alamatEmail,
        noHp: noHp ?? this.noHp,
        pendidikan: pendidikan ?? this.pendidikan,
        statusPernikahan: statusPernikahan ?? this.statusPernikahan,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['namaLengkap'] = namaLengkap;
    map['tanggalLahir'] = tanggalLahir;
    map['jenisKelamin'] = jenisKelamin;
    map['alamatEmail'] = alamatEmail;
    map['noHp'] = noHp;
    map['pendidikan'] = pendidikan;
    map['statusPernikahan'] = statusPernikahan;
    return map;
  }

  String toJsonString() => mapToJsonString(toJson());

  @override
  String toString() => toJson().toString();
}
