import 'package:barcode_widget/barcode_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/screens/history/utilities/text_holder.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';

import '../../../utilities/app_data.dart';
import '../../../widget/app_text.dart';
import '../utilities/app_bar_icon.dart';

class ElectronicReceiptScreen extends StatelessWidget {
  const ElectronicReceiptScreen({super.key, required this.index});

  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: primaryText(text: 'E-Receipt'),
          leading: AppBarIcon(
            icons: Icons.arrow_back,
            function: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            25.ht,
            DottedBorder(
              options: RoundedRectDottedBorderOptions(
                color: AppColors.secondaryTextColor.withValues(alpha: .5),
                strokeWidth: 2,
                dashPattern: [5, 5],
                radius: Radius.circular(8.r),
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                width: double.maxFinite,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      20.ht,
                      BarcodeWidget(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
                        data: AppData.serviceName[index],
                        drawText: false,
                        barcode: Barcode.code128(),
                        width: double.maxFinite,
                        height: 50.h,
                      ),
                      20.ht,
                      DottedLine(
                        dashColor: AppColors.secondaryTextColor.withOpacity(
                          0.5,
                        ),
                      ),
                      20.ht,
                      Column(
                        children: [
                          textHolder(
                            titleText: 'Service Name',
                            text: AppData.serviceName[index],
                          ),
                          15.ht,
                          textHolder(
                            titleText: 'Service Provider',
                            text: AppData.serviceProviderName[index],
                          ),
                          15.ht,
                          textHolder(
                            titleText: 'Booking Date',
                            text: '18/04/2025',
                          ),
                          15.ht,
                          textHolder(
                            titleText: 'Booking time',
                            text: '09:00-12:00',
                          ),
                          15.ht,
                          textHolder(titleText: 'Total Room', text: '07'),
                        ],
                      ),
                      20.ht,
                      DottedLine(
                        dashColor: AppColors.secondaryTextColor.withOpacity(
                          0.5,
                        ),
                      ),
                      20.ht,
                      Column(
                        children: [
                          textHolder(
                            titleText: 'Amount',
                            text: '\$${AppData.price[index]}',
                          ),
                          20.ht,
                          textHolder(titleText: 'Tax & Fee', text: '1.25'),
                          20.ht,
                          textHolder(
                            titleText: 'Total Amount',
                            text: '\$${AppData.price[index] + 1.25}',
                          ),
                          20.ht,
                          textHolderPayment(
                            titleText: 'Payment Method',
                            text: 'cash',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            30.ht,
            AppButton(
              text: 'Download',
              bckColor: AppColors.primaryColor,
              textColor: Colors.white,
              function: () {
                debugPrint("The Download button is clicked");
              },
              width: double.maxFinite,
              verticalHeight: 15,
              fontSize: 20,
            ),
          ],
        ),
      ),
    );
  }
}
