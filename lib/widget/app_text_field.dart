import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/utilities/constant/colors.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.hintText,
    this.iconSuffix,
    this.iconPrefix,
    this.function,
    this.onChanged,
  });

  final String? hintText;
  final IconData? iconSuffix;
  final IconData? iconPrefix;
  final VoidCallback? function;
  final Function(String)? onChanged;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    // Optional: Listen to focus changes
    _focusNode.addListener(() {
      setState(() {}); // Rebuild when focus changes
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r)),
      child: TextField(
        focusNode: _focusNode,
        decoration: InputDecoration(
          fillColor: _focusNode.hasFocus
              ? Colors.white
              : AppColors.containerLightBackground,
          filled: true,
          hintStyle: TextStyle(color: AppColors.secondaryTextColor),
          hintText: widget.hintText ?? '',
          suffixIcon: widget.iconSuffix != null
              ? GestureDetector(
                  onTap: () {
                    widget.function?.call();
                  },
                  child: Icon(
                    widget.iconSuffix,
                    color: _focusNode.hasFocus
                        ? AppColors.primaryColor
                        : AppColors.secondaryTextColor,
                  ),
                )
              : null,
          prefixIcon: widget.iconPrefix != null
              ? Icon(
                  widget.iconPrefix,
                  color: _focusNode.hasFocus
                      ? AppColors.primaryColor
                      : AppColors.secondaryTextColor,
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(
              color: _focusNode.hasFocus
                  ? AppColors.primaryColor
                  : Colors.transparent,
              width: _focusNode.hasFocus ? 1.5 : 0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 15.h,
            horizontal: 15.w,
          ),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
