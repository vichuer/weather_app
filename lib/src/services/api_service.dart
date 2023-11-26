import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ApiMethod {
  get,
  post,
  delete,
  update,
}

class ApiService {
  static Map errorResponse = {};
  static Dio dio = Dio();

  ///api method set up
  static Future<Response<dynamic>?> apiMethodSetup(
      {required ApiMethod method,
      required String url,
      required String baseURL,
      var data,
      var queryParameters,
      Function(int, int)? onSendProgress,
      Function(int, int)? onRecieveProgress,
      Options? options}) async {
    // dio.options.baseUrl = weather;
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);

    try {
      Response? response;
      switch (method) {
        case ApiMethod.get:
          if (data != null) {
            log(url);
            response = await dio.get(url,
                queryParameters: data, options: options ?? Options());
          } else {
            response = await dio.get(url, options: options ?? Options());
          }
          break;
        case ApiMethod.post:
          response = await dio.post(baseURL + url,
              data: data,
              queryParameters: queryParameters,
              onSendProgress: onSendProgress,
              onReceiveProgress: onRecieveProgress);
          break;
        case ApiMethod.delete:
          // ignore: todo
          // TODO: Handle this case.
          break;
        case ApiMethod.update:
          // ignore: todo
          // TODO: Handle this case.
          break;
      }
      return response;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (e.response?.statusCode == 401) {
        errorResponse["status"] = "401";
        errorResponse["message"] = "Authorization error";
        if (kDebugMode) {
          print(errorResponse);
        }
      } else if (e.response?.statusCode == 500) {
        if (kDebugMode) {
          print(e.error);
        }
        Fluttertoast.showToast(msg: 'Server Error');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        Fluttertoast.showToast(msg: 'Check your network speed');
      } else if (e.type == DioExceptionType.connectionTimeout) {
        Fluttertoast.showToast(msg: 'Check your connectivity');
      } else if (e.error is SocketException) {
        errorResponse["status"] = "101";
        errorResponse["message"] = "internet error";
        Fluttertoast.showToast(msg: 'Please check your network');
        if (kDebugMode) {
          print(errorResponse);
        }
      } else {
        if (kDebugMode) {
          print("103");
        }
      }
    }
    return null;
  }
}
