// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// import '../../../controller/booking_form_controller.dart';
// import '../../../utilities/constant/extension.dart';
// import '../../../utilities/route/app_naviation_helper.dart';
// import '../../../utilities/route/app_route_names.dart';
// import '../../user/model/booking_data_model.dart';
// import '../../user/widgets/row_data_holder.dart';
//
// class GroupBookingData extends ConsumerStatefulWidget {
//   const GroupBookingData({super.key});
//
//   @override
//   ConsumerState<GroupBookingData> createState() => _GroupBookingDataState();
// }
//
// class _GroupBookingDataState extends ConsumerState<GroupBookingData> {
//   final BookingFormController bookingFormController = BookingFormController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         RowDataHolder(
//           text: "Completed",
//           icons: FontAwesomeIcons.checkDouble,
//           function: () {
//             final buttonConfig = AllBookingStaus.completed.buttonConfig;
//             AppNavigatorHelper.push(
//               context,
//               AppRoute.bookingDataBuilder,
//               extra: BookingDataModel(
//                 leftText: buttonConfig.leftText,
//                 rightText: buttonConfig.rightText,
//                 topText: "Completed Orders",
//                 title: "Completed Booking",
//                 status: BookingStatus.completed,
//                 functionLeft: (bookingId, bookingStatus) {
//                   print("Leaving review for Booking number $bookingId");
//                 },
//                 functionRight: (bookingId, bookingStatus) {
//                   print("printing Ticket for  $bookingId");
//                 },
//               ),
//             );
//           },
//         ),
//         30.ht,
//         RowDataHolder(
//           text: "Active Orders",
//           icons: FontAwesomeIcons.hourglassHalf,
//           function: () {
//             AppNavigatorHelper.push(
//               context,
//               AppRoute.bookingDataBuilder,
//               extra: BookingDataModel(
//                 leftText: "Terminate",
//                 rightText: "E-Receipt",
//                 topText: "Active Order",
//                 title: "Active Order",
//                 status: BookingStatus.active,
//                 functionLeft: (bookingId, bookingStatus) async {
//                   bookingFormController.bookingStatus = "completed";
//                   await bookingFormController.updateBooking(
//                     ref,
//                     bookingId,
//                     context,
//                   );
//                   print("The Booking ID of this left clicked is $bookingId");
//                   print("The booking status of  $bookingId is $bookingStatus");
//                 },
//                 functionRight: (bookingId, bookingStatus) {
//                   print("The Booking ID of this right clicked is $bookingId");
//                 },
//               ),
//             );
//           },
//         ),
//         30.ht,
//         RowDataHolder(
//           text: "Awaiting Action",
//           icons: FontAwesomeIcons.spinner,
//           function: () {
//             AppNavigatorHelper.push(
//               context,
//               AppRoute.bookingDataBuilder,
//               extra: BookingDataModel(
//                 leftText: "Accept",
//                 rightText: "Reject",
//                 topText: "Awaiting your  Confirmation",
//                 title: "Awaiting Action",
//                 status: BookingStatus.awaitingAction,
//                 functionLeft: (bookingId, bookingStatus) async {
//                   bookingFormController.bookingStatus = "negotiation";
//                   await bookingFormController.updateBooking(
//                     ref,
//                     bookingId,
//                     context,
//                   );
//                   print("The Booking ID of this left clicked is $bookingId");
//                 },
//                 functionRight: (bookingId, bookingStatus) {
//                   print("The Booking ID of this right clicked is $bookingId");
//                 },
//               ),
//             );
//           },
//         ),
//         30.ht,
//         RowDataHolder(
//           text: "Closed",
//           icons: FontAwesomeIcons.circleMinus,
//           function: () {
//             AppNavigatorHelper.push(
//               context,
//               AppRoute.bookingDataBuilder,
//               extra: BookingDataModel(
//                 leftText: "Cancel",
//                 rightText: "E-Receipt",
//                 topText: "Closed Orders",
//                 title: "Closed Booking",
//                 status: BookingStatus.closed,
//                 functionLeft: (bookingId, bookingStatus) {
//                   print("The Booking ID of this left clicked is $bookingId");
//                 },
//                 functionRight: (bookingId, bookingStatus) {
//                   print("The Booking ID of this right clicked is $bookingId");
//                 },
//               ),
//             );
//           },
//         ),
//         30.ht,
//         RowDataHolder(
//           text: "Disputed Booking",
//           icons: FontAwesomeIcons.handshakeSlash,
//           function: () {
//             AppNavigatorHelper.push(
//               context,
//               AppRoute.bookingDataBuilder,
//               extra: BookingDataModel(
//                 leftText: "Cancel",
//                 rightText: "E-Receipt",
//                 topText: "Dispued Orders",
//                 title: "Disputed Booking",
//                 status: BookingStatus.disputed,
//                 functionLeft: (bookingId, bookingStatus) {
//                   print("The Booking ID of this left clicked is $bookingId");
//                 },
//                 functionRight: (bookingId, bookingStatus) {
//                   print("The Booking ID of this right clicked is $bookingId");
//                 },
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
//
// enum AllBookingStaus {
//   awaiting_provider_confirmation,
//   negotiation,
//   awaiting_user_payment,
//   payment_confirmed,
//   ongoing,
//   awaiting_user_completion,
//   completed,
//   cancelled,
//   rejected,
//   expired,
//   disputed,
// }
//
// class BookingButtonConfig {
//   final String leftText;
//   final String rightText;
//
//   BookingButtonConfig({required this.leftText, required this.rightText});
// }
//
// extension BookingStatusButtonExtension on AllBookingStaus {
//   BookingButtonConfig get buttonConfig {
//     switch (this) {
//       case AllBookingStaus.awaiting_provider_confirmation:
//         return BookingButtonConfig(leftText: "Accept", rightText: "Reject");
//
//       case AllBookingStaus.negotiation:
//         return BookingButtonConfig(
//           leftText: "Counter Offer",
//
//           rightText: "Cancel",
//         );
//
//       case AllBookingStaus.awaiting_user_payment:
//         return BookingButtonConfig(leftText: "Remind", rightText: "Cancel");
//
//       case AllBookingStaus.payment_confirmed:
//         return BookingButtonConfig(leftText: "Start Job", rightText: "Receipt");
//
//       case AllBookingStaus.ongoing:
//         return BookingButtonConfig(leftText: "Mark Done", rightText: "Receipt");
//
//       case AllBookingStaus.awaiting_user_completion:
//         return BookingButtonConfig(
//           leftText: "Remind User",
//           rightText: "Receipt",
//         );
//
//       case AllBookingStaus.completed:
//         return BookingButtonConfig(
//           leftText: "Leave Review",
//           rightText: "E-Receipt",
//         );
//
//       case AllBookingStaus.cancelled:
//         return BookingButtonConfig(leftText: "Delete", rightText: "Receipt");
//
//       case AllBookingStaus.rejected:
//         return BookingButtonConfig(leftText: "Remove", rightText: "Receipt");
//
//       case AllBookingStaus.expired:
//         return BookingButtonConfig(leftText: "Rebook", rightText: "Delete");
//
//       case AllBookingStaus.disputed:
//         return BookingButtonConfig(leftText: "Resolve", rightText: "Evidence");
//     }
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../controller/booking_form_controller.dart';
import '../../../utilities/constant/extension.dart';
import '../../../utilities/route/app_naviation_helper.dart';
import '../../../utilities/route/app_route_names.dart';
import '../../user/model/booking_data_model.dart';
import '../../user/widgets/row_data_holder.dart';

class GroupBookingData extends ConsumerStatefulWidget {
  const GroupBookingData({super.key});

  @override
  ConsumerState<GroupBookingData> createState() => _GroupBookingDataState();
}

class _GroupBookingDataState extends ConsumerState<GroupBookingData> {
  final BookingFormController bookingFormController = BookingFormController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RowDataHolder(
          text: "Completed",
          icons: FontAwesomeIcons.checkDouble,
          function: () {
            AppNavigatorHelper.push(
              context,
              AppRoute.bookingDataBuilder,
              extra: BookingDataModel(
                topText: "Completed Orders",
                title: "Completed Booking",
                status: BookingStatus.completed,
                functionLeft: (bookingId, bookingStatus, userRole) {
                  /// bookingStatus coming from backend
                  final buttonConfig =
                      bookingStatus.toBookingStatus.buttonConfig;

                  print("Leaving review for Booking number $bookingId");
                },

                functionRight: (bookingId, bookingStatus, userRole) {
                  final buttonConfig =
                      bookingStatus.toBookingStatus.buttonConfig;

                  print("Printing Ticket for $bookingId");
                },
              ),
            );
          },
        ),
        30.ht,
        RowDataHolder(
          text: "Active Orders",
          icons: FontAwesomeIcons.hourglassHalf,
          function: () {
            AppNavigatorHelper.push(
              context,
              AppRoute.bookingDataBuilder,
              extra: BookingDataModel(
                topText: "Active Order",
                title: "Active Order",
                status: BookingStatus.active,
                functionLeft: (bookingId, bookingStatus, userRole) async {
                  final currentStatus = bookingStatus.toBookingStatus;
                  final provider = userRole == "provider";
                  final customer = userRole == "customer";
                  Future<void> execute() async {
                    await bookingFormController.updateBooking(
                      ref,
                      bookingId,
                      context,
                    );
                  }

                  if (currentStatus == AllBookingStaus.ongoing &&
                      provider == true) {
                    setState(() {
                      bookingFormController.bookingStatus =
                          "awaiting_user_completion";
                    });
                    await execute();
                    return;
                  }
                  if (currentStatus ==
                          AllBookingStaus.awaiting_user_completion &&
                      customer == true) {
                    setState(() {
                      bookingFormController.bookingStatus = "completed";
                    });
                    await execute();
                    return;
                  }
                },

                functionRight: (bookingId, bookingStatus, userRole) async {
                  final currentStatus = bookingStatus.toBookingStatus;
                  final provider = userRole == "provider";
                  final customer = userRole == "customer";
                  Future<void> execute() async {
                    await bookingFormController.updateBooking(
                      ref,
                      bookingId,
                      context,
                    );
                  }

                  if (currentStatus == AllBookingStaus.ongoing &&
                      provider == true) {
                    setState(() {
                      bookingFormController.bookingStatus = "disputed";
                    });
                    await execute();
                    return;
                  }
                  if (currentStatus ==
                          AllBookingStaus.awaiting_user_completion &&
                      customer == true) {
                    setState(() {
                      bookingFormController.bookingStatus = "disputed";
                    });
                    await execute();
                    return;
                  }
                },
              ),
            );
          },
        ),
        30.ht,
        RowDataHolder(
          text: "Awaiting Action",
          icons: FontAwesomeIcons.spinner,
          function: () {
            AppNavigatorHelper.push(
              context,
              AppRoute.bookingDataBuilder,
              extra: BookingDataModel(
                topText: "Awaiting your Confirmation",
                title: "Awaiting Action",
                status: BookingStatus.awaitingAction,
                functionLeft: (bookingId, bookingStatus, userRole) async {
                  final currentStatus = bookingStatus.toBookingStatus;
                  if (currentStatus ==
                      AllBookingStaus.awaiting_provider_confirmation) {
                    setState(() {
                      bookingFormController.bookingStatus = "negotiation";
                    });
                  }

                  if (currentStatus == AllBookingStaus.negotiation) {
                    setState(() {
                      bookingFormController.bookingStatus =
                          "awaiting_user_payment";
                    });
                  }

                  if (currentStatus == AllBookingStaus.ongoing) {
                    setState(() {
                      bookingFormController.bookingStatus =
                          "awaiting_user_completion";
                    });
                  }
                  await bookingFormController.updateBooking(
                    ref,
                    bookingId,
                    context,
                  );
                },

                functionRight: (bookingId, bookingStatus, userRole) async {
                  final currentStatus = bookingStatus.toBookingStatus;

                  if (currentStatus == AllBookingStaus.awaiting_user_payment) {
                    setState(() {
                      bookingFormController.bookingStatus = "rejected";
                    });
                  }
                  await bookingFormController.updateBooking(
                    ref,
                    bookingId,
                    context,
                  );
                },
              ),
            );
          },
        ),
        30.ht,
        RowDataHolder(
          text: "Closed",
          icons: FontAwesomeIcons.circleMinus,
          function: () {
            AppNavigatorHelper.push(
              context,
              AppRoute.bookingDataBuilder,
              extra: BookingDataModel(
                topText: "Closed Orders",
                title: "Closed Booking",

                status: BookingStatus.closed,

                functionLeft: (bookingId, bookingStatus, userRole) {
                  print("The user role in this booking is $userRole");
                  print("The Booking ID of this left clicked is $bookingId");
                },
              ),
            );
          },
        ),
        30.ht,
        RowDataHolder(
          text: "Disputed Booking",
          icons: FontAwesomeIcons.handshakeSlash,
          function: () {
            AppNavigatorHelper.push(
              context,
              AppRoute.bookingDataBuilder,
              extra: BookingDataModel(
                topText: "Disputed Orders",
                title: "Disputed Booking",
                status: BookingStatus.disputed,
                functionLeft: (bookingId, bookingStatus, userRole) {
                  print("The Booking ID of this left clicked is $bookingId");
                },
                functionRight: (bookingId, bookingStatus, userRole) {
                  print("The Booking ID of this right clicked is $bookingId");
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

enum AllBookingStaus {
  awaiting_provider_confirmation,
  negotiation,
  awaiting_user_payment,
  payment_confirmed,
  ongoing,
  awaiting_user_completion,
  completed,
  cancelled,
  rejected,
  expired,
  disputed,
}

/// BUTTON CONFIG MODEL

class BookingButtonConfig {
  final String leftText;
  final String? rightText;
  BookingButtonConfig({required this.leftText, this.rightText});
}

/// STRING -> ENUM CONVERTER

extension BookingStatusStringExtension on String {
  AllBookingStaus get toBookingStatus {
    return AllBookingStaus.values.firstWhere(
      (element) => element.name == this,
      orElse: () => AllBookingStaus.awaiting_provider_confirmation,
    );
  }
}

/// ENUM -> BUTTON CONFIG

extension BookingStatusButtonExtension on AllBookingStaus {
  BookingButtonConfig buttonConfig(String role) {
    switch (this) {
      case AllBookingStaus.awaiting_provider_confirmation:
        if (role == "provider") {
          return BookingButtonConfig(
            leftText: "Accept Offer",
            rightText: "Reject Offer",
          );
        } else {
          return BookingButtonConfig(
            leftText: "Remind Provider",
            rightText: "Cancel",
          );
        }

      case AllBookingStaus.negotiation:
        if (role == "provider") {
          return BookingButtonConfig(
            leftText: "Send Counter",
            rightText: "Reject",
          );
        } else {
          return BookingButtonConfig(
            leftText: "Accept Offer",
            rightText: "Reject Offer",
          );
        }

      case AllBookingStaus.awaiting_user_payment:
        if (role == "customer") {
          return BookingButtonConfig(leftText: "Pay Now", rightText: "Cancel");
        } else {
          return BookingButtonConfig(leftText: "Remind Payment");
        }

      case AllBookingStaus.payment_confirmed:
        if (role == "provider") {
          return BookingButtonConfig(
            leftText: "Start Job",
            rightText: "Dispute",
          );
        } else {
          return BookingButtonConfig(
            leftText: "Remind Worker",
            rightText: "Dispute",
          );
        }

      case AllBookingStaus.ongoing:
        if (role == "provider") {
          return BookingButtonConfig(
            leftText: "Mark Done",
            rightText: "Dispute",
          );
        } else {
          return BookingButtonConfig(
            leftText: "Track Job",
            rightText: "Dispute",
          );
        }

      case AllBookingStaus.awaiting_user_completion:
        if (role == "customer") {
          return BookingButtonConfig(
            leftText: "Confirm Completion",
            rightText: "Dispute",
          );
        } else {
          return BookingButtonConfig(
            leftText: "Remind User",
            rightText: "Dispute",
          );
        }

      case AllBookingStaus.completed:
        if (role == "customer") {
          return BookingButtonConfig(
            leftText: "Leave Review",
            rightText: "E-Receipt",
          );
        } else {
          return BookingButtonConfig(
            leftText: "View Review",
            rightText: "E-Receipt",
          );
        }

      case AllBookingStaus.cancelled:
      case AllBookingStaus.rejected:
      case AllBookingStaus.expired:
        return BookingButtonConfig(leftText: "View Details");

      case AllBookingStaus.disputed:
        return BookingButtonConfig(
          leftText: "View Details",
          rightText: "Evidence",
        );
    }
  }
}

enum Role { customer, provider }
