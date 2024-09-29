import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_clone/commons/state.dart';
import 'package:payuung_pribadi_clone/features/personal_information/address/kecamatan/kecamatan_event.dart';

export 'package:payuung_pribadi_clone/commons/state.dart';
export 'package:payuung_pribadi_clone/features/personal_information/address/kecamatan/kecamatan_event.dart';

class KecamatanBloc extends Bloc<KecamatanEvent, AppState> {
  KecamatanBloc() : super(const AppStateInitial()) {
    on<OpenSelectorKecamatan>(_openSelector);
  }

  final List<String> items = [
    'Pasar Kemis',
    'Pasar Minggu',
    'Slipi',
    'Mampang',
  ];

  bool _triggerStateSwitdh = false;

  void _openSelector(_, emit) {
    _triggerStateSwitdh = !_triggerStateSwitdh;
    emit(AppStateTrigger(_triggerStateSwitdh));
  }
}
