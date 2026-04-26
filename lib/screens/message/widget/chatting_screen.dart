import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/state%20controller%20/message/message_state_controller.dart';
import 'package:neat_nest/data/storage/secure_storage_helper.dart';
import 'package:neat_nest/models/message_model.dart';
import 'package:neat_nest/screens/booking/widgets/booking_text_field.dart';
import 'package:neat_nest/screens/history/utilities/app_bar_icon.dart';
import 'package:neat_nest/screens/message/widget/chatting_screen_data.dart';
import 'package:neat_nest/utilities/constant/constant_data.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../utilities/app_data.dart';
import '../../../utilities/app_time_conversion.dart';
import '../../../utilities/constant/colors.dart';
import '../../../widget/app_text.dart';
import '../../../widget/loading_screen.dart';

class ChattingScreen extends ConsumerStatefulWidget {
  const ChattingScreen({
    super.key,
    required this.chatId,
    required this.senderUserName,
    required this.recipientId,
  });

  final String chatId;
  final String senderUserName;
  final String recipientId;

  @override
  ConsumerState<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends ConsumerState<ChattingScreen> {
  final TextEditingController _controller = TextEditingController();

  IO.Socket? socket;
  List<String> onlineUsers = [];
  bool typing = false;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      connect();
      ref
          .read(messageStateControllerProvider.notifier)
          .loadMessages(widget.chatId);
    });
  }

  @override
  void dispose() {
    socket?.disconnect();
    socket?.dispose();
    super.dispose();
  }

  Future<void> connect() async {
    socket = IO.io(
      ConstantData.SOCKET_IO,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setPath('/socket.io')
          .disableAutoConnect()
          .build(),
    );
    socket!.connect();

    socket!.onConnect((_) async {
      print("Socket connected");

      final user = await SecureStorageHelper.getUserData();

      socket!.emit("setup", user?.id);
      socket!.emit("join chat", widget.chatId);

      socket!.on("online-users", (users) {
        setState(() {
          onlineUsers = List<String>.from(users);
        });
      });

      socket!.on("offline-user", (userId) {
        setState(() => onlineUsers.remove(userId));
      });

      socket!.on("typing", (_) {
        setState(() => typing = true);
      });

      socket!.on("stop typing", (_) {
        setState(() => typing = false);
      });

      socket!.on("message received", (data) {
        sendStopTyping(widget.chatId);
        final MessageModel newText = MessageModel.fromJson(data);
        if (newText.sender?.senderId != user?.id) {
          ref
              .read(messageStateControllerProvider.notifier)
              .addNewMessage(newText);
        }
      });
    });

    socket!.onConnectError((err) => print("Connection error: $err"));
    socket!.onDisconnect((_) => print("Socket disconnected"));
  }

  void sendTyping(String status) => socket!.emit("typing", status);
  void sendStopTyping(String status) => socket!.emit("stop typing", status);
  void sendNewMessage(MessageModel newMessage) {
    socket!.emit("new message", newMessage.toJson());
    sendStopTyping(widget.chatId);
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(messageStateControllerProvider);

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
                    function: () => Navigator.pop(context),
                  ),
                  10.wt,
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
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
                            7.wt,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                primaryText(
                                  text: widget.senderUserName,
                                  fontSize: 15.sp,
                                ),
                                secondaryText(
                                  text: typing
                                      ? 'typing...'
                                      : onlineUsers.contains(widget.recipientId)
                                      ? 'Online'
                                      : 'Offline',
                                  fontSize: 13.sp,
                                  color:
                                      typing ||
                                          onlineUsers.contains(
                                            widget.recipientId,
                                          )
                                      ? Colors.green
                                      : Colors.grey,
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
                child: messages.when(
                  loading: () => const LoadingScreen(),
                  error: (err, st) => Center(child: Text("Error: $err")),
                  data: (msgs) {
                    if (msgs.isEmpty) {
                      return const Center(child: Text("No Messages yet"));
                    }
                    final sortedMsgs = [...msgs];
                    sortedMsgs.sort(
                      (a, b) => DateTime.parse(
                        a.sendAt!,
                      ).compareTo(DateTime.parse(b.sendAt!)),
                    );
                    List<Map<String, dynamic>> chatItems = [];
                    String? lastLabel;

                    for (final msg in sortedMsgs) {
                      final label = AppTimeConversion.getMessageGroupLabel(
                        msg.sendAt!,
                      );
                      if (lastLabel != label) {
                        chatItems.add({"type": "header", "label": label});
                        lastLabel = label;
                      }
                      chatItems.add({"type": "message", "data": msg});
                    }
                    final reversedItems = chatItems.reversed.toList();
                    return ListView.builder(
                      reverse: true,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      itemCount: reversedItems.length,
                      itemBuilder: (context, index) {
                        final item = reversedItems[index];

                        if (item["type"] == "header") {
                          return Center(
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10.h),
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 5.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: secondaryText(text: item["label"]),
                            ),
                          );
                        }

                        final MessageModel msg = item["data"];

                        return Align(
                          alignment: msg.isMe!
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: ChattingScreenData(
                            message: msg.content,
                            isSender: msg.isMe!,
                            time: msg.sendAt!,
                            messageStatus: msg.sentStatus,
                            onTapRetry: msg.sentStatus == MessageStatus.failed
                                ? () async {
                                    final sentMessage = await ref
                                        .read(
                                          messageStateControllerProvider
                                              .notifier,
                                        )
                                        .resendMessage(msg);
                                    if (sentMessage != null) {
                                      sendNewMessage(sentMessage);
                                    }
                                  }
                                : null,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              if (typing)
                Padding(
                  padding: EdgeInsets.only(left: 12.w, bottom: 4.h),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _TypingDots(),
                        6.wt,
                        secondaryText(
                          text: '${widget.senderUserName} is typing...',
                          fontSize: 12.sp,
                        ),
                      ],
                    ),
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
                        onChange: (val) {
                          if (val.isNotEmpty) {
                            sendTyping(widget.chatId);
                          } else {
                            sendStopTyping(widget.chatId);
                          }
                        },
                      ),
                    ),
                    10.wt,
                    AppBarIcon(
                      icons: Icons.send,
                      height: 50.h,
                      width: 50.w,
                      radius: 25.r,
                      bckColor: AppColors.primaryColor,
                      iconColor: Colors.white,
                      function: () async {
                        if (_isSending || _controller.text.trim().isEmpty) {
                          return;
                        }

                        setState(() => _isSending = true);

                        final messageContent = _controller.text.trim();
                        _controller.clear();
                        sendStopTyping(widget.chatId);

                        try {
                          final message = MessageModel(
                            content: messageContent,
                            chatId: widget.chatId,
                            recipientId: widget.recipientId,
                          );

                          final sentMessage = await ref
                              .read(messageStateControllerProvider.notifier)
                              .sendMessage(message);

                          if (sentMessage != null) {
                            sendNewMessage(sentMessage);
                          }
                        } finally {
                          if (mounted) setState(() => _isSending = false);
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

class _TypingDots extends StatefulWidget {
  const _TypingDots();

  @override
  State<_TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<_TypingDots> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) => _SingleDot(delay: i * 0.2)),
    );
  }
}

class _SingleDot extends StatefulWidget {
  const _SingleDot({required this.delay});
  final double delay;

  @override
  State<_SingleDot> createState() => _SingleDotState();
}

class _SingleDotState extends State<_SingleDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _anim = Tween<double>(
      begin: 0,
      end: -5,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));

    Future.delayed(Duration(milliseconds: (widget.delay * 1000).toInt()), () {
      if (mounted) _ctrl.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, _) => Transform.translate(
        offset: Offset(0, _anim.value),
        child: Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: const BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
