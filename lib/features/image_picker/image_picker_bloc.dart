import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payuung_pribadi_clone/commons/state.dart';
import 'package:payuung_pribadi_clone/features/image_picker/image_picker_event.dart';
import 'package:payuung_pribadi_clone/features/image_picker/image_picker_view.dart';
import 'package:payuung_pribadi_clone/utils/assets_helper.dart';

export 'package:payuung_pribadi_clone/commons/state.dart';
export 'package:payuung_pribadi_clone/features/image_picker/image_picker_event.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, AppState> {
  ImagePickerBloc({
    required this.source,
    required this.format,
  }) : super(const AppStateInitial()) {
    on<GetImage>(_getImage);
  }

  final ImageSource source;
  final ImageFormat format;

  dynamic resource;

  Future<void> _getImage(
    GetImage event,
    Emitter<AppState> emit,
  ) async {
    emit(const AppStateLoading());

    try {
      XFile? image = await ImagePicker().pickImage(
        source: source,
        maxWidth: 2400,
        maxHeight: 2400,
      );
      if (image == null) {
        emit(const AppStateSuccess());
        return;
      }

      emit(const AppStateLoading());

      log('#ImagePickerBloc image.path: ${image.path}');
      File? file = File(image.path);
      file = await AssetsHelper.compressImageFile(file);

      if (file == null) {
        emit(const AppStateSuccess());
        return;
      }

      if (format != ImageFormat.file) {
        List<int> imageBytes = await file.readAsBytes();

        log('#ImagePickerBloc imageBytes: $imageBytes');
        if (format == ImageFormat.base64) {
          resource = imageBytes;
        } else if (format == ImageFormat.base64String) {
          String base64Image = base64.encode(imageBytes);
          log('#ImagePickerBloc base64Image: $base64Image');
          resource = base64Image;
        }
      } else {
        resource = file;
      }

      log('#ImagePickerBloc resource: $resource');
      log('#ImagePickerBloc resource.type: ${resource.runtimeType}');
      emit(const AppStateSuccess());
    } catch (e) {

      log('#ImagePickerBloc error: $e');
      emit(const AppStateError(
        'Fail to get the image',
        errorType: ErrorType.error,
      ));
      return;
    }
  }
}
