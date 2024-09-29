import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_clone/commons/state.dart';
import 'package:payuung_pribadi_clone/features/personal_information/address/kelurahan/kelurahan_event.dart';

export 'package:payuung_pribadi_clone/commons/state.dart';
export 'package:payuung_pribadi_clone/features/personal_information/address/kelurahan/kelurahan_event.dart';


class KelurahanBloc extends Bloc<KelurahanEvent, AppState> {
  KelurahanBloc() : super(const AppStateInitial()) {
    on<OpenSelectorKelurahan>(_openSelector);
  }

  final List<String> items = [
    'Panti',
    'Suka Asih',
    'Pasir Jaya',
    'Pasir Gadung',
    'Panongan',
  ];

  bool _triggerStateSwitdh = false;

  void _openSelector(_, emit) {
    _triggerStateSwitdh = !_triggerStateSwitdh;
    emit(AppStateTrigger(_triggerStateSwitdh));
  }
}
