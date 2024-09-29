import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_clone/components/custom_button.dart';
import 'package:payuung_pribadi_clone/components/custom_snackbar.dart';
import 'package:payuung_pribadi_clone/components/custom_toast.dart';
import 'package:payuung_pribadi_clone/features/personal_information/biodata/alamat_email/alamat_email_textfield.dart';
import 'package:payuung_pribadi_clone/features/personal_information/biodata/biodata_bloc.dart';
import 'package:payuung_pribadi_clone/features/personal_information/biodata/jenis_kelamin/jenis_kelamin_bloc.dart';
import 'package:payuung_pribadi_clone/features/personal_information/biodata/jenis_kelamin/jenis_kelamin_selector.dart';
import 'package:payuung_pribadi_clone/features/personal_information/biodata/nama_lengkap/nama_lengkap_textfield.dart';
import 'package:payuung_pribadi_clone/features/personal_information/biodata/nomor_hp/nomor_hp_textfield.dart';
import 'package:payuung_pribadi_clone/features/personal_information/biodata/pendidikan/pendidikan_bloc.dart';
import 'package:payuung_pribadi_clone/features/personal_information/biodata/pendidikan/pendidikan_selector.dart';
import 'package:payuung_pribadi_clone/features/personal_information/biodata/status_pernikahan/status_pernikahan_bloc.dart';
import 'package:payuung_pribadi_clone/features/personal_information/biodata/status_pernikahan/status_pernikahan_selector.dart';
import 'package:payuung_pribadi_clone/features/personal_information/biodata/tanggal_lahir/tanggal_lahir_bloc.dart';
import 'package:payuung_pribadi_clone/features/personal_information/biodata/tanggal_lahir/tanggal_lahir_selector.dart';
import 'package:payuung_pribadi_clone/model/personal_information/biodata_model.dart';
import 'package:payuung_pribadi_clone/utils/formatter.dart';
import 'package:payuung_pribadi_clone/utils/unfocus_node.dart';

class BiodataView extends StatefulWidget {
  const BiodataView({
    super.key,
    required this.onSuccess,
  });

  final Function() onSuccess;

  @override
  State<BiodataView> createState() => _BiodataViewState();
}

class _BiodataViewState extends State<BiodataView>
    with AutomaticKeepAliveClientMixin<BiodataView> {
  late final BiodataBloc bloc;

  final TanggalLahirBloc tanggalLahirBloc = TanggalLahirBloc();
  final JenisKelaminBloc jenisKelaminBloc = JenisKelaminBloc();
  final PendidikanBloc pendidikanBloc = PendidikanBloc();
  final StatusPernikahanBloc statusPernikahanBloc = StatusPernikahanBloc();

  final TextEditingController namaLengkapTextController =
      TextEditingController();
  final TextEditingController tanggalLahirTextController =
      TextEditingController();
  final TextEditingController jenisKelaminTextController =
      TextEditingController();
  final TextEditingController alamatEmailTextController =
      TextEditingController();
  final TextEditingController nomorHpTextController = TextEditingController();
  final TextEditingController pendidikanTextController =
      TextEditingController();
  final TextEditingController statusPernikahanTextController =
      TextEditingController();

  final FocusNode namaLengkapFocusNode = FocusNode(debugLabel: 'Nama Lengkap');
  final FocusNode alamatEmailFocusNode = FocusNode(debugLabel: 'Alamat Email');
  final FocusNode noHpFocusNode = FocusNode(debugLabel: 'Nomor Hp');

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<BiodataBloc>(context);
    bloc.add(LoadDataEvent());
  }

  @override
  void dispose() {
    /// Close Bloc
    tanggalLahirBloc.close();
    jenisKelaminBloc.close();
    pendidikanBloc.close();
    statusPernikahanBloc.close();

    /// Dispose Text Controller
    namaLengkapTextController.dispose();
    tanggalLahirTextController.dispose();
    jenisKelaminTextController.dispose();
    alamatEmailTextController.dispose();
    nomorHpTextController.dispose();
    pendidikanTextController.dispose();
    statusPernikahanTextController.dispose();

    super.dispose();
  }

  void fillingSugestionsCheckerHandler() {
    if (!bloc.isNamaLengkapValid) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => namaLengkapFocusNode.requestFocus(),
      );
      return;
    }

    if (!bloc.isTanggalLahirValid) {
      tanggalLahirBloc.add(OpenSelectorTanggalLahir());
      return;
    }

    if (!bloc.isJenisKelaminValid) {
      jenisKelaminBloc.add(OpenSelectorJenisKelamin());
      return;
    }

    if (!bloc.isAlamatEmailValid) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => alamatEmailFocusNode.requestFocus(),
      );
      return;
    }

    if (!bloc.isNoHpValid) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => noHpFocusNode.requestFocus(),
      );
      return;
    }
  }

  bool absorbing(AppState state) {
    if (state is AppStateLoading) return true;
    if (state is AppStateError) {
      if (state.errorType == ErrorType.invalidSubmit) return true;
    }
    return false;
  }

  void fillingData() {
    namaLengkapTextController.text = bloc.biodataModel.namaLengkap ?? '';
    tanggalLahirTextController.text = bloc.biodataModel.tanggalLahir
            ?.toDateFromEpoch(dateTimeFormat: 'dd/MM/yyyy') ??
        '';
    jenisKelaminTextController.text = bloc.biodataModel.jenisKelamin ?? '';
    alamatEmailTextController.text = bloc.biodataModel.alamatEmail ?? '';
    nomorHpTextController.text = bloc.biodataModel.noHp ?? '';
    pendidikanTextController.text = bloc.biodataModel.pendidikan ?? '';
    statusPernikahanTextController.text =
        bloc.biodataModel.statusPernikahan ?? '';
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

        if (state is AppStateError) {
          if (state.errorType == ErrorType.invalidSubmit) {
            CustomToast.show(
              state.message,
              duration: bloc.validationWarningDuration,
            );
          }
          if (state.errorType == ErrorType.askToResubmit) {
            fillingSugestionsCheckerHandler();
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
                  NamaLengkapTextField(
                    controller: namaLengkapTextController,
                    focusNode: namaLengkapFocusNode,
                    onChanged: (value) => bloc.add(
                      DataChangedEvent(BiodataModel(
                        namaLengkap: value,
                      )),
                    ),
                  ),
                  const SizedBox(height: 15),
                  BlocProvider.value(
                    value: tanggalLahirBloc,
                    child: TanggalLahirSelector(
                      controller: tanggalLahirTextController,
                      enabled: true,
                      onChanged: (value) => bloc.add(
                        DataChangedEvent(BiodataModel(
                          tanggalLahir: value.millisecondsSinceEpoch,
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  BlocProvider.value(
                    value: jenisKelaminBloc,
                    child: JenisKelaminSelector(
                      controller: jenisKelaminTextController,
                      enabled: true,
                      onChanged: (value) => bloc.add(
                        DataChangedEvent(BiodataModel(
                          jenisKelamin: value,
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  AlamatEmailTextField(
                    controller: alamatEmailTextController,
                    focusNode: alamatEmailFocusNode,
                    onChanged: (value) => bloc.add(
                      DataChangedEvent(BiodataModel(
                        alamatEmail: value,
                      )),
                    ),
                  ),
                  const SizedBox(height: 15),
                  NomorHpTextField(
                    controller: nomorHpTextController,
                    focusNode: noHpFocusNode,
                    onChanged: (value) => bloc.add(
                      DataChangedEvent(BiodataModel(
                        noHp: value,
                      )),
                    ),
                  ),
                  const SizedBox(height: 15),
                  BlocProvider.value(
                    value: pendidikanBloc,
                    child: PendidikanSelector(
                      controller: pendidikanTextController,
                      enabled: true,
                      onChanged: (value) => bloc.add(
                        DataChangedEvent(BiodataModel(
                          pendidikan: value,
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  BlocProvider.value(
                    value: statusPernikahanBloc,
                    child: StatusPernikahanSelector(
                      controller: statusPernikahanTextController,
                      enabled: true,
                      onChanged: (value) => bloc.add(
                        DataChangedEvent(BiodataModel(
                          statusPernikahan: value,
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Builder(
                    builder: (_) {
                      return CustomButton.text(
                        label: 'Selanjutnya',
                        onTap: () {
                          unfocusNode(context);
                          bloc.add(SubmitDataEvent());
                        },
                      );
                    },
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
