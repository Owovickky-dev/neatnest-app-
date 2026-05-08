import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/screens/history/utilities/review_screen.dart';
import 'package:neat_nest/utilities/app_data.dart';

import '../utilities/data_screen.dart';

class CompletedHistory extends StatelessWidget {
  const CompletedHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      child: ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return DataScreen(
            preferredDate: "",
            text1: 'Leave Review',
            text2: 'Re-Book',
            serviceName: AppData.serviceName[index],
            serviceProvider: AppData.serviceProviderName[index],
            imagePath: AppData.imagePathway[index],
            price: AppData.price[index],
            functionLeft: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReviewScreen(index: index),
                ),
              );
            },
            functionRight: () {
              debugPrint(
                "Are you sure you want to re-book for this ${AppData.serviceName[index]}",
              );
            },
          );
        },
      ),
    );
  }
}
