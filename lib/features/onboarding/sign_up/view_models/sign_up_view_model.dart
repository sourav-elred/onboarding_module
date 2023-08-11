import 'dart:developer';

import 'package:auth_module/core/utlis/failure.dart';
import 'package:auth_module/core/utlis/mixins/notifier_mixin.dart';

import '../../../../core/shared_preferences/shared_prefs_client.dart';
import '../models/verify_otp_response_model.dart';
import '../services/sign_up_service.dart';
import '../../../../main.dart';
import '../../../../routes/routes_constants.dart';
import 'package:flutter/material.dart';

class SignUpViewModel extends ChangeNotifierState {
  final SignUpService _signUpService = SignUpService();

  String _phoneNumber = '';
  String get phoneNumber => _phoneNumber;
  String _otp = '';
  String get otp => _otp;
  String _transactionID = '';

  void onPhoneNumberChange(String value) {
    if (value.length <= 3) {
      _phoneNumber = '';
    } else {
      _phoneNumber = value;
    }
    notifyListeners();
  }

  void onOTPChange(String value) {
    _otp = value;
    notifyListeners();
  }

  Future<void> generateOTP({bool resentOTP = false}) async {
    setState(AppState.loading);

    final result = await _signUpService.sendOtp(phoneNumber: _phoneNumber);

    result.fold((err) {
      setState(AppState.error, Failure(err));
    }, (response) {
      if (response.success) {
        _transactionID = response.result?.transactionId ?? '';
        setState(AppState.initial);
        if (!resentOTP) {
          navigatorKey.currentState?.pushNamed(RouteConstansts.otpScreen);
        }
      }
    });
  }

  void verifyOTP() async {
    setState(AppState.loading);

    final result = await _signUpService.verifyOTP(
      otp: _otp,
      transactionID: _transactionID,
    );

    result.fold(
      (err) {
        setState(AppState.error, Failure(err));
      },
      (otpReponse) async {
        if (otpReponse.success) {
          await _verifyUserWithUID(otpReponse);
        }
      },
    );
  }

  Future<void> _verifyUserWithUID(VerifyOTPResponseModel otpReponse) async {
    final response = await _signUpService.verifyUser(
      uid: otpReponse.result?.uid ?? '',
    );

    if (response.response!.createdUser! && response.response!.updatedUser!) {
      log('created & updatedd both!!!');
    }
    if (response.response!.createdUser!) {
      navigatorKey.currentState!.push(MaterialPageRoute(
          builder: (context) =>
              const Scaffold(body: Center(child: Text('Sample Home Page')))));
    } else {
      await SharedPrefsClient()
          .setAccessToken(response.response!.result.first.accessToken!);
      await SharedPrefsClient().setUserCode(response.response!.userCode!);
      setState(AppState.initial);
      navigatorKey.currentState?.pushNamed(RouteConstansts.basicDetails);
    }
  }
}
