import 'dart:convert';
import 'dart:developer';

VerifyUserResponse verifyUserResponseFromJson(String str) =>
    VerifyUserResponse.fromJson(json.decode(str));

class VerifyUserResponse {
  VerifyUserResponse(
      {required this.success,
      required this.isAuth,
      required this.createdUser,
      required this.updatedUser,
      required this.signupType,
      required this.message,
      required this.result,
      this.selectedCardDetails,
      this.uid,
      this.email,
      this.phone,
      this.dpURL,
      this.userCode,
      this.userName,
      this.firstname,
      this.lastname});

  bool success;
  String? uid;
  bool? isAuth;
  bool? createdUser;
  bool? updatedUser;
  int? errorCode;
  String? userName;
  String? firstname;
  String? lastname;
  String? dpURL;
  String? userCode;
  String? signupType;
  String? email;
  String? phone;
  String message;
  SelectedCardDetails? selectedCardDetails;
  List<Result> result;

  factory VerifyUserResponse.fromJson(Map<String, dynamic> json) {
    log("trying to ${json['signupType']}");
    return VerifyUserResponse(
      success: json["success"],
      uid: json["uid"],
      isAuth: json["isAuth"],
      createdUser: json["createdUser"],
      userName: json["userName"],
      firstname: json["firstname"],
      dpURL: json["dpURL"],
      lastname: json["lastname"],
      userCode: json["userCode"],
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      updatedUser: json["updatedUser"],
      signupType: json["signupType"],
      message: json["message"] ?? "",
      selectedCardDetails: json['selectedCardDetails'] != null
          ? SelectedCardDetails.fromJson(json['selectedCardDetails'])
          : null,
      result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    );
  }
}

class SelectedCardDetails {
  final String? cardImageId;
  final String? cardDesignType;

  SelectedCardDetails({this.cardImageId, this.cardDesignType});

  factory SelectedCardDetails.fromJson(Map<String, dynamic> json) =>
      SelectedCardDetails(
          cardDesignType: json["cardDesignType"],
          cardImageId: json["cardImageId"]);

  Map<String, dynamic> toJson() => {
        "cardDesignType": cardDesignType,
        "cardImageId": cardImageId,
      };
}

class Result {
  Result(
      {this.accessToken,
      this.expiryTime,
      this.profileBannerImageURL,
      this.dpURL});

  String? accessToken;
  String? expiryTime;
  String? profileBannerImageURL;
  String? dpURL;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
      accessToken: json["accessToken"],
      expiryTime: json["expiryTime"],
      dpURL: json["dpURL"],
      profileBannerImageURL: json["profileBannerImageURL"]);

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "expiryTime": expiryTime,
      };
}

class ApiResponse {
  final VerifyUserResponse? response;
  final bool isError;
  final String? errorMessage;

  ApiResponse({this.response, this.isError = false, this.errorMessage});
}
