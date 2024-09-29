import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_clone/commons/constants.dart';
import 'package:payuung_pribadi_clone/commons/state.dart';
import 'package:payuung_pribadi_clone/database/database_utils.dart';
import 'package:payuung_pribadi_clone/features/personal_information/company/company_event.dart';
import 'package:payuung_pribadi_clone/model/personal_information/company_model.dart';

export 'package:payuung_pribadi_clone/commons/state.dart';
export 'package:payuung_pribadi_clone/features/personal_information/company/company_event.dart';

class CompanyBloc extends Bloc<CompanyEvent, AppState> {
  CompanyBloc() : super(const AppStateInitial()) {
    on<DataChangedEvent>(_dataChanged);
    on<SubmitDataEvent>(_submitData);
    on<LoadDataEvent>(_loadData);
  }

  CompanyModel companyModel = CompanyModel();
  bool _triggerStateSwitch = false;

  bool get isNamaLengkapValid => (companyModel.nama?.isNotEmpty ?? false);

  bool get isAlamatValid => (companyModel.alamat?.isNotEmpty ?? false);

  bool get isLamaBekerjaValid =>
      (companyModel.lamaBekerja?.isNotEmpty ?? false);

  bool get isSumberPendapatanValid =>
      (companyModel.sumberPendapatan?.isNotEmpty ?? false);

  bool get isPendapatanKotorPerTahunValid =>
      (companyModel.pendapatanKotorPerTahun?.isNotEmpty ?? false);

  bool get isNamaBankValid =>
      (companyModel.pendapatanKotorPerTahun?.isNotEmpty ?? false);

  bool get isCabangBankValid =>
      (companyModel.pendapatanKotorPerTahun?.isNotEmpty ?? false);

  bool get isNomorRekeningValid =>
      (companyModel.pendapatanKotorPerTahun?.isNotEmpty ?? false);

  bool get isNamaPemilikRekeningValid =>
      (companyModel.pendapatanKotorPerTahun?.isNotEmpty ?? false);

  bool get isValid =>
      isNamaLengkapValid ||
      isAlamatValid ||
      isLamaBekerjaValid ||
      isSumberPendapatanValid ||
      isPendapatanKotorPerTahunValid ||
      isNamaBankValid ||
      isCabangBankValid ||
      isNomorRekeningValid ||
      isNamaPemilikRekeningValid;

  Future<void> _dataChanged(DataChangedEvent event, emit) async {
    companyModel = companyModel.copyWith(
      nama: event.data?.nama,
      alamat: event.data?.alamat,
      lamaBekerja: event.data?.lamaBekerja,
      sumberPendapatan: event.data?.sumberPendapatan,
      pendapatanKotorPerTahun: event.data?.pendapatanKotorPerTahun,
      namaBank: event.data?.namaBank,
      cabangBank: event.data?.cabangBank,
      nomorRekening: event.data?.nomorRekening,
      namaPemilikRekening: event.data?.namaPemilikRekening,
    );

    log('DataChanged: isValid: $isValid', name: 'CompanyBloc');

    _triggerStateSwitch = !_triggerStateSwitch;
    emit(AppStateTrigger(_triggerStateSwitch));
  }

  Future<void> _submitData(SubmitDataEvent event, emit) async {
    if (state is AppStateLoading) return;

    emit(const AppStateLoading());
    if (isValid == false) {
      if (await StorageBase.cekKey(StorageKey.company)) {
        await StorageBase.hapus(StorageKey.company).timeout(basicRTO);
      }
      emit(const AppStateSuccess(
        message: 'Data berhasil disimpan',
        successType: SuccessType.submit,
      ));
      return;
    }

    try {
      await StorageBase.simpan(
        StorageKey.company,
        value: companyModel.toJsonString(),
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
      res = await StorageBase.baca(StorageKey.company).timeout(basicRTO);
    } on TimeoutException {
      emit(const AppStateError(
        'Waktu tunggu terlalu lama',
        errorType: ErrorType.requestTimeOut,
      ));
      return;
    }

    if (res?.isNotEmpty ?? true && res is String) {
      companyModel = CompanyModel.fromJson(res);
      emit(const AppStateSuccess(successType: SuccessType.load));
      return;
    }
    emit(const AppStateError('', errorType: ErrorType.emptyData));
  }
}
