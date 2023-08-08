import 'dart:convert';

class OTPResponseModel {
  final bool success;
  final String message;
  final String? error;
  final OTPResultModel? result;
  OTPResponseModel({
    required this.success,
    required this.message,
    this.error,
    this.result,
  });

  factory OTPResponseModel.fromMap(Map<String, dynamic> map) {
    return OTPResponseModel(
      success: map['success'] as bool,
      message: map['message'] as String,
      error: map['error'] != null ? map['error'] as String : null,
      result: map['result'] != null
          ? OTPResultModel.fromMap(map['result'][0] as Map<String, dynamic>)
          : null,
    );
  }

  factory OTPResponseModel.fromJson(String source) =>
      OTPResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class OTPResultModel {
  final String transactionId;
  final String expiryTime;
  OTPResultModel({
    required this.transactionId,
    required this.expiryTime,
  });

  factory OTPResultModel.fromMap(Map<String, dynamic> map) {
    return OTPResultModel(
      transactionId: map['transactionId'] as String,
      expiryTime: map['expiryTime'] as String,
    );
  }

  factory OTPResultModel.fromJson(String source) =>
      OTPResultModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
