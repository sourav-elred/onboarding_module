import '../models/user_info_model.dart';
import '../services/basic_details_service.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BasicDetailViewModel extends ChangeNotifier {
  final _basicDetailService = BasicDetailsService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  UserInfoModel _userInfoModel = UserInfoModel.empty();

  void onFirstNameChange(String value) {
    final updatedUserInfoModel = _userInfoModel.copyWith(firstname: value);
    _userInfoModel = updatedUserInfoModel;
    notifyListeners();
  }

  void onLastNameChange(String value) {
    final updatedUserInfoModel = _userInfoModel.copyWith(lastname: value);
    _userInfoModel = updatedUserInfoModel;
    notifyListeners();
  }

  void onUserEmailChange(String value) {
    final updatedUserInfoModel = _userInfoModel.copyWith(email: value);
    _userInfoModel = updatedUserInfoModel;
    notifyListeners();
  }

  void onUserNameChange(String value) {
    final updatedUserInfoModel = _userInfoModel.copyWith(userName: value);
    _userInfoModel = updatedUserInfoModel;
    notifyListeners();
  }

  void submitUserData() async {
    debugPrint(_userInfoModel.toJson().toString());
    setLoading(true);

    final result = await _basicDetailService.storeBasicDetails(_userInfoModel);

    result.fold((err) {
      setLoading(false);
      debugPrint(err);
      Fluttertoast.showToast(msg: err);
    }, (userInfo) {
      setLoading(false);
      if ((userInfo.isEmailValid != null && userInfo.isEmailValid!) &&
          (userInfo.isUsernameValid != null && userInfo.isUsernameValid!)) {
        navigatorKey.currentState!.push(MaterialPageRoute(
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
