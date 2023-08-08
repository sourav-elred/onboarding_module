class VerifyOTPResponseModel {
  final bool success;
  final String message;
  final String? error;
  final VerifyOTPResponseResult? result;
  VerifyOTPResponseModel({
    required this.success,
    required this.message,
    this.error,
    this.result,
  });

  factory VerifyOTPResponseModel.fromMap(Map<String, dynamic> map) {
    return VerifyOTPResponseModel(
      success: map['success'] as bool,
      message: map['message'] as String,
      error: map['error'] != null ? map['error'] as String : null,
      result: map['result'] != null
          ? VerifyOTPResponseResult.fromMap(
              map['result'][0] as Map<String, dynamic>)
          : null,
    );
  }
}

class VerifyOTPResponseResult {
  final String uid;
  VerifyOTPResponseResult({
    required this.uid,
  });

  VerifyOTPResponseResult copyWith({
    String? uid,
  }) {
    return VerifyOTPResponseResult(
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
    };
  }

  factory VerifyOTPResponseResult.fromMap(Map<String, dynamic> map) {
    return VerifyOTPResponseResult(
      uid: map['uid'] as String,
    );
  }
}
