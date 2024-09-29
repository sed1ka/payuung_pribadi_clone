import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_clone/commons/state.dart';
import 'package:payuung_pribadi_clone/features/personal_information/biodata/tanggal_lahir/tanggal_lahir_event.dart';

export 'package:payuung_pribadi_clone/features/personal_information/biodata/tanggal_lahir/tanggal_lahir_event.dart';

class TanggalLahirBloc extends Bloc<TanggalLahirEvent, AppState> {
  TanggalLahirBloc() : super(const AppStateInitial()) {
    on<OpenSelectorTanggalLahir>(_openSelector);
  }

  bool _triggerStateSwitdh = false;

  void _openSelector(_, emit) {
    _triggerStateSwitdh = !_triggerStateSwitdh;
    emit(AppStateTrigger(_triggerStateSwitdh));
  }
}
