import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/screens/history/widget%20/electronic_reciept_screen.dart';
import 'package:neat_nest/utilities/app_data.dart';

import '../utilities/data_screen.dart';

class OngoingHistory extends StatefulWidget {
  const OngoingHistory({super.key});

  @override
  State<OngoingHistory> createState() => _OngoingHistoryState();
}

class _OngoingHistoryState extends State<OngoingHistory> {
  // @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      child: ListView.builder(
        itemCount: AppData.imagePathway.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return DataScreen(
            event: "",
            bookingStatus: "",
            leftButtonText: 'Cancel',
            rightButtonText: 'E-Receipt',
            serviceName: AppData.serviceName[index],
            serviceProvider: AppData.serviceProviderName[index],
            imagePath: AppData.imagePathway[index],
            price: AppData.price[index],
            preferredDate: "",
            functionLeft: () {
              debugPrint('The Cancel text is clicked of index: $index');
            },
            functionRight: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ElectronicReceiptScreen(index: index),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
