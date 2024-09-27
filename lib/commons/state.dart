import 'package:equatable/equatable.dart';

enum ErrorType {
  noError,
  error,
  requestTimeOut,
  unAuth,
  unstableInternet, // Unstable Internet Connection
  noInternet, // Device not connected to Internet
  cameraDenied,
  cameraDeniedForever,
  mediaAndFileDenied,
  mediaAndFileDeniedForever,
  ktpNotDetected,
  kycBlacklisted,
  kycFail,
  limited,
  invalidSubmit,
  locationServiceDisable,
  locationPermissionDenied,
  locationPermissionDeniedForefer,
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
  const AppStateSuccess();

  @override
  List<Object?> get props => <Object>[];
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
  final bool doesntMatter;

  const AppStateTrigger(this.doesntMatter);

  @override
  List<Object?> get props => <Object>[doesntMatter];
}

class AppStateTriggerDouble extends AppState {
  final double value;

  const AppStateTriggerDouble(this.value);

  @override
  List<Object?> get props => <Object>[value];
}
