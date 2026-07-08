// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:neat_nest/screens/booking/notifiers/selected_add_index_state.dart';
// import 'package:neat_nest/screens/booking/utilities/dotted_container.dart';
// import 'package:neat_nest/screens/booking/widgets/add_address_screen.dart';
// import 'package:neat_nest/screens/booking/widgets/payment_method_screen.dart';
// import 'package:neat_nest/utilities/app_button.dart';
// import 'package:neat_nest/utilities/app_data.dart';
// import 'package:neat_nest/utilities/constant/colors.dart';
// import 'package:neat_nest/utilities/constant/extension.dart';
//
// import '../../../widget/app_text.dart';
// import '../../history/utilities/app_bar_icon.dart';
//
// class SelectAddress extends ConsumerWidget {
//   const SelectAddress({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final addresses = ref.watch(addressListStateProvider);
//     return Container(
//       color: Colors.white,
//       padding: EdgeInsets.only(right: 20.w, left: 20.w, bottom: 40.h),
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           title: primaryText(text: "Select Address"),
//           leading: AppBarIcon(
//             icons: Icons.arrow_back_ios,
//             function: () {
//               Navigator.pop(context);
//             },
//           ),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             20.ht,
//             SingleChildScrollView(
//               child: SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.5,
//                 child: ListView.builder(
//                   itemCount: addresses.length,
//                   itemBuilder: (context, index) {
//                     final address = addresses[index];
//                     final selectedAddIndex = ref.watch(
//                       selectedAddIndexStateProvider,
//                     );
//                     return GestureDetector(
//                       onTap: () {
//                         ref
//                             .read(selectedAddIndexStateProvider.notifier)
//                             .indexSelected(index);
//                       },
//                       child: AddAddressScreen(
//                         title: address.title,
//                         subTitle: address.subTitle,
//                         icons: address.icon,
//                         index: index,
//                         selectedIndex: selectedAddIndex,
//                         onChange: (value) {
//                           ref
//                               .read(selectedAddIndexStateProvider.notifier)
//                               .indexSelected(value);
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//             20.ht,
//             DottedContainer(
//               text: "Add new address",
//               function: () {
//                 ref
//                     .read(addressListStateProvider.notifier)
//                     .addAddress(AppData.addList[1]);
//               },
//             ),
//             30.ht,
//             AppButton(
//               text: "Continue",
//               fontSize: 18.sp,
//               width: double.infinity,
//               bckColor: AppColors.primaryColor,
//               textColor: Colors.white,
//               function: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => PaymentMethodScreen(),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
