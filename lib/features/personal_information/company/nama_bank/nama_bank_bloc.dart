import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_clone/commons/state.dart';
import 'package:payuung_pribadi_clone/features/personal_information/company/nama_bank/nama_bank_event.dart';
export 'package:payuung_pribadi_clone/features/personal_information/company/nama_bank/nama_bank_event.dart';

class NamaBankBloc extends Bloc<NamaBankEvent, AppState> {
  NamaBankBloc() : super(const AppStateInitial()) {
    on<OpenSelectorNamaBank>(_openSelector);
  }

  final List<String> items = [
    'Bank Syariah Indonesia',
    'Bank DKI',
    'Bank CIMB Niaga',
    'Bank Eksekutif',
    'Bank Panin',
    'Seabank',
    'Bank Mandiri',
    'Bank Central Asia',
    'Bank Lippo',
    'Bank Mayapada',
    'Permata Bank',
    'Bank Mega',
    'Bank Bukopin',
    'Bank Akita',
    'Bank BCA Syariah',
    'Bank BNI',
    'Bank BJB',
    'Bank Bumi Arta',
    'Bank Danamon',
    'Bank Jago',
    'Bank JATENG',
    'Bank JATIM',
    'Bank JASA ARTA',
    'Bank JASA JAKARTA',
    'Bank Maluku',
    'Bank Sinarmas',
    'Bank Mayora',
    'CITIBANK',
  ];

  bool _triggerStateSwitdh = false;

  void _openSelector(_, emit) {
    _triggerStateSwitdh = !_triggerStateSwitdh;
    emit(AppStateTrigger(_triggerStateSwitdh));
  }
}
