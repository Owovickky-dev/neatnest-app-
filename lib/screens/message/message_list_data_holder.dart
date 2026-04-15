import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:neat_nest/screens/message/utilities/chatting_state.dart';
import 'package:neat_nest/utilities/app_data.dart';
import 'package:neat_nest/utilities/app_time_conversion.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_text.dart';

class MessageDataHolder extends ConsumerWidget {
  const MessageDataHolder({
    super.key,
    required this.senderUsername,
    required this.timeSent,
    required this.lastMessageContent,
    this.senderImage,
    required this.isMe,
  });

  final String senderUsername;
  final String lastMessageContent;
  final String timeSent;
  final String? senderImage;
  final bool isMe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool active = ref.watch(chattingStateProvider);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 20.r,
                child: ClipOval(
                  child: CachedNetworkImage(
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                    imageUrl: AppData.imagePathway[1],
                  ),
                ),
              ),
              active
                  ? Positioned(
                      bottom: 2,
                      right: 0,
                      child: Icon(
                        Icons.circle,
                        color: AppColors.primaryColor,
                        size: 10.r,
                      ),
                    )
                  : Container(),
            ],
          ),
          10.wt,
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      primaryText(text: senderUsername, fontSize: 15.sp),
                      secondaryText(
                        text: lastMessageContent,
                        fontSize: 13.sp,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    secondaryText(
                      text: AppTimeConversion.formatMessageTime(timeSent),
                    ),
                    Icon(
                      isMe
                          ? Ionicons.arrow_forward_circle_outline
                          : Ionicons.arrow_back_circle_outline,
                      color: AppColors.secondaryTextColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
