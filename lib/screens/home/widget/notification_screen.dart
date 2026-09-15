import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:neat_nest/screens/home/notifier/notification_state_notifier.dart';
import 'package:neat_nest/screens/home/utilities/notification_screen_holder.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/loading_screen.dart';

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
      final local = notif.createdAt.toLocal();

      final dateOnly = DateTime(local.year, local.month, local.day);

      grouped.putIfAbsent(dateOnly, () => []).add(notif);
    }

    return grouped;
  }

  String friendlyLabelFromKey(DateTime date) {
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);

    final diffDays = today.difference(date).inDays;

    if (diffDays == 0) return 'Today';
    if (diffDays == 1) return 'Yesterday';
    if (diffDays < 7) {
      return DateFormat('EEEE').format(date);
    }

    return DateFormat('dd MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final notificationState = ref.watch(notificationStateProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: primaryText(text: 'Notifications'),
        centerTitle: true,
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
                // Add mark all logic later.
              }

              if (value == "Delete All") {
                // Add delete all logic later.
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
      body: notificationState.when(
        loading: () => LoadingScreen(),
        error: (error, stackTrace) {
          return Center(
            child: secondaryText(
              text: error.toString(),
              color: AppColors.blackTextColor,
            ),
          );
        },
        data: (notifications) {
          if (notifications.isEmpty) {
            return Center(
              child: secondaryText(
                text: 'No notifications yet',
                color: AppColors.blackTextColor,
              ),
            );
          }

          final groupedNotification = groupNotifications(notifications);

          final keys = groupedNotification.keys.toList()
            ..sort((a, b) => b.compareTo(a));

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                20.ht,
                Expanded(
                  child: ListView.builder(
                    itemCount: keys.length,
                    itemBuilder: (context, outerIndex) {
                      final key = keys[outerIndex];

                      final items = groupedNotification[key]!;

                      final label = friendlyLabelFromKey(key);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          primaryText(text: label),
                          20.ht,
                          ListView.builder(
                            itemCount: items.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final notif = items[index];

                              return GestureDetector(
                                onTap: () {
                                  // Mark as read later.
                                },
                                child: NotificationScreenHolder(
                                  title: notif.title,
                                  message: notif.message,
                                  date: notif.createdAt,
                                  isRead: notif.isRead,
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
