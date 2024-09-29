import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_clone/commons/state.dart';
import 'package:payuung_pribadi_clone/features/personal_information/company/pendapatan_kotor_per_tahun/pendapatan_kotor_per_tahun_event.dart';
export 'package:payuung_pribadi_clone/features/personal_information/company/pendapatan_kotor_per_tahun/pendapatan_kotor_per_tahun_event.dart';

class PendapatanKotorPerTahunBloc extends Bloc<PendapatanKotorPerTahunEvent, AppState> {
  PendapatanKotorPerTahunBloc() : super(const AppStateInitial()) {
    on<OpenSelectorPendapatanKotorPerTahun>(_openSelector);
  }

  final List<String> items = [
    '< 10 Juta',
    '10 - 50 Juta',
    '50 - 100 Juta',
    '100 - 500 Juta',
    '500 Juta - 1 Milyar',
    '> 1 Milyar',
  ];

  bool _triggerStateSwitdh = false;

  void _openSelector(_, emit) {
    _triggerStateSwitdh = !_triggerStateSwitdh;
    emit(AppStateTrigger(_triggerStateSwitdh));
  }
}
