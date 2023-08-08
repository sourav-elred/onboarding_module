import 'dart:developer';

import '../../../../core/shared_preferences/shared_prefs_client.dart';
import '../models/verify_otp_response_model.dart';
import '../services/sign_up_service.dart';
import '../../../../main.dart';
import '../../../../routes/routes_constants.dart';
import 'package:flutter/material.dart';

class SignUpViewModel extends ChangeNotifier {
  final SignUpService _signUpService = SignUpService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

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

  void generateOTP() async {
    setLoading(true);

    final result = await _signUpService.sendOtp(phoneNumber: _phoneNumber);

    result.fold((err) {
      setLoading(false);
      notifyListeners();
    }, (response) {
      if (response.success) {
        _transactionID = response.result?.transactionId ?? '';
        setLoading(false);
        notifyListeners();
        navigatorKey.currentState?.pushNamed(RouteConstansts.otpScreen);
      }
    });
  }

  void verifyOTP() async {
    setLoading(true);

    final result = await _signUpService.verifyOTP(
      otp: _otp,
      transactionID: _transactionID,
    );

    result.fold(
      (err) {
        setLoading(false);
        notifyListeners();
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
        builder: (context) => const Scaffold(
          body: Center(
            child: Text('Sample Home Page'),
          ),
        ),
      ));
    } else {
      await SharedPrefsClient()
          .setAccessToken(response.response!.result.first.accessToken!);
      await SharedPrefsClient().setUserCode(response.response!.userCode!);
      setLoading(false);
      notifyListeners();
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        RouteConstansts.basicDetails,
        (route) => false,
      );
    }
  }
}
