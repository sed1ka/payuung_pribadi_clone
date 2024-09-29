import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as imglib;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:payuung_pribadi_clone/utils/helper.dart';

class AssetsHelper {
  static Future<File?> compressImageFile(
    File file, {
    int? targetMaximalBytes,
  }) async {
    Uint8List uint8listFile;
    try {
      uint8listFile = await file.readAsBytes();
    } catch (e) {
      throw ErrorDescription(
        '[AssetsHelper] Failed to read a file as Uint8ListFile',
      );
    }

    final imglib.Image? image = imglib.decodeImage(uint8listFile);
    if (image == null) return file;

    int targetQuality = 90;
    int targetMaximalSize = targetMaximalBytes ?? 1024; // 1024 = 1 Mega Bytes
    double imageSizeInMb = (image.lengthInBytes) / targetMaximalSize;

    if (imageSizeInMb > targetMaximalSize) {
      targetQuality = ((targetMaximalSize / imageSizeInMb) * 100).toInt();
    }

    Uint8List? compressedImageBytes;
    try {
      compressedImageBytes = await FlutterImageCompress.compressWithFile(
        file.path,
        minWidth: 1080,
        minHeight: 1080,
        quality: targetQuality,
      );
    } catch (e) {
      throw ErrorDescription(
        '[AssetsHelper] Failed to compress image, '
        'problem occurred when calling FlutterImageCompress.compressWithFile'
        ' function. Error $e',
      );
    }

    if (compressedImageBytes == null) return file;

    final String resultPath = await generateFilePath(file.path);
    File resultFile = await fileWriteAsBytes(
      resultPath,
      bytes: compressedImageBytes,
    );

    return resultFile;
  }

  static Future<String> generateFilePath(String path) async {
    final Directory tempDir;
    try {
      tempDir = await getTemporaryDirectory();
    } catch (e) {
      throw ErrorDescription(
        '[AssetsHelper] Failed when try to getTemporaryDirectory',
      );
    }

    final String rawDocumentPath = tempDir.path;

    final String timeStamp =
        DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final String randomNumber = generateRandomNumber(3);
    final String fileName = 'Kreduit_${timeStamp}_$randomNumber';
    String resultPath;

    resultPath = p.join(rawDocumentPath, '$fileName${p.extension(path)}');

    return resultPath;
  }

  static Future<File> uint8ListToFile(Uint8List uint8list) async {
    final String generatePath = await generateFilePath('image.png');
    File file = await fileWriteAsBytes(
      generatePath,
      bytes: uint8list,
    );

    return file;
  }

  static Future<imglib.Image?> cropImage(
    imglib.Image image, {
    required int x,
    required int y,
    required int width,
    required int height,
  }) async {
    imglib.Image? croppedImage = imglib.copyCrop(
      image,
      x: x,
      y: y,
      width: width,
      height: height,
    );

    return croppedImage;
  }

  static Future<File?> cropImageFile(
    File file, {
    required int x,
    required int y,
    required int width,
    required int height,
  }) async {
    Uint8List uint8listFile = await file.readAsBytes();
    final imglib.Image? image = imglib.decodeImage(uint8listFile);
    if (image == null) return file;
    imglib.Image? croppedImage = imglib.copyCrop(
      image,
      x: x,
      y: y,
      width: width,
      height: height,
    );

    final String resultPath = await generateFilePath(file.path);
    File resultFile = await fileWriteAsBytes(
      resultPath,
      bytes: imglib.encodeJpg(croppedImage),
    );

    return resultFile;
  }

  static Future<File> convertImageToFile(
    imglib.Image image, {
    required String filePath,
  }) async {
    final String resultPath = await generateFilePath(filePath);
    File resultFile = await fileWriteAsBytes(
      resultPath,
      bytes: imglib.encodeJpg(image),
    );

    return resultFile;
  }

  static Future<File> fileWriteAsBytes(
    String path, {
    required List<int> bytes,
  }) async {
    File resultFile;
    try {
      resultFile = await File(path).writeAsBytes(bytes);
    } catch (e) {
      throw ErrorDescription(
        '[AssetsHelper] Failed when calling fileWriteAsBytes.'
        'The path: $path. The bytes: $bytes',
      );
    }

    return resultFile;
  }
}
