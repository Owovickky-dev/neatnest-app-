import 'package:flutter/material.dart';
import 'package:neat_nest/utilities/constant/colors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: Colors.transparent,
        child: Center(
          child: SizedBox(
            height: 80,
            width: 80,
            child: FittedBox(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: AppColors.primaryColor,
                strokeWidth: 6,
              ),
            ),
          ), // spinner
        ),
      ),
    );
  }
}
