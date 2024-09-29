import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_clone/commons/constants.dart';
import 'package:payuung_pribadi_clone/commons/state.dart';
import 'package:payuung_pribadi_clone/database/database_utils.dart';
import 'package:payuung_pribadi_clone/features/personal_information/biodata/biodata_event.dart';
import 'package:payuung_pribadi_clone/model/personal_information/biodata_model.dart';
import 'package:payuung_pribadi_clone/utils/helper.dart';

export 'package:payuung_pribadi_clone/commons/state.dart';
export 'package:payuung_pribadi_clone/features/personal_information/biodata/biodata_event.dart';

class BiodataBloc extends Bloc<BiodataEvent, AppState> {
  BiodataBloc() : super(const AppStateInitial()) {
    on<DataChangedEvent>(_dataChanged);
    on<SubmitDataEvent>(_submitData);
    on<LoadDataEvent>(_loadData);
  }

  final Duration validationWarningDuration = const Duration(milliseconds: 1800);
  BiodataModel biodataModel = BiodataModel();
  bool _triggerStateSwitch = false;

  bool get isNamaLengkapValid =>
      (biodataModel.namaLengkap?.isNotEmpty ?? false);

  bool get isTanggalLahirValid => biodataModel.tanggalLahir != null;

  bool get isJenisKelaminValid =>
      (biodataModel.jenisKelamin?.isNotEmpty ?? false);

  bool get isAlamatEmailValid =>
      isAlamatEmailNotEmpty && isAlamatEmailFormatValid;

  bool get isAlamatEmailNotEmpty =>
      (biodataModel.alamatEmail?.isNotEmpty ?? false);

  bool get isAlamatEmailFormatValid =>
      regExpMail.hasMatch(biodataModel.alamatEmail ?? '');

  bool get isNoHpValid => isNoHpNotEmpty && isNoHpFormatValid;

  bool get isNoHpNotEmpty => (biodataModel.noHp?.isNotEmpty ?? false);

  bool get isNoHpFormatValid =>
      regExpPhoneNumber.hasMatch(biodataModel.noHp ?? '');

  bool get isValid =>
      isNamaLengkapValid &&
      isTanggalLahirValid &&
      isJenisKelaminValid &&
      isAlamatEmailValid &&
      isNoHpValid;

  Future<void> _dataChanged(DataChangedEvent event, emit) async {
    biodataModel = biodataModel.copyWith(
      namaLengkap: event.data?.namaLengkap,
      tanggalLahir: event.data?.tanggalLahir,
      jenisKelamin: event.data?.jenisKelamin,
      alamatEmail: event.data?.alamatEmail,
      noHp: event.data?.noHp,
      pendidikan: event.data?.pendidikan,
      statusPernikahan: event.data?.statusPernikahan,
    );

    log('DataChanged: isValid: $isValid', name: 'BiodataBloc');

    _triggerStateSwitch = !_triggerStateSwitch;
    emit(AppStateTrigger(_triggerStateSwitch));
  }

  Future<void> _submitData(SubmitDataEvent event, emit) async {
    if (state is AppStateLoading) return;

    emit(const AppStateLoading());
    if (!isValid) {
      String message = 'Data ada yang kosong';
      if (!isNamaLengkapValid) {
        message = 'Isi Nama Lengkap';
      } else if (!isTanggalLahirValid) {
        message = 'Pilih Tanggal Lahir';
      } else if (!isJenisKelaminValid) {
        message = 'Pilih Jenis Kelamin';
      } else if (!isAlamatEmailNotEmpty) {
        message = 'Isi Alamat Email';
      } else if (!isAlamatEmailFormatValid) {
        message = 'Format Alamat Email Salah';
      } else if (!isNoHpNotEmpty) {
        message = 'Isi Nomor Handphone';
      } else if (!isNoHpFormatValid) {
        message = 'Format Nomor Handphone Salah';
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
        StorageKey.biodata,
        value: biodataModel.toJsonString(),
      );

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
      res = await StorageBase.baca(StorageKey.biodata).timeout(basicRTO);
    } on TimeoutException {
      emit(const AppStateError(
        'Waktu tunggu terlalu lama',
        errorType: ErrorType.requestTimeOut,
      ));
      return;
    }

    if (res?.isNotEmpty ?? true && res is String) {
      biodataModel = BiodataModel.fromJson(res);
      emit(const AppStateSuccess(successType: SuccessType.load));
      return;
    }

    emit(const AppStateError('', errorType: ErrorType.emptyData));
  }
}
