
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payuung_pribadi_clone/commons/colors.dart';
import 'package:payuung_pribadi_clone/components/custom_loading.dart';
import 'package:payuung_pribadi_clone/components/custom_snackbar.dart';
import 'package:payuung_pribadi_clone/features/image_picker/image_picker_bloc.dart';
import 'package:payuung_pribadi_clone/utils/page_navigator.dart';

enum ImageFormat {
  file,
  base64,
  base64String,
}

class ImagePickerView extends StatefulWidget {
  const ImagePickerView({
    super.key,
    required this.imageSource,
    this.imageFormat = ImageFormat.file,
  });

  static const String routeName = 'image_picker';

  /// WARNING MOTE
  /// use [open] to open [ImagePickerView]
  static Future<dynamic> open(
    BuildContext context, {
    required ImageSource imageSource,
    ImageFormat imageFormat = ImageFormat.file,
  }) async {
    return goToPage(
      nextPage: ImagePickerView(
        imageSource: imageSource,
        imageFormat: imageFormat,
      ),
      dismissTransitionAnimation: true,
      opaque: false,
      context: context,
      routeName: routeName,
      isRootNavigator: true,
    );
  }

  final ImageSource imageSource;
  final ImageFormat imageFormat;

  @override
  State<ImagePickerView> createState() => _ImagePickerViewState();
}

class _ImagePickerViewState extends State<ImagePickerView> {
  late ImagePickerBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ImagePickerBloc(
      source: widget.imageSource,
      format: widget.imageFormat,
    );
    bloc.add(GetImage());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImagePickerBloc, AppState>(
      bloc: bloc,
      listener: (BuildContext context, AppState state) {
        if (state is AppStateSuccess) {
          Navigator.pop(context, bloc.resource);
        }

        if (state is AppStateError) {
          if (state.message.isNotEmpty) CustomSnackBar.error(state.message);
          Navigator.pop(context);
        }
      },
      builder: (_, AppState state) {
        return PopScope(
          canPop: true,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.black10,
              body: Center(child: CustomLoading.withBackground()),
            ),
          ),
        );
      },
    );
  }
}
