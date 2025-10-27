class WorkerStatisticsModel {
  final double totalEarning;
  final double availableBalance;
  final double totalJobCompleted;
  final double totalJobRejected;
  final double pendingOrder;
  final double totalOrders;
  final double completionRating;

  WorkerStatisticsModel({
    required this.availableBalance,
    required this.completionRating,
    required this.pendingOrder,
    required this.totalEarning,
    required this.totalJobCompleted,
    required this.totalJobRejected,
    required this.totalOrders,
  });

  factory WorkerStatisticsModel.fromJson(Map<String, dynamic> json) {
    return WorkerStatisticsModel(
      availableBalance: (json["availableBalance"] as num?)?.toDouble() ?? 0.0,
      completionRating: (json["completionRating"] as num?)?.toDouble() ?? 0.0,
      pendingOrder: (json["pendingOrder"] as num?)?.toDouble() ?? 0.0,
      totalEarning: (json["totalEarning"] as num?)?.toDouble() ?? 0.0,
      totalJobCompleted: (json["totalJobCompleted"] as num?)?.toDouble() ?? 0.0,
      totalJobRejected: (json["totalJobRejected"] as num?)?.toDouble() ?? 0.0,
      totalOrders: (json["totalOrders"] as num?)?.toDouble() ?? 0.0,
    );
  }
}
