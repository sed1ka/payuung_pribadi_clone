import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payuung_pribadi_clone/commons/colors.dart';
import 'package:payuung_pribadi_clone/commons/constants.dart';
import 'package:payuung_pribadi_clone/components/bottomsheet_appbar.dart';
import 'package:payuung_pribadi_clone/components/custom_inkwell.dart';
import 'package:payuung_pribadi_clone/components/custom_list_tile.dart';
import 'package:payuung_pribadi_clone/components/custom_text.dart';
import 'package:payuung_pribadi_clone/features/image_picker/image_picker_view.dart';
import 'package:payuung_pribadi_clone/model/base64_model.dart';
import 'package:payuung_pribadi_clone/utils/page_navigator.dart';

class KtpFileSelector extends StatelessWidget {
  const KtpFileSelector({
    super.key,
    required this.fileNotifier,
    required this.onFile,
  });

  final ValueNotifier<String> fileNotifier;
  final Function(Base64Model) onFile;

  Future<void> openBottomSheet(BuildContext context) async {
    final dynamic res = await showKreduitModalBottom(
      context: context,
      builder: (_) {
        return const _BottomSheet();
      },
    );
    log('Res: $res');
    log('Res: ${res.runtimeType}');

    if (res is String) {
      if (res.isNotEmpty) {
        onFile(
          Base64Model(
            name: 'ktp-base64-${DateTime.now().millisecondsSinceEpoch}',
            source: res,
          ),
        );
        fileNotifier.value = res;
        return;
      }
    }
    fileNotifier.value = '';
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: fileNotifier,
      builder: (_, val, __) {
        final Widget? trailing = val.isNotEmpty
            ? const Icon(
                Icons.check_circle_rounded,
                color: AppColors.green,
                size: smallIconSize,
              )
            : null;

        final String title = val.isNotEmpty ? 'KTP' : '+ Pilih KTP';
        return CustomListTile(
          color: AppColors.primary15,
          leading: const Icon(
            Icons.image,
            color: AppColors.primary,
          ),
          useDefaultTrail: false,
          title: title,
          trailing: trailing,
          onTap: val.isEmpty ? () => openBottomSheet(context) : null,
        );
      },
    );
  }
}

class _BottomSheet extends StatelessWidget {
  const _BottomSheet();

  Future<void> openImagePicker(
    BuildContext context, {
    required ImageSource source,
  }) async {
    final dynamic res = await ImagePickerView.open(
      context,
      imageSource: source,
      imageFormat: ImageFormat.base64String,
    );

    if(context.mounted) Navigator.pop(context, res);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const BottomSheetAppBar(),
        Builder(
          builder: (context) {
            return _AndroidLayout(
              onCameraTap: () => openImagePicker(
                context,
                source: ImageSource.camera,
              ),
              onGalleryTap: () => openImagePicker(
                context,
                source: ImageSource.gallery,
              ),
            );
          },
        ),
      ],
    );
  }
}

class _AndroidLayout extends StatelessWidget {
  const _AndroidLayout({
    this.onCameraTap,
    this.onGalleryTap,
  });

  final VoidCallback? onCameraTap;
  final VoidCallback? onGalleryTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
          child: CustomText.title(
            'Ambil Gambar melalui',
            textAlign: TextAlign.start,
          ),
        ),
        Flexible(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(15, 5, 25, 15),
            child: Row(
              children: <Widget>[
                customIcon(
                  icon: const Icon(
                    Icons.camera,
                    size: largeIconSize,
                    color: AppColors.primary,
                  ),
                  tooltipMessage: 'Ambil melalui kamera',
                  label: 'Kamera',
                  onTap: onCameraTap,
                ),

                /// Read Access Galery or Media and File is blocked by Google Play Store:
                /// Privacy Policy.
                /// https://support.google.com/googleplay/android-developer/answer/9876821?hl=en
                const SizedBox(width: 18),
                customIcon(
                  icon: const Icon(
                    Icons.image,
                    size: largeIconSize + 2,
                    color: AppColors.primary,
                  ),
                  tooltipMessage: 'Pilih Galeri',
                  label: 'Galeri',
                  onTap: onGalleryTap,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget customIcon({
    required Widget icon,
    required String label,
    required String tooltipMessage,
    VoidCallback? onTap,
  }) {
    return Tooltip(
      message: tooltipMessage,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          children: <Widget>[
            CustomInkWell(
              border: const CircleBorder(
                side: BorderSide(
                  color: AppColors.primary30,
                  width: 0.4,
                ),
              ),
              highlightColor: AppColors.black10,
              onTap: onTap,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: icon,
                ),
              ),
            ),
            const SizedBox(height: 6),
            CustomText.body(
              label,
              medium: true,
              fontSize: labelMediumTextSize,
            ),
          ],
        ),
      ),
    );
  }
}
