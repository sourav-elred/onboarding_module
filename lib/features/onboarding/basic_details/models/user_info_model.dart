// To parse this JSON data, do
//
//     final userInfoModel = userInfoModelFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

UserInfoModel userInfoModelFromJson(String str) =>
    UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel {
  final String userType;
  final String firstname;
  final String lastname;
  final String email;
  final String userName;
  final bool? isEmailValid;
  final bool? isUsernameValid;

  UserInfoModel({
    required this.userType,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.userName,
    this.isEmailValid,
    this.isUsernameValid,
  });

  UserInfoModel copyWith({
    String? userType,
    String? firstname,
    String? lastname,
    String? email,
    String? userName,
  }) =>
      UserInfoModel(
        userType: userType ?? this.userType,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        email: email ?? this.email,
        userName: userName ?? this.userName,
      );

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        userType: json["userType"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        userName: json["userName"],
        isEmailValid: json["emailValidStatus"],
        isUsernameValid: json["usernameValidStatus"],
      );

  factory UserInfoModel.empty() => UserInfoModel(
        userType: 'myself',
        firstname: '',
        lastname: '',
        email: '',
        userName: '',
      );

  Map<String, dynamic> toJson() => {
        "userType": userType,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "userName": userName,
      };
}
