import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

enum ImageType { ads, profile, chat, verification }

class ImageConfig {
  final int quality;
  final int minWidth;
  final int minHeight;

  ImageConfig({
    required this.quality,
    required this.minWidth,
    required this.minHeight,
  });
}

ImageConfig getConfig(ImageType type) {
  switch (type) {
    case ImageType.verification:
      return ImageConfig(quality: 85, minWidth: 1000, minHeight: 1000);
    case ImageType.ads:
      return ImageConfig(quality: 80, minWidth: 800, minHeight: 800);

    case ImageType.profile:
      return ImageConfig(quality: 70, minWidth: 400, minHeight: 400);

    case ImageType.chat:
      return ImageConfig(quality: 60, minWidth: 300, minHeight: 300);
  }
}

class ImageUploadHelper {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickImage(ImageSource source) async {
    try {
      final picked = await _picker.pickImage(
        source: source,
        imageQuality: 100, // keep original first
      );

      if (picked == null) return null;

      return File(picked.path);
    } catch (e) {
      if (kDebugMode) print("Pick error: $e");
      return null;
    }
  }

  ///  GET FILE SIZE (KB)
  static int getFileSizeKB(File file) {
    return file.lengthSync() ~/ 1024;
  }

  ///   READABLE SIZE (KB / MB)
  static String getReadableSize(File file) {
    final kb = file.lengthSync() / 1024;
    final mb = kb / 1024;

    if (mb >= 1) {
      return "${mb.toStringAsFixed(2)} MB";
    } else {
      return "${kb.toStringAsFixed(0)} KB";
    }
  }

  /// COMPRESS IMAGE (DYNAMIC BASED ON TYPE)
  static Future<File?> compressImage(File file, ImageType type) async {
    try {
      final dir = await getTemporaryDirectory();
      final targetPath =
          '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

      final config = getConfig(type);

      final output = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: config.quality,
        format: CompressFormat.jpeg,
        minHeight: config.minHeight,
        minWidth: config.minWidth,
      );

      if (output != null && await File(output.path).exists()) {
        final compressedFile = File(output.path);

        if (kDebugMode) {
          print(
            'Compressed: ${getFileSizeKB(file)}KB → ${getFileSizeKB(compressedFile)}KB',
          );
        }

        return compressedFile;
      }

      return file;
    } catch (e) {
      if (kDebugMode) print("Compression error: $e");
      return file;
    }
  }

  ///  SMART PROCESS (SKIP SMALL IMAGES)
  static Future<File?> processImage(File file, ImageType type) async {
    try {
      final sizeKB = getFileSizeKB(file);

      /// Skip compression if image is already small
      if (sizeKB < 300) {
        if (kDebugMode) {
          print("Skipping compression (small image: ${sizeKB}KB)");
        }
        return file;
      }

      return await compressImage(file, type);
    } catch (e) {
      if (kDebugMode) print("Process error: $e");
      return file;
    }
  }

  ///  FULL FLOW: PICK → PROCESS
  static Future<File?> pickAndProcess(
    ImageSource source,
    ImageType type,
  ) async {
    final picked = await pickImage(source);
    if (picked == null) return null;

    final processed = await processImage(picked, type);
    return processed;
  }
}
