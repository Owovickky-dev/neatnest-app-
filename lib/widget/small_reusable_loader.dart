import 'package:flutter/material.dart';
import 'package:neat_nest/utilities/constant/colors.dart';

class SmallLoader extends StatelessWidget {
  final double size;

  const SmallLoader({super.key, this.size = 25});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: const CircularProgressIndicator(
          strokeWidth: 2,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
