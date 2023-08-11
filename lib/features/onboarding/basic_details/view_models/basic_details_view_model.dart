import 'dart:developer';

import 'package:auth_module/core/utlis/failure.dart';
import 'package:auth_module/core/utlis/mixins/notifier_mixin.dart';

import '../models/user_info_model.dart';
import '../services/basic_details_service.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';

class BasicDetailViewModel extends ChangeNotifierState {
  final _basicDetailService = BasicDetailsService();

  // bool _isLoading = false;
  // bool get isLoading => _isLoading;

  // void setLoading(bool value) {
  //   _isLoading = value;
  //   notifyListeners();
  // }

  // String? _error;
  // String? get error => _error;

  String? _emailError;
  String? get emailError => _emailError;
  set setEmailError(String? value) => _emailError = value;

  String? _usernameError;
  String? get usernameError => _usernameError;
  set setUsernameError(String? value) => _usernameError = value;

  bool _isFirstNameValid = false;
  bool get isFirstNameValid => _isFirstNameValid;

  bool _isEmailValid = false;
  bool get isEmailValid => _isEmailValid;

  bool _isUsernameValid = false;
  bool get isUsernameValid => _isUsernameValid;

  // void setError(String? error) {
  //   _error = error;
  //   notifyListeners();
  // }

  Result userInfoModel = Result.empty();

  void onFirstNameChange(String value) {
    if (value.length <= 12) {
      _isFirstNameValid = true;
      log('Valid FirstName!!!!!');
    } else {
      _isFirstNameValid = false;
    }
    final updatedUserInfoModel = userInfoModel.copyWith(firstname: value);
    userInfoModel = updatedUserInfoModel;
    notifyListeners();
  }

  void onLastNameChange(String value) {
    final updatedUserInfoModel = userInfoModel.copyWith(lastname: value);
    userInfoModel = updatedUserInfoModel;
    notifyListeners();
  }

  void onUserEmailChange(String value) {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      _isEmailValid = true;
      log('Valid Email!!!!!');
    } else {
      _isEmailValid = false;
    }
    final updatedUserInfoModel = userInfoModel.copyWith(email: value);
    userInfoModel = updatedUserInfoModel;
    notifyListeners();
  }

  void onUserNameChange(String value) {
    if (value.length > 3) {
      _isUsernameValid = true;
      log('Valid Username!!!!!');
    } else {
      _isUsernameValid = false;
    }
    final updatedUserInfoModel = userInfoModel.copyWith(userName: value);
    userInfoModel = updatedUserInfoModel;
    notifyListeners();
  }

  void submitUserData() async {
    // setError(null);
    setState(AppState.initial);
    setEmailError = null;
    setUsernameError = null;

    if (userInfoModel.firstname.length > 12) {
      // setError('First Name should not be greate than 12.');
      setState(
        AppState.error,
        Failure('First Name should not be greate than 12.'),
      );
      return;
    }

    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(userInfoModel.email)) {
      // setError('Email Id not valid');
      setState(
        AppState.error,
        Failure('Email Id not valid'),
      );
      return;
    }

    debugPrint(userInfoModel.toJson().toString());
    // setLoading(true);
    setState(AppState.loading);

    final result = await _basicDetailService.storeBasicDetails(userInfoModel);

    result.fold((err) {
      // setLoading(false);

      debugPrint(err);
      // Fluttertoast.showToast(msg: err);
      // setError(err);
      setState(AppState.error, Failure(err));
    }, (userInfo) {
      // setLoading(false);
      setState(AppState.initial);
      if (!userInfo.emailValidStatus) {
        setEmailError = 'email is already in use';
        notifyListeners();
        return;
      }
      if (!userInfo.usernameValidStatus) {
        setUsernameError = 'username is already in use';
        notifyListeners();
        return;
      }

      if (userInfo.success) {
        navigatorKey.currentState?.push(MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Sample Home Page'),
            ),
          ),
        ));
      }
    });
  }
}
