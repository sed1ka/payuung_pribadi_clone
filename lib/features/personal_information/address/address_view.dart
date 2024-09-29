
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_clone/components/custom_button.dart';
import 'package:payuung_pribadi_clone/components/custom_card.dart';
import 'package:payuung_pribadi_clone/components/custom_snackbar.dart';
import 'package:payuung_pribadi_clone/components/custom_toast.dart';
import 'package:payuung_pribadi_clone/features/personal_information/address/address_bloc.dart';
import 'package:payuung_pribadi_clone/features/personal_information/address/alamat/alamat_textfield.dart';
import 'package:payuung_pribadi_clone/features/personal_information/address/kecamatan/kecamatan_bloc.dart';
import 'package:payuung_pribadi_clone/features/personal_information/address/kecamatan/kecamatan_selector.dart';
import 'package:payuung_pribadi_clone/features/personal_information/address/kelurahan/kelurahan_bloc.dart';
import 'package:payuung_pribadi_clone/features/personal_information/address/kelurahan/kelurahan_selector.dart';
import 'package:payuung_pribadi_clone/features/personal_information/address/kode_pos/kode_pos_textfield.dart';
import 'package:payuung_pribadi_clone/features/personal_information/address/kota_kabupaten/kota_bloc.dart';
import 'package:payuung_pribadi_clone/features/personal_information/address/kota_kabupaten/kota_selector.dart';
import 'package:payuung_pribadi_clone/features/personal_information/address/ktp/ktp_file_selector.dart';
import 'package:payuung_pribadi_clone/features/personal_information/address/nik/nik_textfield.dart';
import 'package:payuung_pribadi_clone/features/personal_information/address/provinsi/provinsi_bloc.dart';
import 'package:payuung_pribadi_clone/features/personal_information/address/provinsi/provinsi_selector.dart';
import 'package:payuung_pribadi_clone/model/personal_information/address_model.dart';
import 'package:payuung_pribadi_clone/model/personal_information/personal_address_model.dart';
import 'package:payuung_pribadi_clone/utils/unfocus_node.dart';

class AddressView extends StatefulWidget {
  const AddressView({
    super.key,
    required this.onSuccess,
    required this.onBack,
  });

  final Function() onSuccess;
  final Function() onBack;

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView>
    with AutomaticKeepAliveClientMixin<AddressView> {
  late final AddressBloc bloc;

  final ValueNotifier<String> fileNotifier = ValueNotifier('');
  final ProvinsiBloc provinsiBloc = ProvinsiBloc();
  final KotaBloc kotaBloc = KotaBloc();
  final KecamatanBloc kecamatanBloc = KecamatanBloc();
  final KelurahanBloc kelurahanBloc = KelurahanBloc();

  final TextEditingController nikTextController = TextEditingController();
  final TextEditingController alamatTextController = TextEditingController();
  final TextEditingController provinsiTextController = TextEditingController();
  final TextEditingController kotaTextController = TextEditingController();
  final TextEditingController kecamatanTextController = TextEditingController();
  final TextEditingController kelurahanTextController = TextEditingController();
  final TextEditingController kodePosTextController = TextEditingController();

  final FocusNode nikFocusNode = FocusNode(debugLabel: 'NIK KTP');
  final FocusNode alamatFocusNode = FocusNode(debugLabel: 'Alamat KTP');
  final FocusNode kodePosFocusNode = FocusNode(debugLabel: 'Kode Pos');

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<AddressBloc>(context);
    bloc.add(LoadDataEvent());
  }

  @override
  void dispose() {
    /// Close Bloc
    fileNotifier.dispose();
    provinsiBloc.close();
    kotaBloc.close();
    kecamatanBloc.close();
    kelurahanBloc.close();

    /// Dispose Text Controller
    nikTextController.dispose();
    alamatTextController.dispose();
    provinsiTextController.dispose();
    kotaTextController.dispose();
    kecamatanTextController.dispose();
    kelurahanTextController.dispose();
    kodePosTextController.dispose();

    super.dispose();
  }

  bool absorbing(AppState state) {
    if (state is AppStateLoading) return true;

    return false;
  }

  void fillingSugestionsCheckerHandler() {
    if (!bloc.isKtpValid) {
      return;
    }

    if (!bloc.isNIKValid) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => nikFocusNode.requestFocus(),
      );
      return;
    }

    if (!bloc.isAlamatValid) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => alamatFocusNode.requestFocus(),
      );
      return;
    }

    if (!bloc.isProvinsiValid) {
      provinsiBloc.add(OpenSelectorProvinsi());
      return;
    }

    if (!bloc.isKotaValid) {
      kotaBloc.add(OpenSelectorKota());
      return;
    }
    if (!bloc.isKecamatanValid) {
      kecamatanBloc.add(OpenSelectorKecamatan());
      return;
    }

    if (!bloc.isKelurahanValid) {
      kelurahanBloc.add(OpenSelectorKelurahan());
      return;
    }

    if (!bloc.isKodePosValid) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => kodePosFocusNode.requestFocus(),
      );
      return;
    }
  }

  void fillingData() {
    fileNotifier.value = bloc.data.ktpFile?.source ?? '';
    nikTextController.text = bloc.data.nik ?? '';
    alamatTextController.text = bloc.data.alamatKtp?.alamat ?? '';
    provinsiTextController.text = bloc.data.alamatKtp?.provinsi ?? '';
    kotaTextController.text = bloc.data.alamatKtp?.kota ?? '';
    kecamatanTextController.text = bloc.data.alamatKtp?.kecamatan ?? '';
    kelurahanTextController.text = bloc.data.alamatKtp?.kelurahan ?? '';
    kodePosTextController.text = bloc.data.alamatKtp?.kodepos ?? '';
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
                  CustomCard(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child: Column(
                      children: [
                        KtpFileSelector(
                          fileNotifier: fileNotifier,
                          onFile: (base64Model) => bloc.add(DataChangedEvent(
                            PersonalAddressModel(
                              ktpFile: base64Model,
                            ),
                          )),
                        ),
                        const SizedBox(height: 10),
                        NikTextField(
                          controller: nikTextController,
                          focusNode: nikFocusNode,
                          onChanged: (value) => bloc.add(DataChangedEvent(
                            PersonalAddressModel(nik: value),
                          )),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  AlamatTextField(
                    labelText: 'Alamat KTP',
                    controller: alamatTextController,
                    focusNode: alamatFocusNode,
                    enabled: true,
                    onChanged: (value) => bloc.add(
                      DataChangedEvent(
                        PersonalAddressModel(
                          alamatKtp: AddressModel(
                            alamat: value,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  BlocProvider.value(
                    value: provinsiBloc,
                    child: ProvinsiSelector(
                      controller: provinsiTextController,
                      enabled: true,
                      onChanged: (value) => bloc.add(
                        DataChangedEvent(
                          PersonalAddressModel(
                            alamatKtp: AddressModel(
                              provinsi: value,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  BlocProvider.value(
                    value: kotaBloc,
                    child: KotaSelector(
                      controller: kotaTextController,
                      enabled: bloc.isProvinsiValid,
                      onChanged: (value) => bloc.add(
                        DataChangedEvent(
                          PersonalAddressModel(
                            alamatKtp: AddressModel(
                              kota: value,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  BlocProvider.value(
                    value: kecamatanBloc,
                    child: KecamatanSelector(
                      controller: kecamatanTextController,
                      enabled: bloc.isKotaValid,
                      onChanged: (value) => bloc.add(
                        DataChangedEvent(
                          PersonalAddressModel(
                            alamatKtp: AddressModel(
                              kecamatan: value,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  BlocProvider.value(
                    value: kelurahanBloc,
                    child: KelurahanSelector(
                      controller: kelurahanTextController,
                      enabled: bloc.isKecamatanValid,
                      onChanged: (value) => bloc.add(
                        DataChangedEvent(
                          PersonalAddressModel(
                            alamatKtp: AddressModel(
                              kelurahan: value,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  KodePosTextField(
                    controller: kodePosTextController,
                    focusNode: kodePosFocusNode,
                    onChanged: (value) => bloc.add(DataChangedEvent(
                      PersonalAddressModel(
                        alamatKtp: AddressModel(
                          kodepos: value,
                        ),
                      ),
                    )),
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
                              label: 'Selanjutnya',
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
