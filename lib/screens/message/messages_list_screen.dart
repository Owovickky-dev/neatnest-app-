import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/screens/message/widget/message_list_data_holder.dart';
import 'package:neat_nest/utilities/constant/extension.dart';

import '../../utilities/bottom_nav/bottom_navigation_screen.dart';
import '../../utilities/bottom_nav/widget/bottom_nav_notifiers.dart';
import '../../widget/app_text.dart';
import '../../widget/app_text_field.dart';
import '../history/utilities/app_bar_icon.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

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
          children: [
            20.ht,
            AppTextField(hintText: 'Search...', iconPrefix: Icons.search),
            20.ht,
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return MessageDataHolder(index: index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
