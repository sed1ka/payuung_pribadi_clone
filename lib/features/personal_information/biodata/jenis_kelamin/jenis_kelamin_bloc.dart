import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_clone/commons/state.dart';
import 'package:payuung_pribadi_clone/features/personal_information/biodata/jenis_kelamin/jenis_kelamin_event.dart';

export 'package:payuung_pribadi_clone/features/personal_information/biodata/jenis_kelamin/jenis_kelamin_event.dart';

class JenisKelaminBloc extends Bloc<JenisKelaminEvent, AppState> {
  JenisKelaminBloc() : super(const AppStateInitial()) {
    on<OpenSelectorJenisKelamin>(_openSelector);
  }

  bool _triggerStateSwitdh = false;

  void _openSelector(_, emit) {
    _triggerStateSwitdh = !_triggerStateSwitdh;
    emit(AppStateTrigger(_triggerStateSwitdh));
  }
}
