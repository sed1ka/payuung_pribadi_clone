import 'package:payuung_pribadi_clone/model/personal_information/biodata_model.dart';

abstract class BiodataEvent {}

class LoadDataEvent extends BiodataEvent {
  LoadDataEvent();
}

class DataChangedEvent extends BiodataEvent {
  final BiodataModel? data;

  DataChangedEvent(this.data);
}

class SubmitDataEvent extends BiodataEvent {
  SubmitDataEvent();
}
