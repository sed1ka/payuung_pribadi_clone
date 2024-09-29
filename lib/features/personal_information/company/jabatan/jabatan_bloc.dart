import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_clone/commons/state.dart';
import 'package:payuung_pribadi_clone/features/personal_information/company/jabatan/jabatan_event.dart';

export 'package:payuung_pribadi_clone/features/personal_information/company/jabatan/jabatan_event.dart';

class JabatanBloc extends Bloc<JabatanEvent, AppState> {
  JabatanBloc() : super(const AppStateInitial()) {
    on<OpenSelectorJabatan>(_openSelector);
  }

  final List<String> items = [
    'Non Staff',
    'Staff',
    'Supervisor',
    'Manajer',
    'Direktur',
    'Lainnya',
  ];

  bool _triggerStateSwitdh = false;

  void _openSelector(_, emit) {
    _triggerStateSwitdh = !_triggerStateSwitdh;
    emit(AppStateTrigger(_triggerStateSwitdh));
  }
}
