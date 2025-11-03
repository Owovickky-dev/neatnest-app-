class VerificationStateModel {
  final int idState;
  final int addressState;
  final int selfieState;

  VerificationStateModel({
    required this.addressState,
    required this.selfieState,
    required this.idState,
  });

  VerificationStateModel copyWith({
    int? idState,
    int? addressState,
    int? selfieState,
  }) {
    return VerificationStateModel(
      addressState: addressState ?? this.addressState,
      selfieState: selfieState ?? this.selfieState,
      idState: idState ?? this.idState,
    );
  }
}
