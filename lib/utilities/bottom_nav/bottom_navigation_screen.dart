import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/data/storage/secure_storage_helper.dart';
import 'package:neat_nest/providers/is_logged_in_state.dart';
import 'package:neat_nest/screens/favorite/favorite_screen.dart';
import 'package:neat_nest/screens/history/history_screen.dart';
import 'package:neat_nest/screens/home/home_screen.dart';
import 'package:neat_nest/screens/message/messages_list_screen.dart';
import 'package:neat_nest/screens/user/user_screen.dart';
import 'package:neat_nest/utilities/bottom_nav/widget/bottom_nav_notifiers.dart';
import 'package:neat_nest/utilities/constant/colors.dart';

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
    return [
      HomeScreen(),
      HistoryScreen(),
      FavoriteScreen(),
      MessagesScreen(),
      UserScreen(isDataAvailable: isLoggedIn),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final index = ref.watch(bottomNavNotifiersProvider);
    final isLoggedIn = ref.watch(isLoggedInStateProvider);

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
            icon: Icon(Icons.history_outlined),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_rounded),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Message'),
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
