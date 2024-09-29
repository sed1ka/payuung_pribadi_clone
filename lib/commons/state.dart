import 'package:equatable/equatable.dart';

enum SuccessType {
  load,
  submit,
}

enum ErrorType {
  error,
  emptyData,
  invalidSubmit,
  askToResubmit,
  requestTimeOut,
}

abstract class AppState extends Equatable {
  const AppState();
}

class AppStateInitial extends AppState {
  const AppStateInitial();

  @override
  List<Object?> get props => <Object>[];
}

class AppStateLoading extends AppState {
  final double progress;

  const AppStateLoading({this.progress = 0});

  @override
  List<Object?> get props => <Object>[progress];
}

class AppStateSuccess extends AppState {
  final SuccessType successType;
  final String? message;

  const AppStateSuccess({this.successType = SuccessType.load, this.message});

  @override
  List<Object?> get props => <Object>[successType, message ?? ''];
}

class AppStateError extends AppState {
  final String message;
  final String? detailMessage;
  final ErrorType errorType;

  const AppStateError(
    this.message, {
    required this.errorType,
    this.detailMessage,
  });

  @override
  List<Object?> get props => <Object>[message, errorType, detailMessage ?? ''];
}

/// this [AppStateTrigger] is used for triggering new state
/// ..like the setState() function
/// so the value of [doestnMatter] is ignored, but You need to passing different
/// value not same like before for functional work
class AppStateTrigger extends AppState {
  final bool triggerStateSwitch;

  const AppStateTrigger(this.triggerStateSwitch);

  @override
  List<Object?> get props => <Object>[triggerStateSwitch];
}

class AppStateTriggerDouble extends AppState {
  final double value;

  const AppStateTriggerDouble(this.value);

  @override
  List<Object?> get props => <Object>[value];
}
