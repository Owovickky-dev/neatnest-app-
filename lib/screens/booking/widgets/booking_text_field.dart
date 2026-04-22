import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/utilities/constant/extension.dart';

import '../../../utilities/constant/colors.dart';
import '../../../widget/app_text.dart';

class BookingTextField extends StatefulWidget {
  const BookingTextField({
    super.key,
    this.titleText,
    required this.textEditingController,
    required this.hintText,
    this.isIconSuf = false,
    this.isIconPre = false,
    this.title = true,
    this.iconName,
    this.iconNamePre,
    this.inputFormatters,
    this.onChange,
  });

  final String? titleText;
  final TextEditingController textEditingController;
  final String hintText;
  final bool isIconSuf;
  final bool isIconPre;
  final IconData? iconName;
  final IconData? iconNamePre;
  final bool title;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChange;

  @override
  State<BookingTextField> createState() => _BookingTextFieldState();
}

class _BookingTextFieldState extends State<BookingTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ?widget.title
            ? primaryText(text: widget.titleText ?? "", fontSize: 14.sp)
            : null,
        5.ht,
        Container(
          constraints: BoxConstraints(minHeight: 50.h, maxHeight: 120.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppColors.textFieldBckColor.withValues(alpha: 0.35),
          ),
          child: TextField(
            controller: widget.textEditingController,
            inputFormatters: widget.inputFormatters,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            minLines: 1,
            onChanged: widget.onChange,
            textInputAction: TextInputAction.newline,
            style: TextStyle(
              color: AppColors.blackTextColor,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(color: AppColors.secondaryTextColor),
              suffixIcon: !widget.isIconSuf
                  ? null
                  : GestureDetector(
                      child: Icon(
                        widget.iconName,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
              prefixIcon: !widget.isIconPre
                  ? null
                  : Icon(
                      widget.iconNamePre,
                      color: AppColors.secondaryTextColor,
                    ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.containerLightBackground,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.containerLightBackground,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
