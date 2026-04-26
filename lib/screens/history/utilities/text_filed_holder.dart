import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_text.dart';

class TextFiledHolder extends StatelessWidget {
  const TextFiledHolder({
    super.key,
    required this.titleText,
    this.hintText,
    this.textAlign,
    this.textStyle,
    this.controller,
    this.containerHeight,
    this.validator,
    this.inputFormatters,
  });

  final String titleText;
  final String? hintText;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final TextEditingController? controller;
  final double? containerHeight;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        primaryText(text: titleText, fontSize: 18.sp),
        10.ht,
        Container(
          height: containerHeight ?? 100.h,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.containerLightBackground,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: TextFormField(
            expands: true,
            autofocus: false,
            showCursor: true,
            controller: controller,
            validator: validator,
            inputFormatters: inputFormatters,
            style:
                textStyle ??
                TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            textAlign: textAlign ?? TextAlign.center,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: hintText ?? '',
              errorStyle: TextStyle(fontWeight: FontWeight.bold),

              hintStyle: TextStyle(
                color: AppColors.secondaryTextColor,
                fontSize: 12.sp,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(color: Colors.red, width: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
