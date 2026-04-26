import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../screens/history/utilities/app_bar_icon.dart';
import '../utilities/constant/colors.dart';
import '../utilities/constant/extension.dart';
import '../widget/app_text.dart';
import 'image_upload_helper.dart';

class ImageSelectWidget extends StatefulWidget {
  final ImageType type;
  final Function(File file) onImageSelected;

  const ImageSelectWidget({
    super.key,
    required this.type,
    required this.onImageSelected,
  });

  @override
  State<ImageSelectWidget> createState() => _ImageSelectWidgetState();
}

class _ImageSelectWidgetState extends State<ImageSelectWidget> {
  File? selectedImage;
  bool isLoading = false;

  Future<void> _pickImage(ImageSource source) async {
    setState(() => isLoading = true);

    final file = await ImageUploadHelper.pickAndProcess(source, widget.type);

    setState(() => isLoading = false);

    if (file != null) {
      setState(() => selectedImage = file);
      widget.onImageSelected(file);
    }
  }

  void _showImageSource() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
          padding: EdgeInsets.all(16.sp),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: const Text('Take Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.green),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _removeImage() {
    setState(() => selectedImage = null);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: selectedImage != null ? _showImageSource : null,
          child: Container(
            height: 150.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: AppColors.primaryColor, width: 2),
              image: selectedImage != null
                  ? DecorationImage(
                      image: FileImage(selectedImage!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: selectedImage != null
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.black.withValues(alpha: .15),
                    ),
                  )
                : Center(
                    child: isLoading
                        ? CircularProgressIndicator.adaptive(
                            backgroundColor: AppColors.primaryColor,
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppBarIcon(
                                icons: Icons.add_a_photo,
                                height: 60.h,
                                width: 60.w,
                                radius: 30.r,
                                function: _showImageSource,
                              ),
                              5.ht,
                              secondaryText(text: "Upload Picture"),
                            ],
                          ),
                  ),
          ),
        ),

        ///  REMOVE BUTTON
        if (selectedImage != null)
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: _removeImage,
              child: Container(
                padding: EdgeInsets.all(6.sp),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: .6),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: Colors.white, size: 18.sp),
              ),
            ),
          ),

        ///  OPTIONAL EDIT ICON (BOTTOM RIGHT)
        if (selectedImage != null)
          Positioned(
            bottom: 8,
            right: 8,
            child: GestureDetector(
              onTap: _showImageSource,
              child: Container(
                padding: EdgeInsets.all(6.sp),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.edit, color: Colors.white, size: 18.sp),
              ),
            ),
          ),
      ],
    );
  }
}
