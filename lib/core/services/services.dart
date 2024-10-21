import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

enum RequestMethods { get, post, put, delete, patch }

class Services {
  Dio dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 100),
    sendTimeout: const Duration(seconds: 100),
    receiveTimeout: const Duration(seconds: 100),
    // contentType: "application/json",
    validateStatus: (status) {
      final st = status ?? 503;
      return st >= 200 && st < 300;
    },
  ));

  Future request({
    RequestMethods methods = RequestMethods.post,
    required dynamic params,
    required String tableName,
  }) async {
    Response? response;
    Map<String, dynamic>? headers = {
      "Content-Type": "application/json",
    };
    String baseUrl = "https://reqres.in/api/$tableName";
    try {
      switch (methods) {
        case RequestMethods.get:
          response = await dio.get(baseUrl,
              options: Options(
                headers: headers,
                receiveDataWhenStatusError: true,
                validateStatus: (status) => true,
              ));
          break;
        case RequestMethods.post:
          response = await dio.post(baseUrl,
              data: params,
              options:
                  Options(headers: headers, receiveDataWhenStatusError: true));
          break;
        case RequestMethods.put:
          response = await dio.put(baseUrl,
              data: params,
              options:
                  Options(headers: headers, receiveDataWhenStatusError: true));
          break;
        case RequestMethods.delete:
          response = await dio.delete(
            baseUrl,
            options:
                Options(headers: headers, receiveDataWhenStatusError: true),
          );
          break;
        case RequestMethods.patch:
          response = await dio.patch(baseUrl);
          break;
      }

      if (response.statusMessage == "OK") {
        return response.data;
      } else {
        return response.statusMessage;
      }
    } catch (e) {
      debugPrint("Services Error $e");
    }
  }
}
