import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_clone/commons/state.dart';
import 'package:payuung_pribadi_clone/features/personal_information/biodata/pendidikan/pendidikan_event.dart';

export 'package:payuung_pribadi_clone/features/personal_information/biodata/pendidikan/pendidikan_event.dart';

class PendidikanBloc extends Bloc<PendidikanEvent, AppState> {
  PendidikanBloc() : super(const AppStateInitial()) {
    on<OpenSelectorPendidikan>(_openSelector);
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
