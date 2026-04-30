import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/state%20controller%20/message/chat_state_controller.dart';
import 'package:neat_nest/data/storage/secure_storage_helper.dart';
import 'package:neat_nest/screens/message/utilities/chat_list_data_holder.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';
import 'package:neat_nest/widget/app_bar_holder.dart';
import 'package:neat_nest/widget/loading_screen.dart';

import '../../models/message_model.dart';
import '../../utilities/app_button.dart';
import '../../utilities/bottom_nav/widget/bottom_nav_notifiers.dart';
import '../../utilities/constant/colors.dart';
import '../../widget/app_text.dart';
import '../../widget/app_text_field.dart';

class ChatListScreen extends ConsumerStatefulWidget {
  const ChatListScreen({super.key});

  @override
  ConsumerState<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends ConsumerState<ChatListScreen> {
  bool userLoggedIn = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkUser();
    });
  }

  Future<String?> getUserId() async {
    final user = await SecureStorageHelper.getUserData();
    return user?.id;
  }

  Future<void> checkUser() async {
    final userDataExist = await SecureStorageHelper.isDataStored();
    if (!mounted) return;
    setState(() {
      userLoggedIn = userDataExist;
    });

    if (userDataExist) {
      await ref.read(chatStateControllerProvider.notifier).getChatRooms();
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatStateControllerProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(
        title: "My Messages",
        function: () {
          ref.read(bottomNavNotifiersProvider.notifier).indexUpdate(0);
          AppNavigatorHelper.replace(context, AppRoute.bottomNavigation);
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: userLoggedIn
            ? Column(
                children: [
                  Expanded(
                    child: chatState.when(
                      loading: () => const LoadingScreen(),
                      error: (err, st) => Center(child: Text("Error: $err")),
                      data: (chats) {
                        if (chats.isEmpty) {
                          return const Center(child: Text("No chats yet"));
                        }
                        return Column(
                          children: [
                            20.ht,
                            AppTextField(
                              hintText: 'Search...',
                              iconPrefix: Icons.search,
                            ),
                            20.ht,
                            Expanded(
                              child: ListView.builder(
                                itemCount: chats.length,
                                itemBuilder: (context, index) {
                                  final chatData = chats[index];
                                  return GestureDetector(
                                    onTap: () {
                                      AppNavigatorHelper.push(
                                        context,
                                        AppRoute.chattingScreen,
                                        extra: ChattingScreenPreData(
                                          chatId: chatData.chatId!,
                                          senderUserName:
                                              chatData.partnerUsername!,
                                          recipientId: chatData.recipientId!,
                                        ),
                                      );
                                    },
                                    child: ChatListDataHolder(
                                      senderUsername:
                                          chatData.partnerUsername ?? "",
                                      timeSent:
                                          chatData.lastMessage?.sentAt ?? "",
                                      lastMessageContent:
                                          chatData.lastMessage?.content ?? "",
                                      isMe: chatData.lastMessage!.isMe,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              )
            : Center(
                child: Column(
                  children: [
                    30.ht,
                    Container(
                      height: 50.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.r),
                        color: Colors.grey.shade200,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person,
                          color: AppColors.primaryColor,
                          size: 30.sp,
                        ),
                      ),
                    ),
                    15.ht,
                    secondaryText(
                      text: "Please sign in to access this content",
                      color: Colors.black,
                    ),
                    15.ht,
                    secondaryText(
                      text: "if you are not registered just sign up ",
                    ),
                    30.ht,
                    AppButton(
                      text: "Sign  In",
                      fontSize: 15.sp,
                      width: double.infinity,
                      bckColor: AppColors.primaryColor,
                      textColor: Colors.white,
                      function: () {
                        AppNavigatorHelper.push(context, AppRoute.signIn);
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
