import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_clone/commons/constants.dart';
import 'package:payuung_pribadi_clone/commons/state.dart';
import 'package:payuung_pribadi_clone/database/database_utils.dart';
import 'package:payuung_pribadi_clone/features/personal_information/address/address_event.dart';
import 'package:payuung_pribadi_clone/model/personal_information/address_model.dart';
import 'package:payuung_pribadi_clone/model/personal_information/personal_address_model.dart';

export 'package:payuung_pribadi_clone/commons/state.dart';
export 'package:payuung_pribadi_clone/features/personal_information/address/address_event.dart';

class AddressBloc extends Bloc<AddressEvent, AppState> {
  AddressBloc() : super(const AppStateInitial()) {
    on<DataChangedEvent>(_dataChanged);
    on<SubmitDataEvent>(_submitData);
    on<LoadDataEvent>(_loadData);
  }

  final Duration validationWarningDuration = const Duration(milliseconds: 1800);
  PersonalAddressModel data = PersonalAddressModel();
  bool _triggerStateSwitch = false;

  bool get isKtpValid => (data.ktpFile?.source?.isNotEmpty ?? false);

  bool get isNIKValid => isNIKNotEmpty && isNIKFormatValid;

  bool get isNIKNotEmpty => (data.nik?.isNotEmpty ?? false);

  bool get isNIKFormatValid => (data.nik?.length == 16);

  bool get isAlamatKtpValid =>
      isProvinsiValid &&
      isKotaValid &&
      isKecamatanValid &&
      isKelurahanValid &&
      isKodePosValid;

  bool get isAlamatValid => (data.alamatKtp?.alamat?.isNotEmpty ?? false);

  bool get isProvinsiValid => (data.alamatKtp?.provinsi?.isNotEmpty ?? false);

  bool get isKotaValid => (data.alamatKtp?.kota?.isNotEmpty ?? false);

  bool get isKecamatanValid => (data.alamatKtp?.kecamatan?.isNotEmpty ?? false);

  bool get isKelurahanValid => (data.alamatKtp?.kelurahan?.isNotEmpty ?? false);

  bool get isKodePosValid => isKodePosNotEmpty && isKodePosFormatValid;

  bool get isKodePosNotEmpty => (data.alamatKtp?.kodepos?.isNotEmpty ?? false);

  bool get isKodePosFormatValid => (data.alamatKtp?.kodepos?.length == 5);

  bool get isValid => isKtpValid && isNIKValid && isAlamatKtpValid;

  Future<void> _dataChanged(DataChangedEvent event, emit) async {
    data = data.copyWith(
      ktpFile: event.data?.ktpFile,
      nik: event.data?.nik,
      alamatKtp: (data.alamatKtp ?? AddressModel()).copyWith(
        alamat: event.data?.alamatKtp?.alamat,
        provinsi: event.data?.alamatKtp?.provinsi,
        kota: event.data?.alamatKtp?.kota,
        kecamatan: event.data?.alamatKtp?.kecamatan,
        kelurahan: event.data?.alamatKtp?.kelurahan,
        kodepos: event.data?.alamatKtp?.kodepos,
      ),
      alamatDomisili: (data.alamatKtp ?? AddressModel()).copyWith(
        alamat: event.data?.alamatKtp?.alamat,
        provinsi: event.data?.alamatKtp?.provinsi,
        kota: event.data?.alamatKtp?.kota,
        kecamatan: event.data?.alamatKtp?.kecamatan,
        kelurahan: event.data?.alamatKtp?.kelurahan,
        kodepos: event.data?.alamatKtp?.kodepos,
      ),
    );

    log('DataChanged: isValid: $isValid', name: 'AddressBloc');

    _triggerStateSwitch = !_triggerStateSwitch;
    emit(AppStateTrigger(_triggerStateSwitch));
  }

  Future<void> _submitData(SubmitDataEvent event, emit) async {
    if (state is AppStateLoading) return;

    emit(const AppStateLoading());
    if (!isValid) {
      String message = 'Data ada yang kosong';
      if (!isKtpValid) {
        message = 'Amnil Foto Ktp Terlebih Dahulu';
      } else if (!isNIKNotEmpty) {
        message = 'Isi Nomor Induk Kependudukan';
      } else if (!isNIKFormatValid) {
        message = 'Format Nomor Induk Kependudukan Salah';
      } else if (!isAlamatValid) {
        message = 'Isi Alamat';
      } else if (!isProvinsiValid) {
        message = 'Pilih Provinsi';
      } else if (!isKotaValid) {
        message = 'Pilih Kota';
      } else if (!isKecamatanValid) {
        message = 'Pilih Kecamatan';
      } else if (!isKelurahanValid) {
        message = 'Pilih Kelurahan';
      } else if (!isKodePosNotEmpty) {
        message = 'Isi Kode Pos';
      } else if (!isKodePosFormatValid) {
        message = 'Format Kode Pos Salah';
      }

      emit(AppStateError(
        message,
        errorType: ErrorType.invalidSubmit,
      ));
      await Future<void>.delayed(
        Duration(milliseconds: validationWarningDuration.inMilliseconds - 400),
      );
      emit(const AppStateError(
        '',
        errorType: ErrorType.askToResubmit,
      ));
      return;
    }

    try {
      await StorageBase.simpan(
        StorageKey.address,
        value: data.toJsonString(),
      ).timeout(basicRTO);

      emit(const AppStateSuccess(
        message: 'Data berhasil disimpan',
        successType: SuccessType.submit,
      ));
      return;
    } catch (e) {
      emit(const AppStateError(
        'Terjadi kesalahan saat menyimpan data',
        errorType: ErrorType.requestTimeOut,
      ));
      return;
    }
  }

  Future<void> _loadData(LoadDataEvent event, emit) async {
    if (state is AppStateLoading) return;

    emit(const AppStateLoading());

    String? res;
    try {
      res = await StorageBase.baca(StorageKey.address).timeout(basicRTO);
    } on TimeoutException {
      emit(const AppStateError(
        'Waktu tunggu terlalu lama',
        errorType: ErrorType.requestTimeOut,
      ));
      return;
    }

    if (res?.isNotEmpty ?? true && res is String) {
      data = PersonalAddressModel.fromJson(res);
      emit(const AppStateSuccess(successType: SuccessType.load));
      return;
    }
    emit(const AppStateError('', errorType: ErrorType.emptyData));
  }
}
