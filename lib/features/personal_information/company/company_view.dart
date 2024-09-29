import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_clone/components/custom_button.dart';
import 'package:payuung_pribadi_clone/components/custom_snackbar.dart';
import 'package:payuung_pribadi_clone/features/personal_information/company/alamat/alamat_perusahaan_textfield.dart';
import 'package:payuung_pribadi_clone/features/personal_information/company/cabang_bank/cabang_bank_textfield.dart';
import 'package:payuung_pribadi_clone/features/personal_information/company/company_bloc.dart';
import 'package:payuung_pribadi_clone/features/personal_information/company/jabatan/jabatan_bloc.dart';
import 'package:payuung_pribadi_clone/features/personal_information/company/lama_bekerja/lama_bekerja_bloc.dart';
import 'package:payuung_pribadi_clone/features/personal_information/company/lama_bekerja/lama_bekerja_selector.dart';
import 'package:payuung_pribadi_clone/features/personal_information/company/nama/nama_perusahaan_textfield.dart';
import 'package:payuung_pribadi_clone/features/personal_information/company/nama_bank/nama_bank_bloc.dart';
import 'package:payuung_pribadi_clone/features/personal_information/company/nama_bank/nama_bank_selector.dart';
import 'package:payuung_pribadi_clone/features/personal_information/company/nama_pemiliki_rekening/nama_pemilik_rekening_textfield.dart';
import 'package:payuung_pribadi_clone/features/personal_information/company/nomor_rekening/nomor_rekening_textfield.dart';
import 'package:payuung_pribadi_clone/features/personal_information/company/pendapatan_kotor_per_tahun/pendapatan_kotor_per_tahun_bloc.dart';
import 'package:payuung_pribadi_clone/features/personal_information/company/pendapatan_kotor_per_tahun/pendapatan_kotor_per_tahun_selector.dart';
import 'package:payuung_pribadi_clone/features/personal_information/company/sumber_pendapatan/sumber_pendapatan_bloc.dart';
import 'package:payuung_pribadi_clone/features/personal_information/company/sumber_pendapatan/sumber_pendapatan_selector.dart';
import 'package:payuung_pribadi_clone/model/personal_information/company_model.dart';
import 'package:payuung_pribadi_clone/utils/unfocus_node.dart';

class CompanyView extends StatefulWidget {
  const CompanyView({
    super.key,
    required this.onSuccess,
    required this.onBack,
  });

  final Function() onSuccess;
  final Function() onBack;

  @override
  State<CompanyView> createState() => _CompanyViewState();
}

class _CompanyViewState extends State<CompanyView>
    with AutomaticKeepAliveClientMixin<CompanyView> {
  late final CompanyBloc bloc;

  final JabatanBloc jabatanBloc = JabatanBloc();
  final LamaBekerjaBloc lamaBekerjaBloc = LamaBekerjaBloc();
  final SumberPendapatanBloc sumberPendapatanBloc = SumberPendapatanBloc();
  final PendapatanKotorPerTahunBloc pendapatanKotorPerTahunBloc =
      PendapatanKotorPerTahunBloc();
  final NamaBankBloc namaBankBloc = NamaBankBloc();

  final TextEditingController namaPerusahaanTextController =
      TextEditingController();
  final TextEditingController alamatPerusahaanTextController =
      TextEditingController();
  final TextEditingController jabatanTextController = TextEditingController();
  final TextEditingController lamaBekerjaTextController =
      TextEditingController();
  final TextEditingController sumberPendapatanTextController =
      TextEditingController();
  final TextEditingController pendapatanKotorPerTahunTextController =
      TextEditingController();
  final TextEditingController namaBankTextController = TextEditingController();
  final TextEditingController cabangBankTextController =
      TextEditingController();
  final TextEditingController nomorRekeningTextController =
      TextEditingController();
  final TextEditingController namaPemilikRekeningTextController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<CompanyBloc>(context);
    bloc.add(LoadDataEvent());
  }

  @override
  void dispose() {
    /// Close Bloc
    jabatanBloc.close();
    lamaBekerjaBloc.close();
    sumberPendapatanBloc.close();
    pendapatanKotorPerTahunBloc.close();
    namaBankBloc.close();

    /// Dispose Text Controller
    namaPerusahaanTextController.dispose();
    alamatPerusahaanTextController.dispose();
    jabatanTextController.dispose();
    lamaBekerjaTextController.dispose();
    sumberPendapatanTextController.dispose();
    pendapatanKotorPerTahunTextController.dispose();
    namaBankTextController.dispose();
    cabangBankTextController.dispose();
    nomorRekeningTextController.dispose();
    namaPemilikRekeningTextController.dispose();

    super.dispose();
  }

  bool absorbing(AppState state) {
    if (state is AppStateLoading) return true;

    return false;
  }

  void fillingData() {
    namaPerusahaanTextController.text = bloc.companyModel.nama ?? '';
    alamatPerusahaanTextController.text = bloc.companyModel.alamat ?? '';
    lamaBekerjaTextController.text = bloc.companyModel.lamaBekerja ?? '';
    sumberPendapatanTextController.text =
        bloc.companyModel.sumberPendapatan ?? '';
    pendapatanKotorPerTahunTextController.text =
        bloc.companyModel.pendapatanKotorPerTahun ?? '';
    namaBankTextController.text = bloc.companyModel.namaBank ?? '';
    cabangBankTextController.text = bloc.companyModel.cabangBank ?? '';
    nomorRekeningTextController.text = bloc.companyModel.nomorRekening ?? '';
    namaPemilikRekeningTextController.text =
        bloc.companyModel.namaPemilikRekening ?? '';
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer(
      bloc: bloc,
      listener: (_, AppState state) {
        if (state is AppStateSuccess) {
          if (state.successType == SuccessType.submit) {
            if (state.message?.isNotEmpty ?? false) {
              CustomSnackBar.success(state.message!);
            }
            widget.onSuccess();
          }
          if (state.successType == SuccessType.load) {
            fillingData();
          }
        }
      },
      builder: (_, AppState state) {
        bool absorb = absorbing(state);

        return PopScope(
          canPop: state is! AppStateLoading,
          child: AbsorbPointer(
            absorbing: absorb,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  NamaPerusahaanTextField(
                    controller: namaPerusahaanTextController,
                    onChanged: (value) => bloc.add(
                      DataChangedEvent(CompanyModel(
                        nama: value,
                      )),
                    ),
                  ),
                  const SizedBox(height: 15),
                  AlamatPerusahaanTextField(
                    controller: alamatPerusahaanTextController,
                    onChanged: (value) => bloc.add(
                      DataChangedEvent(CompanyModel(
                        alamat: value,
                      )),
                    ),
                  ),
                  const SizedBox(height: 15),
                  BlocProvider.value(
                    value: lamaBekerjaBloc,
                    child: LamaBekerjaSelector(
                      controller: lamaBekerjaTextController,
                      enabled: true,
                      onChanged: (value) => bloc.add(
                        DataChangedEvent(CompanyModel(
                          lamaBekerja: value,
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  BlocProvider.value(
                    value: sumberPendapatanBloc,
                    child: SumberPendapatanSelector(
                      controller: sumberPendapatanTextController,
                      enabled: true,
                      onChanged: (value) => bloc.add(
                        DataChangedEvent(CompanyModel(
                          sumberPendapatan: value,
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  BlocProvider.value(
                    value: pendapatanKotorPerTahunBloc,
                    child: PendapatanKotorPerTahunSelector(
                      controller: pendapatanKotorPerTahunTextController,
                      enabled: true,
                      onChanged: (value) => bloc.add(
                        DataChangedEvent(CompanyModel(
                          pendapatanKotorPerTahun: value,
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  BlocProvider.value(
                    value: namaBankBloc,
                    child: NamaBankSelector(
                      controller: namaBankTextController,
                      enabled: true,
                      onChanged: (value) => bloc.add(
                        DataChangedEvent(CompanyModel(
                          namaBank: value,
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  CabangBankTextField(
                    controller: cabangBankTextController,
                    onChanged: (value) => bloc.add(
                      DataChangedEvent(CompanyModel(
                        cabangBank: value,
                      )),
                    ),
                  ),
                  const SizedBox(height: 15),
                  NomorRekeningTextField(
                    controller: nomorRekeningTextController,
                    onChanged: (value) => bloc.add(
                      DataChangedEvent(CompanyModel(
                        nomorRekening: value,
                      )),
                    ),
                  ),
                  const SizedBox(height: 15),
                  NamaPemilikRekeningTextField(
                    controller: namaPemilikRekeningTextController,
                    onChanged: (value) => bloc.add(
                      DataChangedEvent(CompanyModel(
                        namaPemilikRekening: value,
                      )),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton.text(
                          label: 'Sebelumnya',
                          isSecondaryButton: true,
                          onTap: () {
                            unfocusNode(context);
                            widget.onBack();
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Builder(
                          builder: (_) {
                            return CustomButton.text(
                              label: 'Simpan',
                              onTap: () {
                                unfocusNode(context);
                                bloc.add(SubmitDataEvent());
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
