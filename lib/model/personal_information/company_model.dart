import 'package:payuung_pribadi_clone/utils/json_utils.dart';

class CompanyModel {
  CompanyModel({
    this.nama,
    this.alamat,
    this.jabatan,
    this.lamaBekerja,
    this.sumberPendapatan,
    this.pendapatanKotorPerTahun,
    this.namaBank,
    this.cabangBank,
    this.nomorRekening,
    this.namaPemilikRekening,
  });

  CompanyModel.fromJson(dynamic json) {
    if (json is String) {
      json = jsonStringToMap(json);
    }

    nama = json['namaPerusahaan'];
    alamat = json['alamat'];
    jabatan = json['jabatan'];
    lamaBekerja = json['lamaBekerja'];
    sumberPendapatan = json['sumberPendapatan'];
    pendapatanKotorPerTahun = json['pendapatanKotorPerTahun'];
    namaBank = json['namaBank'];
    cabangBank = json['cabangBank'];
    nomorRekening = json['nomorRekening'];
    namaPemilikRekening = json['namaPemilikRekening'];
  }

  String? nama;
  String? alamat;
  String? jabatan;
  String? lamaBekerja;
  String? sumberPendapatan;
  String? pendapatanKotorPerTahun;
  String? namaBank;
  String? cabangBank;
  String? nomorRekening;
  String? namaPemilikRekening;

  CompanyModel copyWith({
    String? nama,
    String? alamat,
    String? jabatan,
    String? lamaBekerja,
    String? sumberPendapatan,
    String? pendapatanKotorPerTahun,
    String? namaBank,
    String? cabangBank,
    String? nomorRekening,
    String? namaPemilikRekening,
  }) =>
      CompanyModel(
        nama: nama ?? this.nama,
        alamat: alamat ?? this.alamat,
        jabatan: jabatan ?? this.jabatan,
        lamaBekerja: lamaBekerja ?? this.lamaBekerja,
        sumberPendapatan: sumberPendapatan ?? this.sumberPendapatan,
        pendapatanKotorPerTahun:
            pendapatanKotorPerTahun ?? this.pendapatanKotorPerTahun,
        namaBank: namaBank ?? this.namaBank,
        cabangBank: cabangBank ?? this.cabangBank,
        nomorRekening: nomorRekening ?? this.nomorRekening,
        namaPemilikRekening: namaPemilikRekening ?? this.namaPemilikRekening,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['namaPerusahaan'] = nama;
    map['alamat'] = alamat;
    map['jabatan'] = jabatan;
    map['lamaBekerja'] = lamaBekerja;
    map['sumberPendapatan'] = sumberPendapatan;
    map['pendapatanKotorPerTahun'] = pendapatanKotorPerTahun;
    map['namaBank'] = namaBank;
    map['cabangBank'] = cabangBank;
    map['nomorRekening'] = nomorRekening;
    map['namaPemilikRekening'] = namaPemilikRekening;
    return map;
  }

  String toJsonString() => mapToJsonString(toJson());

  @override
  String toString() => toJson().toString();
}
