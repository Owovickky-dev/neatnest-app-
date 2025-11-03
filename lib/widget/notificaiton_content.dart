import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neat_nest/utilities/constant/colors.dart';

void showSuccessNotification({
  required BuildContext context,
  required String message,
}) {
  Fluttertoast.showToast(
    msg: message,
    gravity: ToastGravity.TOP,
    toastLength: Toast.LENGTH_LONG,
    timeInSecForIosWeb: 2,
    backgroundColor: AppColors.primaryColor,
    textColor: Colors.white,
    fontSize: 16.sp,
  );
}

void showErrorNotification({
  required BuildContext context,
  required String message,
}) {
  Fluttertoast.showToast(
    msg: message,
    gravity: ToastGravity.TOP,
    toastLength: Toast.LENGTH_LONG,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.sp,
  );
}
