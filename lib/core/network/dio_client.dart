import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

import '../shared_preferences/shared_prefs_client.dart';
import 'api_endpoints.dart';

class DioClient {
  // disabling any instance creation of this class
  DioClient._privateConstructor();

  static final DioClient _instance = DioClient._privateConstructor();

  static DioClient get instance => _instance;

  static BaseOptions options = BaseOptions(
    baseUrl: ApiEndpoint.baseUrl,
    connectTimeout: const Duration(milliseconds: 1200000),
    receiveTimeout: const Duration(milliseconds: 1200000),
    contentType: Headers.jsonContentType,
    validateStatus: (status) => true,
    // headers: {'Authorization': 'Bearer $accessToken'},
    responseType: ResponseType.json,
  );

  // final Dio _dio = Dio(options)..interceptors.add(alice.getDioInterceptor());
  final Dio _dio = Dio(options);

  // get api call
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      await checkOrAddToken();
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
      );
      debugPrint("Response ${response.statusCode}");
      await checkAccessTokenExpiry(response);

      return response;
    } on DioException catch (e) {
      if (e.error is SocketException) {
        throw Exception("Network Error Or Internet Failure.");
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      rethrow;
    }
  }

// post ap icall
  Future<Response> post(String url,
      {Map<String, dynamic>? body, Map<String, dynamic>? queryParams}) async {
    try {
      log(url);
      log(body.toString());
      await checkOrAddToken();
      final Response response = await _dio.post(
        url,
        data: body,
        queryParameters: queryParams,
      );

      debugPrint(
          "response is this $queryParams ${response.statusCode} with body ${response.data}  with url $url");
      await checkAccessTokenExpiry(response);

      return response;
    } on DioException catch (e) {
      if (e.error is SocketException) {
        throw Exception("Network Error Or Internet Failure.");
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      rethrow;
    }
  }

// multipart request
  Future<Response> startMultiPartRequest(String url, String path,
      {String? postRequestApiKey, CancelToken? cancelToken}) async {
    final file = File(path);
    debugPrint('url path key $url $postRequestApiKey');
    String fileName = file.path.split('/').last;
    String fileExtnsn = fileName.split('.').last;
    FormData data = FormData.fromMap({
      postRequestApiKey ?? "profileBannerImageURL":
          await MultipartFile.fromFile(
        file.path,
        filename: fileName,
        contentType: MediaType("image", fileExtnsn),
      ),
    });
    try {
      await checkOrAddToken();
      final Response response = await _dio.post(
        url,
        data: data,
        cancelToken: cancelToken,
      );
      debugPrint(response.data.toString());
      await checkAccessTokenExpiry(response);
      return response;
    } on DioException catch (e) {
      if (e.error is SocketException) {
        throw Exception("Network Error Or Internet Failure.");
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> checkAccessTokenExpiry(Response<dynamic> response) async {
    if (response.statusCode != 200) {
      // AppToast.serverErrorToast();
    }
    debugPrint("response is here2 ${response.data}");
    var responseMap = response.data as Map<String, dynamic>;
    if (responseMap.containsKey('errorCode')) {
      if (responseMap['errorCode'] != null || responseMap['errorCode'] != '') {
        if (responseMap['errorCode'] == 1) {
          // signOut();
        }
      }
    }
  }

  Future<void> checkOrAddToken() async {
    final token = await SharedPrefsClient().getAccessToken;
    debugPrint(token);
    _dio.options.headers['authorization'] = 'bearer $token';
  }

  Future<Response> patch(
      {required String apiUrl,
      required Map<String, dynamic> body,
      Map<String, dynamic>? queryParams,
      String? contentType,
      CancelToken? cancelToken}) async {
    try {
      log(body.toString());
      await checkOrAddToken();
      var response = await instance._dio.patch(apiUrl,
          data: body,
          cancelToken: cancelToken,
          queryParameters: queryParams,
          options: Options(
            contentType: contentType,
          ));
      await checkAccessTokenExpiry(response);
      return response;
    } on DioException catch (e) {
      if (e.error is SocketException) {
        throw Exception("Network Error Or Internet Failure.");
      } else {
        throw Exception("Something went wrong $e");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> patchFormData({
    required String apiUrl,
    String? apiKey,
    String? filePath,
    required Map<String, dynamic> body,
    Map<String, dynamic>? queryParams,
    String? contentType,
  }) async {
    try {
      await checkOrAddToken();
      late FormData data;
      if (filePath != null && apiKey != null) {
        if (filePath.isEmpty || filePath.trim().isEmpty) {
          data = FormData.fromMap({...body, apiKey: ' '});
        } else {
          final file = File(filePath);
          String fileName = file.path.split('/').last;
          String fileExtnsn = fileName.split('.').last;
          data = FormData.fromMap({
            ...body,
            apiKey: await MultipartFile.fromFile(
              file.path,
              filename: fileName,
              contentType: fileExtnsn.contains("pdf")
                  ? MediaType("application", fileExtnsn)
                  : MediaType("image", fileExtnsn),
            ),
          });
        }
      } else {
        data = FormData.fromMap({...body});
      }
      var response = await instance._dio.patch(apiUrl,
          data: data,
          queryParameters: queryParams,
          options: Options(
            contentType: contentType,
            // headers: headerMap,
          ));

      await checkAccessTokenExpiry(response);
      return response;
    } on DioException catch (e) {
      if (e.error is SocketException) {
        throw Exception("Network Error Or Internet Failure.");
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      rethrow;
    }
  }
}
