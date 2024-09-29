import 'package:payuung_pribadi_clone/model/personal_information/company_model.dart';

abstract class CompanyEvent {}

class LoadDataEvent extends CompanyEvent {
  LoadDataEvent();
}

class DataChangedEvent extends CompanyEvent {
  final CompanyModel? data;

  DataChangedEvent(this.data);
}

class SubmitDataEvent extends CompanyEvent {
  SubmitDataEvent();
}
