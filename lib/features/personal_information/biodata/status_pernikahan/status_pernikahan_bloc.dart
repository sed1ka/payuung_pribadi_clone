import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_clone/commons/state.dart';
import 'package:payuung_pribadi_clone/features/personal_information/biodata/status_pernikahan/status_pernikahan_event.dart';

export 'package:payuung_pribadi_clone/features/personal_information/biodata/status_pernikahan/status_pernikahan_event.dart';

class StatusPernikahanBloc extends Bloc<StatusPernikahanEvent, AppState> {
  StatusPernikahanBloc() : super(const AppStateInitial()) {
    on<OpenSelectorStatusPernikahan>(_openSelector);
  }

  final List<String> items = [
    'Belum kawin',
    'Kawin',
    'Janda',
    'Duda',
  ];

  bool _triggerStateSwitdh = false;

  void _openSelector(_, emit) {
    _triggerStateSwitdh = !_triggerStateSwitdh;
    emit(AppStateTrigger(_triggerStateSwitdh));
  }
}
