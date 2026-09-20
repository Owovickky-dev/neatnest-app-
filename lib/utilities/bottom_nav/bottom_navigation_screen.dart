import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/state%20controller%20/message/unread_message_tracking.dart';
import 'package:neat_nest/data/storage/secure_storage_helper.dart';
import 'package:neat_nest/providers/is_logged_in_state.dart';
import 'package:neat_nest/screens/favorite/favorite_screen.dart';
import 'package:neat_nest/screens/home/home_screen.dart';
import 'package:neat_nest/screens/user/user_screen.dart';
import 'package:neat_nest/utilities/bottom_nav/widget/bottom_nav_notifiers.dart';
import 'package:neat_nest/utilities/constant/colors.dart';

import '../../screens/message/chat_list_screen.dart';

class BottomNavigationScreen extends ConsumerStatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  ConsumerState<BottomNavigationScreen> createState() =>
      _BottomNavigationScreenState();
}

class _BottomNavigationScreenState
    extends ConsumerState<BottomNavigationScreen> {
  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final hasData = await SecureStorageHelper.isDataStored();
    ref.read(isLoggedInStateProvider.notifier).yesLogged(hasData);
  }

  List<Widget> _buildScreens(bool isLoggedIn) {
    return [HomeScreen(), FavoriteScreen(), ChatListScreen(), UserScreen()];
  }

  @override
  Widget build(BuildContext context) {
    final index = ref.watch(bottomNavNotifiersProvider);
    final isLoggedIn = ref.watch(isLoggedInStateProvider);
    final unreadMessageCount = ref.watch(unreadMessageTrackingProvider);

    final screens = _buildScreens(isLoggedIn);
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: index,
        elevation: 0,
        selectedIconTheme: IconThemeData(size: 27.sp),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryColor,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_rounded),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(Icons.message),

                if (unreadMessageCount > 0)
                  Positioned(
                    right: -8.w,
                    top: -8.h,
                    child: Container(
                      constraints: BoxConstraints(
                        minWidth: 18.w,
                        minHeight: 18.h,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        unreadMessageCount > 99
                            ? '99+'
                            : unreadMessageCount.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: 'User',
          ),
        ],
        onTap: (val) {
          ref.read(bottomNavNotifiersProvider.notifier).indexUpdate(val);
        },
      ),
    );
  }
}
