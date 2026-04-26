import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  void _initializeApp() async {
    _timer = Timer(Duration(milliseconds: 1500), () {
      AppNavigatorHelper.go(context, AppRoute.welcome);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Neat',
              style: TextStyle(color: AppColors.blackTextColor, fontSize: 22),
            ),
            Text(
              'Nest',
              style: TextStyle(color: AppColors.primaryColor, fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
