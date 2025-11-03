// class WorkerStatisticsModel {
//   final double totalEarning;
//   final double availableBalance;
//   final double totalJobCompleted;
//   final double totalJobRejected;
//   final double totalOrders;
//   final double completionRating;
//
//   WorkerStatisticsModel({
//     required this.availableBalance,
//     required this.completionRating,
//     required this.totalEarning,
//     required this.totalJobCompleted,
//     required this.totalJobRejected,
//     required this.totalOrders,
//   });
//
//   factory WorkerStatisticsModel.fromJson(Map<String, dynamic> json) {
//     try {
//       // print("🔍 WorkerStatisticsModel.fromJson() called with: $json");
//
//       return WorkerStatisticsModel(
//         availableBalance: (json["availableBalance"] as num?)?.toDouble() ?? 0.0,
//         completionRating: (json["completionRating"] as num?)?.toDouble() ?? 0.0,
//         totalEarning: (json["totalEarning"] as num?)?.toDouble() ?? 0.0,
//         totalJobCompleted:
//             (json["totalJobCompleted"] as num?)?.toDouble() ?? 0.0,
//         totalJobRejected: (json["totalJobRejected"] as num?)?.toDouble() ?? 0.0,
//         totalOrders: (json["totalOrders"] as num?)?.toDouble() ?? 0.0,
//       );
//     } catch (e, stack) {
//       print("❌ ERROR in WorkerStatisticsModel.fromJson(): $e");
//       print("❌ Stack trace: $stack");
//       print("❌ Problematic JSON: $json");
//       rethrow;
//     }
//   }
//
//   //   @override
//   //   String toString() {
//   //     return '''
//   // WorkerStatisticsModel {
//   //   totalEarning: $totalEarning,
//   //   availableBalance: $availableBalance,
//   //   totalJobCompleted: $totalJobCompleted,
//   //   totalJobRejected: $totalJobRejected,
//   //   totalOrders: $totalOrders,
//   //   completionRating: $completionRating
//   // }
//   // ''';
//   //   }
//   //
//   //   // For detailed debugging
//   //   String toDebugString() {
//   //     return '''
//   // WorkerStatisticsModel DETAILED:
//   //   totalEarning: $totalEarning
//   //   availableBalance: $availableBalance
//   //   totalJobCompleted: $totalJobCompleted
//   //   totalJobRejected: $totalJobRejected
//   //   totalOrders: $totalOrders
//   //   completionRating: $completionRating
//   // ''';
//   //   }
// }

class WorkerStatisticsModel {
  final double totalEarning;
  final double availableBalance;
  final double totalJobCompleted;
  final double totalJobRejected;
  final double pendingOrder;
  final double totalOrders;
  final double completionRating;
  final double satisfaction;

  WorkerStatisticsModel({
    required this.availableBalance,
    required this.completionRating,
    required this.pendingOrder,
    required this.totalEarning,
    required this.totalJobCompleted,
    required this.totalJobRejected,
    required this.totalOrders,
    required this.satisfaction,
  });

  factory WorkerStatisticsModel.fromJson(Map<String, dynamic> json) {
    return WorkerStatisticsModel(
      availableBalance: (json["availableBalance"] as num?)?.toDouble() ?? 0.0,
      completionRating: (json["completionRating"] as num?)?.toDouble() ?? 0.0,
      satisfaction: (json["satisfaction"] as num?)?.toDouble() ?? 0.0,
      pendingOrder: (json["pendingOrder"] as num?)?.toDouble() ?? 0.0,
      totalEarning: (json["totalEarning"] as num?)?.toDouble() ?? 0.0,
      totalJobCompleted: (json["totalJobCompleted"] as num?)?.toDouble() ?? 0.0,
      totalJobRejected: (json["totalJobRejected"] as num?)?.toDouble() ?? 0.0,
      totalOrders: (json["totalOrders"] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "totalEarning": totalEarning,
      "availableBalance": availableBalance,
      "totalJobCompleted": totalJobCompleted,
      "totalJobRejected": totalJobRejected,
      "pendingOrder": pendingOrder,
      "totalOrders": totalOrders,
      "completionRating": completionRating,
      "satisfaction": satisfaction,
    };
  }
}
