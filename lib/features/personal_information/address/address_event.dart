import 'package:payuung_pribadi_clone/model/personal_information/personal_address_model.dart';

abstract class AddressEvent {}

class LoadDataEvent extends AddressEvent {
  LoadDataEvent();
}

class DataChangedEvent extends AddressEvent {
  final PersonalAddressModel? data;

  DataChangedEvent(this.data);
}

class SubmitDataEvent extends AddressEvent {
  SubmitDataEvent();
}
