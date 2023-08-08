import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../models/user_info_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class BasicDetailsService {
  final _dioClient = DioClient.instance;

  Future<Either<String, UserInfoModel>> storeBasicDetails(
      UserInfoModel userInfo) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoint.postUserInfo,
        body: userInfo.toJson(),
      );

      if (response.data['success']) {
        final updatedUserInfo = UserInfoModel.fromJson(response.data);

        return right(updatedUserInfo);
      } else {
        return left(response.data['message']);
      }
    } catch (e) {
      debugPrint(e.toString());
      return left(e.toString());
    }
  }
}
