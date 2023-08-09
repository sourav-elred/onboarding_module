// To parse this JSON data, do
//
//     final userInfoModel = userInfoModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserInfoModel userInfoModelFromJson(String str) =>
    UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel {
  final bool success;
  final bool isAuth;
  final String message;
  final bool emailValidStatus;
  final bool usernameValidStatus;
  final List<Result> result;

  UserInfoModel({
    required this.success,
    required this.isAuth,
    required this.message,
    this.emailValidStatus = true,
    this.usernameValidStatus = true,
    required this.result,
  });

  UserInfoModel copyWith({
    bool? success,
    bool? isAuth,
    String? message,
    bool? emailValidStatus,
    bool? usernameValidStatus,
    List<Result>? result,
  }) =>
      UserInfoModel(
        success: success ?? this.success,
        isAuth: isAuth ?? this.isAuth,
        message: message ?? this.message,
        emailValidStatus: emailValidStatus ?? this.emailValidStatus,
        usernameValidStatus: usernameValidStatus ?? this.usernameValidStatus,
        result: result ?? this.result,
      );

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        success: json["success"],
        isAuth: json["isAuth"],
        message: json["message"],
        emailValidStatus: json["emailValidStatus"],
        usernameValidStatus: json["usernameValidStatus"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "isAuth": isAuth,
        "message": message,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  final String uid;
  final String phone;
  final String email;
  final String firstname;
  final String lastname;
  final String userName;
  final String userType;

  Result({
    required this.uid,
    required this.phone,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.userName,
    this.userType = 'myself',
  });

  Result copyWith({
    String? uid,
    String? phone,
    String? email,
    String? firstname,
    String? lastname,
    String? userName,
    String? userType,
  }) =>
      Result(
        uid: uid ?? this.uid,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        userName: userName ?? this.userName,
        userType: userType ?? this.userType,
      );

  factory Result.empty() => Result(
        uid: '',
        phone: '',
        email: '',
        firstname: '',
        lastname: '',
        userName: '',
        userType: 'myself',
      );

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        uid: json["uid"],
        phone: json["phone"],
        email: json["email"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        userName: json["userName"],
        userType: json["userType"],
      );

  Map<String, dynamic> toJson() => {
        // "uid": uid,
        // "phone": phone,
        "email": email,
        "firstname": firstname,
        "lastname": lastname,
        "userName": userName,
        "userType": userType,
      };
}
