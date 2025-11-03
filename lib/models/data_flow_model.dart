class DataflowModel {
  final int identityVerifyIndex;
  final int methodVerifyIndex;
  final String verificationStatus;

  DataflowModel({
    required this.identityVerifyIndex,
    required this.methodVerifyIndex,
    this.verificationStatus = "Not-started",
  });

  DataflowModel copyWith({
    int? identityVerifyIndex,
    int? methodVerifyIndex,
    String? verificationStatus,
  }) {
    return DataflowModel(
      identityVerifyIndex: identityVerifyIndex ?? this.identityVerifyIndex,
      methodVerifyIndex: methodVerifyIndex ?? this.methodVerifyIndex,
      verificationStatus: verificationStatus ?? this.verificationStatus,
    );
  }
}
