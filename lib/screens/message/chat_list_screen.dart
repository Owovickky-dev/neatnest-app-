import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/state%20controller%20/message/chat_state_controller.dart';
import 'package:neat_nest/screens/message/message_list_data_holder.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_bar_holder.dart';
import 'package:neat_nest/widget/loading_screen.dart';

import '../../widget/app_text_field.dart';

class ChatListScreen extends ConsumerStatefulWidget {
  const ChatListScreen({super.key});

  @override
  ConsumerState<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends ConsumerState<ChatListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(chatStateControllerProvider.notifier).getChatRooms();
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatStateControllerProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(title: "My Messages"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            20.ht,
            AppTextField(hintText: 'Search...', iconPrefix: Icons.search),
            20.ht,

            Expanded(
              child: chatState.when(
                loading: () => const LoadingScreen(),

                error: (err, st) => Center(child: Text("Error: $err")),

                data: (chats) {
                  if (chats.isEmpty) {
                    return const Center(child: Text("No chats yet"));
                  }

                  return ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      final chatData = chats[index];

                      return MessageDataHolder(
                        senderUsername: chatData.partnerUsername ?? "",
                        timeSent: chatData.lastMessage?.sentAt ?? "",
                        lastMessageContent: chatData.lastMessage?.content ?? "",
                        isMe: chatData.lastMessage!.isMe,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
