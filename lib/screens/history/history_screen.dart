import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/screens/history/utilities/app_bar_icon.dart';
import 'package:neat_nest/screens/history/widget%20/cancelled_history_screen.dart';
import 'package:neat_nest/screens/history/widget%20/completed_history.dart';
import 'package:neat_nest/screens/history/widget%20/ongoing_history.dart';
import 'package:neat_nest/utilities/bottom_nav/bottom_navigation_screen.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_text.dart';

import '../../utilities/bottom_nav/widget/bottom_nav_notifiers.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: primaryText(text: 'MY Booking'),
        leading: Consumer(
          builder: (context, ref, _) {
            return AppBarIcon(
              icons: Icons.arrow_back,
              function: () {
                ref.read(bottomNavNotifiersProvider.notifier).indexUpdate(0);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNavigationScreen(),
                  ),
                );
              },
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.ht,
            TabBar(
              controller: _controller,
              labelColor: AppColors.primaryColor,
              unselectedLabelColor: AppColors.secondaryTextColor,
              labelStyle: TextStyle(fontWeight: FontWeight.w500),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 2.0,
                  color: AppColors.primaryColor,
                ),
                insets: EdgeInsets.symmetric(horizontal: -20, vertical: 0),
              ),
              tabs: [
                Text(
                  'Ongoing',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Completed',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Cancelled',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            30.ht,
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: [
                  OngoingHistory(),
                  CompletedHistory(),
                  CancelledHistoryScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
