import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_clone/commons/state.dart';
import 'package:payuung_pribadi_clone/features/personal_information/company/sumber_pendapatan/sumber_pendapatan_event.dart';

export 'package:payuung_pribadi_clone/features/personal_information/company/sumber_pendapatan/sumber_pendapatan_event.dart';

class SumberPendapatanBloc extends Bloc<SumberPendapatanEvent, AppState> {
  SumberPendapatanBloc() : super(const AppStateInitial()) {
    on<OpenSelectorSumberPendapatan>(_openSelector);
  }

  final List<String> items = [
    'SD',
    'SMP',
    'SMA',
    'D1',
    'D2',
    'D3',
    'S1/D4',
    'S2',
    'S3',
  ];

  bool _triggerStateSwitdh = false;

  void _openSelector(_, emit) {
    _triggerStateSwitdh = !_triggerStateSwitdh;
    emit(AppStateTrigger(_triggerStateSwitdh));
  }
}
