import 'dart:convert';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../models/login_response.dart';
import '../models/otp_response_model.dart';
import '../models/verify_otp_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class SignUpService {
  final _dioClient = DioClient.instance;
  Future<Either<String, OTPResponseModel>> sendOtp(
      {required String phoneNumber}) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoint.generatePhoneOtpApi,
        body: {
          'phoneNumber': phoneNumber,
          'hashId': 'elRed',
        },
      );
      final parsedResponse = OTPResponseModel.fromMap(response.data);
      if (parsedResponse.success) {
        return right(parsedResponse);
      }
      return left(parsedResponse.message);
    } catch (e) {
      debugPrint(e.toString());
      return left(e.toString());
    }
  }

  Future<Either<String, VerifyOTPResponseModel>> verifyOTP(
      {required String otp, required String transactionID}) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoint.verifyPhoneGeneratedApi,
        body: {
          'transactionId': transactionID,
          'providedOTP': otp,
        },
      );
      final parsedResponse = VerifyOTPResponseModel.fromMap(response.data);
      if (parsedResponse.success) {
        return right(parsedResponse);
      }
      return left(parsedResponse.error.toString());
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<ApiResponse> verifyUser({required String uid}) async {
    ApiResponse? loginResponse;
    try {
      final response = await _dioClient.post(
        ApiEndpoint.verifyUser,
        body: {'uid': uid},
      );
      debugPrint(response.data.toString());
      final parsedResponse =
          verifyUserResponseFromJson(json.encode(response.data));

      if (parsedResponse.success) {
        loginResponse = ApiResponse(response: parsedResponse);
      } else {
        loginResponse =
            ApiResponse(isError: true, errorMessage: parsedResponse.message);
      }
    } catch (error) {
      loginResponse =
          ApiResponse(isError: true, errorMessage: error.toString());
    }
    return loginResponse;
  }
}
