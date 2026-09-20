import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/state%20controller%20/message/chat_state_controller.dart';
import 'package:neat_nest/controller/state%20controller%20/message/message_state_controller.dart';
import 'package:neat_nest/models/message_model.dart';
import 'package:neat_nest/screens/booking/widgets/booking_text_field.dart';
import 'package:neat_nest/screens/history/utilities/app_bar_icon.dart';
import 'package:neat_nest/screens/message/widget/chatting_screen_data.dart';
import 'package:neat_nest/utilities/app_data.dart';
import 'package:neat_nest/utilities/app_time_conversion.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/widget/app_confirmation_button.dart';
import 'package:neat_nest/widget/app_text.dart';
import 'package:neat_nest/widget/loading_screen.dart';

import '../../../models/chat_room_model.dart';
import '../../../utilities/constant/extension.dart';

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

  final ScrollController _scrollController = ScrollController();

  bool _isSending = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);

    _controller.addListener(_onTextChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      ref
          .read(messageStateControllerProvider.notifier)
          .initializeChat(widget.chatId, widget.recipientId);
    });
  }

  // ============================================================
  // TEXT FIELD
  // ============================================================

  void _onTextChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  // ============================================================
  // PAGINATION
  // ============================================================

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    if (_scrollController.position.pixels <= 100) {
      ref
          .read(messageStateControllerProvider.notifier)
          .loadMoreMessages(widget.chatId);
    }
  }

  // ============================================================
  // SEND TYPING
  // ============================================================

  void _sendTyping() {
    ref.read(messageStateControllerProvider.notifier).sendTyping(widget.chatId);
  }

  void _sendStopTyping() {
    ref
        .read(messageStateControllerProvider.notifier)
        .sendStopTyping(widget.chatId);
  }

  // ============================================================
  // SEND MESSAGE
  // ============================================================

  Future<void> _sendMessage() async {
    if (_isSending) {
      return;
    }

    final messageContent = _controller.text.trim();

    if (messageContent.isEmpty) {
      return;
    }

    setState(() {
      _isSending = true;
    });

    _sendStopTyping();

    _controller.clear();

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
        ref
            .read(chatStateControllerProvider.notifier)
            .updateLastMessage(
              chatId: widget.chatId,
              newMessage: LastMessage(
                content: sentMessage.content,
                senderId: sentMessage.sender?.senderId ?? "",
                senderRole: sentMessage.sender?.name ?? "",
                sentAt: sentMessage.sendAt ?? DateTime.now().toIso8601String(),
                messageType: "text",
                isMe: true,
              ),
            );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  // ============================================================
  // RETRY FAILED MESSAGE
  // ============================================================

  Future<void> _retryMessage(MessageModel message) async {
    final sentMessage = await ref
        .read(messageStateControllerProvider.notifier)
        .resendMessage(message);

    if (sentMessage == null) {
      return;
    }

    ref
        .read(chatStateControllerProvider.notifier)
        .updateLastMessage(
          chatId: widget.chatId,
          newMessage: LastMessage(
            content: sentMessage.content,
            senderId: sentMessage.sender?.senderId ?? "",
            senderRole: sentMessage.sender?.name ?? "",
            sentAt: sentMessage.sendAt ?? DateTime.now().toIso8601String(),
            messageType: "text",
            isMe: true,
          ),
        );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(messageStateControllerProvider);

    final isOnline = chatState.value?.isRecipientOnline ?? false;

    final isTyping = chatState.value?.isRecipientTyping ?? false;

    return Scaffold(
      backgroundColor: Colors.white,

      // ========================================================
      // APP BAR
      // ========================================================
      appBar: AppBar(
        backgroundColor: Colors.white,

        leading: AppBarIcon(
          icons: Icons.arrow_back,
          function: () {
            Navigator.pop(context);
          },
        ),

        title: Row(
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
                primaryText(text: widget.senderUserName, fontSize: 15.sp),

                secondaryText(
                  text: isTyping
                      ? "Typing..."
                      : isOnline
                      ? "Online"
                      : "Offline",
                  fontSize: 13.sp,
                  color: isTyping || isOnline
                      ? AppColors.primaryColor
                      : Colors.grey,
                ),
              ],
            ),
          ],
        ),

        // ======================================================
        // MENU
        // ======================================================
        actions: [
          PopupMenuButton(
            color: Colors.white,

            icon: AppBarIcon(icons: Icons.more_vert),

            onSelected: (value) {
              if (value == "Accept Offer") {
                appConfirmationButton(
                  context: context,
                  title: "Order Status",
                  subTitle: "Are you sure you want to accept the offer",
                  textButtonTextLeft: "Cancel",
                  textButtonTextRight: "Yes",
                  functionRight: () {
                    print("This is Yes");
                  },
                );
              }

              if (value == "Reject Offer") {
                appConfirmationButton(
                  context: context,
                  title: "Order Status",
                  subTitle: "Are you sure you want to reject the offer",
                  textButtonTextLeft: "Cancel",
                  textButtonTextRight: "Yes",
                  functionRight: () {
                    print("This is Yes");
                  },
                );
              }
            },

            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: "Accept Offer",
                child: secondaryText(
                  text: "Accept Offer",
                  color: AppColors.blackTextColor,
                ),
              ),

              PopupMenuItem(
                value: "Reject Offer",
                child: secondaryText(
                  text: "Reject Offer",
                  color: AppColors.blackTextColor,
                ),
              ),
            ],
          ),
        ],
      ),

      // ========================================================
      // BODY
      // ========================================================
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),

          child: Column(
            children: [
              DottedLine(
                dashColor: AppColors.secondaryTextColor.withValues(alpha: 0.5),
              ),

              20.ht,

              Expanded(
                child: chatState.when(
                  loading: () {
                    return const LoadingScreen();
                  },

                  error: (error, stackTrace) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          const Icon(Icons.error_outline, size: 40),

                          SizedBox(height: 10.h),

                          Text(
                            "Failed to load messages",
                            style: TextStyle(fontSize: 15.sp),
                          ),

                          SizedBox(height: 10.h),

                          ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(messageStateControllerProvider.notifier)
                                  .loadMessages(widget.chatId);
                            },
                            child: const Text("Retry"),
                          ),
                        ],
                      ),
                    );
                  },

                  data: (state) {
                    final msgs = state.messages;

                    if (msgs.isEmpty) {
                      return const Center(child: Text("No Messages yet"));
                    }

                    // Make a copy so we don't mutate
                    // Riverpod's actual state.
                    final sortedMsgs = [...msgs];

                    sortedMsgs.sort((a, b) {
                      return DateTime.parse(
                        a.sendAt!,
                      ).compareTo(DateTime.parse(b.sendAt!));
                    });

                    // ==================================================
                    // GROUP MESSAGES BY DATE
                    // ==================================================

                    final List<Map<String, dynamic>> chatItems = [];

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

                    // ==================================================
                    // MESSAGE LIST
                    // ==================================================

                    return ListView.builder(
                      controller: _scrollController,

                      reverse: true,

                      itemCount:
                          reversedItems.length + (state.isLoadingMore ? 1 : 0),

                      itemBuilder: (context, index) {
                        if (index == reversedItems.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        final item = reversedItems[index];

                        // ----------------------------------------------
                        // DATE HEADER
                        // ----------------------------------------------

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

                        // ----------------------------------------------
                        // MESSAGE
                        // ----------------------------------------------

                        final MessageModel message = item["data"];

                        return Align(
                          alignment: message.isMe!
                              ? Alignment.centerRight
                              : Alignment.centerLeft,

                          child: ChattingScreenData(
                            message: message.content,
                            isSender: message.isMe!,
                            time: message.sendAt!,
                            messageStatus: message.sentStatus,

                            onTapRetry:
                                message.sentStatus == MessageStatus.failed
                                ? () {
                                    _retryMessage(message);
                                  }
                                : null,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              10.ht,

              // ==================================================
              // TYPING INDICATOR
              // ==================================================
              if (isTyping)
                Align(
                  alignment: Alignment.centerLeft,

                  child: Padding(
                    padding: EdgeInsets.only(left: 8.w, bottom: 6.h),

                    child: Row(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        const _TypingDots(),

                        5.wt,

                        secondaryText(
                          text: "Typing...",
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),

              // ==================================================
              // INPUT
              // ==================================================
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,

                  children: [
                    Expanded(
                      child: BookingTextField(
                        textEditingController: _controller,

                        hintText: "write message",

                        onChange: (value) {
                          if (value.isNotEmpty) {
                            _sendTyping();
                          } else {
                            _sendStopTyping();
                          }
                        },
                      ),
                    ),

                    10.wt,

                    AppBarIcon(
                      icons: Icons.send,

                      height: 60,
                      width: 60,
                      iconSize: 40,

                      iconColor: _controller.text.trim().isEmpty
                          ? AppColors.blackTextColor
                          : AppColors.primaryColor,

                      function: _controller.text.trim().isEmpty || _isSending
                          ? null
                          : _sendMessage,
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

// ================================================================
// TYPING DOTS
// ================================================================

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

      children: List.generate(3, (index) => _SingleDot(delay: index * 0.2)),
    );
  }
}

// ================================================================
// SINGLE TYPING DOT
// ================================================================

class _SingleDot extends StatefulWidget {
  const _SingleDot({required this.delay});

  final double delay;

  @override
  State<_SingleDot> createState() => _SingleDotState();
}

class _SingleDotState extends State<_SingleDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween<double>(
      begin: 0,
      end: -5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Future.delayed(Duration(milliseconds: (widget.delay * 1000).toInt()), () {
      if (mounted) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,

      builder: (_, _) {
        return Transform.translate(
          offset: Offset(0, _animation.value),

          child: Container(
            width: 6,
            height: 6,

            margin: const EdgeInsets.symmetric(horizontal: 2),

            decoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}
