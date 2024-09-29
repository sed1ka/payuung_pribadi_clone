import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:payuung_pribadi_clone/commons/constants.dart';
import 'package:payuung_pribadi_clone/commons/state.dart';
import 'package:payuung_pribadi_clone/components/data_selector_text_field.dart';
import 'package:payuung_pribadi_clone/features/personal_information/biodata/tanggal_lahir/tanggal_lahir_bloc.dart';

class TanggalLahirSelector extends StatelessWidget {
  const TanggalLahirSelector({
    super.key,
    required this.controller,
    required this.enabled,
    required this.onChanged,
  });

  final TextEditingController controller;
  final bool enabled;
  final ValueChanged<DateTime> onChanged;

  Future<void> selectData(
    BuildContext context,
    TanggalLahirBloc bloc,
  ) async {
    DateTime initialDate =
        DateFormat('dd/MM/yyyy').tryParse(controller.text) ?? DateTime.now();
    final DateTime? res = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (res is DateTime) {
      controller.text = DateFormat('dd/MM/yyyy').format(res);
      onChanged(res);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TanggalLahirBloc bloc = BlocProvider.of(context);

    return BlocConsumer(
      bloc: bloc,
      listener: (_, AppState state) {
        if (state is AppStateTrigger) selectData(context, bloc);
      },
      builder: (_, __) => DataSelectorTextField(
        enabled: enabled,
        controller: controller,
        errorFontSize: bodySmallTextSize,
        title: 'Tanggal Lahir',
        suffixIcon: const Icon(
          Icons.calendar_today,
          size: mediumIconSize + 4,
        ),
        onTap: () => bloc.add(OpenSelectorTanggalLahir()),
      ),
    );
  }
}
