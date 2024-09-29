import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_clone/commons/state.dart';
import 'package:payuung_pribadi_clone/features/personal_information/company/lama_bekerja/lama_bekerja_event.dart';
export 'package:payuung_pribadi_clone/features/personal_information/company/lama_bekerja/lama_bekerja_event.dart';

class LamaBekerjaBloc extends Bloc<LamaBekerjaEvent, AppState> {
  LamaBekerjaBloc() : super(const AppStateInitial()) {
    on<OpenSelectorLamaBekerja>(_openSelector);
  }

  final List<String> items = [
    '< 6 Bulan',
    '6 Bulan - 1 Tahun',
    '1 - 2 Tahun',
    '> 2 Tahun',
  ];

  bool _triggerStateSwitdh = false;

  void _openSelector(_, emit) {
    _triggerStateSwitdh = !_triggerStateSwitdh;
    emit(AppStateTrigger(_triggerStateSwitdh));
  }
}
