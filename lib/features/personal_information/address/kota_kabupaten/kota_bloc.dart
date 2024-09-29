import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_clone/commons/state.dart';
import 'package:payuung_pribadi_clone/features/personal_information/address/kota_kabupaten/kota_event.dart';

export 'package:payuung_pribadi_clone/commons/state.dart';
export 'package:payuung_pribadi_clone/features/personal_information/address/kota_kabupaten/kota_event.dart';

class KotaBloc extends Bloc<KotaEvent, AppState> {
  KotaBloc() : super(const AppStateInitial()) {
    on<OpenSelectorKota>(_openSelector);
  }

  final List<String> items = [
    'Tangerang',
    'Kabupaten Tangerang',
    'Serang',
    'Pandeglang',
    'Kabupaten Pandeglang',
  ];

  bool _triggerStateSwitdh = false;

  void _openSelector(_, emit) {
    _triggerStateSwitdh = !_triggerStateSwitdh;
    emit(AppStateTrigger(_triggerStateSwitdh));
  }
}
