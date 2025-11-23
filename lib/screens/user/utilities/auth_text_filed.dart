import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_text.dart';

class AuthTextFiled extends StatefulWidget {
  const AuthTextFiled({
    super.key,
    required this.titleText,
    required this.hintText,
    this.secure = false,
    required this.textEditingController,
    this.maxLine = 1,
    this.containerHeight,
    this.textInputType,
    this.inputFormatters,
    this.onChanged,
    this.validator,
    this.readOnly = false,
    this.onTap,
  });

  final String titleText;
  final String hintText;
  final bool secure;
  final TextEditingController textEditingController;
  final int? maxLine;
  final double? containerHeight;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool readOnly;
  final void Function()? onTap;

  @override
  State<AuthTextFiled> createState() => _AuthTextFiledState();
}

class _AuthTextFiledState extends State<AuthTextFiled> {
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        primaryText(text: widget.titleText, fontSize: 14.sp),
        5.ht,
        TextFormField(
          controller: widget.textEditingController,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          keyboardType: widget.textInputType ?? TextInputType.multiline,
          maxLines: widget.maxLine,
          inputFormatters: widget.inputFormatters,
          style: TextStyle(
            color: AppColors.blackTextColor,
            fontWeight: FontWeight.bold,
          ),
          validator: widget.validator,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            errorStyle: TextStyle(fontWeight: FontWeight.bold),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey.shade200,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: AppColors.secondaryTextColor),
            suffixIcon: !widget.secure
                ? null
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        visible = !visible;
                      });
                    },
                    child: Icon(
                      visible ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                  ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(
                color: AppColors.containerLightBackground,
                width: 1,
              ),
            ),
          ),
          obscureText: !widget.secure
              ? false
              : visible
              ? true
              : false,
          obscuringCharacter: "*",
        ),
      ],
    );
  }
}
