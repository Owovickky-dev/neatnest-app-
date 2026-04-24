import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:neat_nest/models/message_model.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_text.dart';

class ChattingScreenData extends StatelessWidget {
  const ChattingScreenData({
    super.key,
    required this.message,
    required this.isSender,
    required this.time,
    required this.messageStatus,
    this.onTapRetry,
  });

  final String message;
  final bool isSender;
  final String time;
  final MessageStatus? messageStatus;
  final VoidCallback? onTapRetry;

  @override
  Widget build(BuildContext context) {
    final formattedTime = DateFormat.jm().format(
      DateTime.parse(time).toLocal(),
    );
    final isFailed = messageStatus == MessageStatus.failed;
    return GestureDetector(
      onTap: isFailed ? onTapRetry : null,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Container(
          constraints: BoxConstraints(maxWidth: 0.75.sw),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: isFailed
                ? Colors.red.shade100
                : isSender
                ? AppColors.primaryColor
                : AppColors.containerLightBackground,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12.r),
              bottomRight: Radius.circular(12.r),
              topLeft: isSender ? Radius.circular(12.r) : Radius.circular(0),
              topRight: isSender ? Radius.circular(0) : Radius.circular(12.r),
            ),
          ),
          child: Column(
            crossAxisAlignment: isSender
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              primaryText(
                text: message,
                color: isFailed
                    ? Colors.red.shade900
                    : isSender
                    ? Colors.white
                    : AppColors.blackTextColor,
              ),
              if (isFailed) ...[
                2.ht,
                Text(
                  "Tap to retry",
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.red.shade700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
              4.ht,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  secondaryText(
                    text: formattedTime,
                    fontSize: 11.sp,
                    color: isFailed
                        ? Colors.red.shade700
                        : isSender
                        ? Colors.white70
                        : Colors.black54,
                  ),
                  if (isSender) ...[4.wt, _buildStatusIcon(messageStatus!)],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildStatusIcon(MessageStatus messageStatus) {
  switch (messageStatus) {
    case MessageStatus.pending:
      return Icon(Icons.done, size: 14.sp, color: Colors.white70);
    case MessageStatus.sent:
      return Icon(Icons.done_all_outlined, size: 14.sp, color: Colors.white70);
    case MessageStatus.failed:
      return Icon(Icons.error_outline, size: 14.sp, color: Colors.red.shade700);
  }
}
