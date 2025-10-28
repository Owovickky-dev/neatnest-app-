import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/screens/favorite/widgets/cleaning_data_screen.dart';
import 'package:neat_nest/screens/favorite/widgets/plumbing_data_screen.dart';
import 'package:neat_nest/screens/favorite/widgets/repairing_data_screen.dart';
import 'package:neat_nest/screens/home/widget/all_ads_screen.dart';
import 'package:neat_nest/utilities/constant/extension.dart';

import '../../utilities/bottom_nav/bottom_navigation_screen.dart';
import '../../utilities/bottom_nav/widget/bottom_nav_notifiers.dart';
import '../../utilities/constant/colors.dart';
import '../../widget/app_text.dart';
import '../history/utilities/app_bar_icon.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
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
        title: primaryText(text: 'Favorite'),
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
                  'All',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FittedBox(
                  child: Text(
                    'Cleaning',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FittedBox(
                  child: Text(
                    'Repairing',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FittedBox(
                  child: Text(
                    'Plumbing',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            30.ht,
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: [
                  AllAdsScreen(yesBackButton: false),
                  CleaningDataScreen(),
                  RepairingDataScreen(),
                  PlumbingDataScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
