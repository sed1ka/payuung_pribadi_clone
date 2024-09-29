import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_clone/commons/constants.dart';
import 'package:payuung_pribadi_clone/commons/state.dart';
import 'package:payuung_pribadi_clone/components/custom_snackbar.dart';
import 'package:payuung_pribadi_clone/components/data_selector_text_field.dart';

import 'package:payuung_pribadi_clone/features/personal_information/company/lama_bekerja/lama_bekerja_bloc.dart';
import 'package:payuung_pribadi_clone/features/personal_information/company/lama_bekerja/lama_bekerja_bottomsheet.dart';
import 'package:payuung_pribadi_clone/utils/formatter.dart';
import 'package:payuung_pribadi_clone/utils/page_navigator.dart';


class LamaBekerjaSelector extends StatelessWidget {
  const LamaBekerjaSelector({
    super.key,
    required this.controller,
    required this.enabled,
    required this.onChanged,
  });

  final TextEditingController controller;
  final bool enabled;
  final ValueChanged<String> onChanged;

  Future<void> selectData(
    BuildContext context,
      LamaBekerjaBloc bloc,
  ) async {
    final dynamic res = await showKreduitModalBottom(
      context: context,
      maxHeight: modalBottomHeight * 0.8,
      minHeight: modalBottomHeight * 0.25,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: bloc,
        child: const LamaBekerjaBottomSheet(),
      ),
    );

    if (res is String) {
      if ((res.isEmpty)) {
        CustomSnackBar.error('Data Error');
      } else {
        controller.text = res.toTitleCase();
        onChanged(res);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final LamaBekerjaBloc bloc = BlocProvider.of(context);

    return BlocConsumer(
      bloc: bloc,
      listener: (_, AppState state) {
        if (state is AppStateTrigger) selectData(context, bloc);
      },
      builder: (_, __) => DataSelectorTextField(
        enabled: enabled,
        controller: controller,
        errorFontSize: bodySmallTextSize,
        title: 'Lama Bekerja',
        onTap: () => bloc.add(OpenSelectorLamaBekerja()),
      ),
    );
  }
}
