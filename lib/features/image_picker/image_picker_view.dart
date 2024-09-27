import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payuung_pribadi_clone/commons/colors.dart';
import 'package:payuung_pribadi_clone/components/app_loading.dart';
import 'package:payuung_pribadi_clone/components/app_snackbar.dart';
import 'package:payuung_pribadi_clone/features/image_picker/image_picker_bloc.dart';
import 'package:payuung_pribadi_clone/utils/page_navigator.dart';

class ImagePickerView extends StatefulWidget {
  const ImagePickerView({
    super.key,
    required this.imageSource,
  });

  static const String routeName = 'image_picker';

  /// WARNING MOTE
  /// use [open] to open [ImagePickerView]
  static Future<dynamic> open(
    BuildContext context, {
    required ImageSource imageSource,
  }) async {
    return goToPage(
      nextPage: ImagePickerView(imageSource: imageSource),
      dismissTransitionAnimation: true,
      opaque: false,
      context: context,
      routeName: routeName,
      isRootNavigator: true,
    );
  }

  final ImageSource imageSource;

  @override
  State<ImagePickerView> createState() => _ImagePickerViewState();
}

class _ImagePickerViewState extends State<ImagePickerView>
    with WidgetsBindingObserver {
  late ImagePickerBloc bloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    bloc = ImagePickerBloc(source: widget.imageSource);
    bloc.add(GetImage());
  }

  @override
  void dispose() {
    bloc.close();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log('#ImagePickerView AppLifecycleState: $state');
    log('#ImagePickerView bloc.openSettings: ${bloc.openSettings}');

    if (state == AppLifecycleState.resumed) {
      if (bloc.openSettings) {
        bloc.openSettings = false;
        bloc.add(GetImage());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImagePickerBloc, AppState>(
      bloc: bloc,
      listener: (BuildContext context, AppState state) {
        log('#ImagePickerView bloc state: $state');
        log('#ImagePickerView bloc.openSettings: ${bloc.openSettings}');
        log('#ImagePickerView imageFile: ${bloc.imageFile}');
        log('#ImagePickerView imageFile Path: ${bloc.imageFile?.path}');
        if (state is AppStateSuccess) {
          Navigator.pop(context, bloc.imageFile);
        }

        if (state is AppStateError) {
          if (state.message.isNotEmpty) AppSnackBar.error(state.message);
          Navigator.pop(context);
        }
      },
      builder: (_, AppState state) {
        return PopScope(
          canPop: true,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.black10,
              body: Center(child: AppLoading.withBackground()),
            ),
          ),
        );
      },
    );
  }
}
