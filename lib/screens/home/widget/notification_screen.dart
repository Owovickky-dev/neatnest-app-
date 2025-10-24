import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:neat_nest/screens/home/notifier/notification_state_notifier.dart';
import 'package:neat_nest/screens/home/utilities/notification_screen_holder.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';

import '../../../models/notification_model.dart';
import '../../../widget/app_text.dart';
import '../../history/utilities/app_bar_icon.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  Map<DateTime, List<NotificationModel>> groupNotifications(
    List<NotificationModel> notifications,
  ) {
    final Map<DateTime, List<NotificationModel>> grouped = {};

    for (var notif in notifications) {
      // convert to local date/time to avoid timezone issues
      final local = notif.datetime.toLocal();

      // create a date-only so that it will be used as each group name...
      final dateOnly = DateTime(local.year, local.month, local.day);

      grouped.putIfAbsent(dateOnly, () => []).add(notif);
    }

    return grouped;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationStateProvider.notifier).defaultData();
    });
  }

  String friendlyLabelFromKey(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final diffDays = today.difference(date).inDays;

    if (diffDays == 0) return 'Today';
    if (diffDays == 1) return 'Yesterday';
    if (diffDays < 7) return DateFormat('EEEE').format(date); // e.g., 'Monday'
    return DateFormat('dd MMM yyyy').format(date); // e.g., '24 Sep 2025'
  }

  @override
  Widget build(BuildContext context) {
    final notification = ref.watch(notificationStateProvider);
    final groupedNotification = groupNotifications(notification);
    final keys = groupedNotification.keys.toList()
      ..sort((a, b) => b.compareTo(a));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: primaryText(text: 'Notifications'),
        centerTitle: false,
        leading: AppBarIcon(
          icons: Icons.arrow_back,
          function: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          PopupMenuButton(
            color: Colors.white,
            icon: AppBarIcon(icons: Icons.more_vert),
            onSelected: (value) {
              if (value == "Mark All") {
                ref.read(notificationStateProvider.notifier).markAllAsRead();
              }
              if (value == "Delete All") {
                ref
                    .read(notificationStateProvider.notifier)
                    .emptyNotification();
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: "Delete All",
                child: secondaryText(
                  text: "Delete All",
                  color: AppColors.blackTextColor,
                ),
              ),
              PopupMenuItem(
                value: "Mark All",
                child: secondaryText(
                  text: "Mark All",
                  color: AppColors.blackTextColor,
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            20.ht,
            Expanded(
              child: ListView.builder(
                itemCount: keys.length,
                itemBuilder: ((context, outerIndex) {
                  final key = keys[outerIndex]; // e.g. '2025-09-24'
                  final items =
                      groupedNotification[key]!; // list of NotificationModel
                  final label = friendlyLabelFromKey(key);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      primaryText(text: label),
                      20.ht,
                      ListView.builder(
                        itemCount: items.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: ((context, index) {
                          final notif = items[index];
                          return GestureDetector(
                            onTap: () {
                              ref
                                  .read(notificationStateProvider.notifier)
                                  .markAsRead(notif.id);
                            },
                            child: NotificationScreenHolder(
                              title: notif.title,
                              message: notif.message,
                              date: notif.datetime,
                              read: notif.read,
                            ),
                          );
                        }),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
