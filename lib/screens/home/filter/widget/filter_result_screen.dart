import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/utilities/app_data.dart';

import '../../../../widget/app_text.dart';
import '../../../favorite/utilities/favourite_data_holder.dart';
import '../../../history/utilities/app_bar_icon.dart';

class FilterResultScreen extends StatelessWidget {
  const FilterResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: primaryText(text: 'Filter Result'),
        leading: AppBarIcon(
          icons: Icons.arrow_back,
          function: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: AppData.popularImagesPath.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.6,
                ),
                itemBuilder: (context, index) {
                  return FavouriteDataHolder(index: index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
