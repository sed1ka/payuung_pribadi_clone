import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_clone/commons/state.dart';
import 'package:payuung_pribadi_clone/features/personal_information/address/provinsi/provinsi_event.dart';

export 'package:payuung_pribadi_clone/commons/state.dart';
export 'package:payuung_pribadi_clone/features/personal_information/address/provinsi/provinsi_event.dart';

class ProvinsiBloc extends Bloc<ProvinsiEvent, AppState> {
  ProvinsiBloc() : super(const AppStateInitial()) {
    on<OpenSelectorProvinsi>(_openSelector);
  }

  final List<String> items = [
    'Banten',
    'Jawa Tengah',
    'Jawa Barat',
    'Kalimantan',
  ];

  bool _triggerStateSwitdh = false;

  void _openSelector(_, emit) {
    _triggerStateSwitdh = !_triggerStateSwitdh;
    emit(AppStateTrigger(_triggerStateSwitdh));
  }
}
