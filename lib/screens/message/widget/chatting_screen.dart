import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/screens/booking/widgets/booking_text_field.dart';
import 'package:neat_nest/screens/history/utilities/app_bar_icon.dart';
import 'package:neat_nest/screens/message/widget/chatting_screen_data.dart';
import 'package:neat_nest/utilities/constant/extension.dart';

import '../../../utilities/app_data.dart';
import '../../../utilities/constant/colors.dart';
import '../../../widget/app_text.dart';
import '../utilities/chatting_state.dart';

class ChattingScreen extends ConsumerStatefulWidget {
  const ChattingScreen({super.key});

  @override
  ConsumerState<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends ConsumerState<ChattingScreen> {
  final TextEditingController _controller = TextEditingController();
  bool senderTest = false;

  @override
  Widget build(BuildContext context) {
    bool active = ref.watch(chattingStateProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          color: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppBarIcon(
                    icons: Icons.arrow_back,
                    function: () {
                      Navigator.pop(context);
                    },
                  ),
                  10.wt,
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
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
                            7.wt,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                primaryText(
                                  text: AppData.serviceProviderName[1],
                                  fontSize: 15.sp,
                                ),
                                secondaryText(
                                  text: 'Online',
                                  fontSize: 13.sp,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                        AppBarIcon(icons: Icons.more_vert, function: () {}),
                      ],
                    ),
                  ),
                ],
              ),
              20.ht,
              DottedLine(
                dashColor: AppColors.secondaryTextColor.withValues(alpha: 0.5),
              ),
              20.ht,
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return ChattingScreenData(
                      message: "text",
                      isSender: true,
                      time: "time",
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: BookingTextField(
                        textEditingController: _controller,
                        hintText: "write message",
                        title: false,
                        isIconSuf: true,
                        isIconPre: true,
                        iconName: Icons.attach_file,
                        iconNamePre: Icons.emoji_emotions,
                      ),
                    ),
                    10.wt,
                    AppBarIcon(
                      icons: Icons.send_sharp,
                      height: 50.h,
                      width: 50.w,
                      radius: 25.r,
                      bckColor: AppColors.primaryColor,
                      iconColor: Colors.white,
                      function: () {
                        setState(() {
                          senderTest = !senderTest;
                        });
                        if (_controller.text.trim().isNotEmpty) {
                          _controller.clear();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
