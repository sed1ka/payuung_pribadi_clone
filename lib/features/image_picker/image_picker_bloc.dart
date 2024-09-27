import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payuung_pribadi_clone/commons/state.dart';
import 'package:payuung_pribadi_clone/features/image_picker/image_picker_event.dart';

export 'package:payuung_pribadi_clone/commons/state.dart';
export 'package:payuung_pribadi_clone/features/image_picker/image_picker_event.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, AppState> {
  ImagePickerBloc({
    required this.source,
  }) : super(const AppStateInitial()) {
    on<GetImage>(_getImage);
  }

  final ImageSource source;

  File? imageFile;
  bool cameraAvailable = false;
  bool openSettings = false;

  Future<void> _getImage(
    GetImage event,
    Emitter<AppState> emit,
  ) async {
    emit(const AppStateLoading());

    XFile? image = await ImagePicker().pickImage(
      source: source,
      maxWidth: 2400,
      maxHeight: 2400,
    );

    if (image == null) {
      emit(const AppStateError(
        'Fail to get the image',
        errorType: ErrorType.error,
      ));
      return;
    }


    emit(const AppStateLoading());
    imageFile = File(image.path);
    log('#ImagePickerBloc imageFile :$imageFile');
    log('#ImagePickerBloc imageFile.path :${imageFile?.path}');
    emit(const AppStateSuccess());
  }
}
