import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../screens/history/utilities/app_bar_icon.dart';
import '../utilities/constant/colors.dart';
import '../utilities/constant/extension.dart';
import '../widget/app_text.dart';
import 'image_upload_helper.dart';

class MultiImageSelectWidget extends StatefulWidget {
  final ImageType imageType;
  final Function(List<File> files) onImagesSelected;

  const MultiImageSelectWidget({
    super.key,
    required this.imageType,
    required this.onImagesSelected,
  });

  @override
  State<MultiImageSelectWidget> createState() => _MultiImageSelectWidgetState();
}

class _MultiImageSelectWidgetState extends State<MultiImageSelectWidget> {
  List<File> selectedImages = [];

  bool isLoading = false;

  Future<void> _pickImages() async {
    try {
      setState(() => isLoading = true);
      final picker = ImagePicker();
      final List<XFile> images = await picker.pickMultiImage();

      if (images.isEmpty) {
        setState(() => isLoading = false);
        return;
      }

      List<File> processedImages = [];

      for (var image in images) {
        final file = File(image.path);

        final processed = await ImageUploadHelper.processImage(
          file,
          widget.imageType,
        );

        if (processed != null) {
          processedImages.add(processed);
        }
      }

      setState(() {
        selectedImages.addAll(processedImages);
      });

      widget.onImagesSelected(selectedImages);
    } catch (e) {
      debugPrint("Multi image error: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  /// REPLACE SINGLE IMAGE
  Future<void> _replaceImage(int index) async {
    try {
      final picker = ImagePicker();

      final XFile? picked = await picker.pickImage(source: ImageSource.gallery);

      if (picked == null) return;

      final file = File(picked.path);

      final processed = await ImageUploadHelper.processImage(
        file,
        widget.imageType,
      );

      if (processed == null) return;

      setState(() {
        selectedImages[index] = processed;
      });

      widget.onImagesSelected(selectedImages);
    } catch (e) {
      debugPrint("Replace image error: $e");
    }
  }

  /// DELETE IMAGE
  void _deleteImage(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });

    widget.onImagesSelected(selectedImages);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _pickImages,
          child: Container(
            height: 130.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.primaryColor, width: 2),
            ),
            child: isLoading
                ? Center(child: CircularProgressIndicator.adaptive())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppBarIcon(
                        icons: Icons.add_photo_alternate_outlined,
                        height: 55.h,
                        width: 55.w,
                        radius: 28.r,
                        function: _pickImages,
                      ),
                      8.ht,
                      secondaryText(text: "Upload Images"),
                    ],
                  ),
          ),
        ),

        15.ht,

        /// IMAGES GRID
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: List.generate(selectedImages.length, (index) {
            final image = selectedImages[index];

            return Stack(
              children: [
                Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    image: DecorationImage(
                      image: FileImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                /// DELETE BUTTON
                Positioned(
                  top: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () => _deleteImage(index),
                    child: Container(
                      padding: EdgeInsets.all(5.sp),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: .6),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                    ),
                  ),
                ),

                /// EDIT BUTTON
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () => _replaceImage(index),
                    child: Container(
                      padding: EdgeInsets.all(5.sp),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: .6),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.edit, color: Colors.white, size: 16.sp),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
