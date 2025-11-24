import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neat_nest/utilities/constant/colors.dart';

void showSuccessNotification({required String message}) {
  Fluttertoast.showToast(
    msg: message,
    gravity: ToastGravity.TOP,
    toastLength: Toast.LENGTH_LONG,
    timeInSecForIosWeb: 5,
    backgroundColor: AppColors.primaryColor,
    textColor: Colors.white,
    fontSize: 14.sp,
  );
}

void showErrorNotification({required String message}) {
  Fluttertoast.showToast(
    msg: message,
    gravity: ToastGravity.TOP,
    toastLength: Toast.LENGTH_LONG,
    timeInSecForIosWeb: 7,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 15.sp,
  );
}

void notificationTest({required String message}) {
  Fluttertoast.showToast(
    msg: message,
    gravity: ToastGravity.TOP,
    toastLength: Toast.LENGTH_LONG,
    timeInSecForIosWeb: 3,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 15.sp,
  );
}
