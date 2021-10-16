import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:base_app/src/domain/entities/session_entity.dart';
import 'exceptions.dart';

const String _URL_SERVER="https://xxx.xx/";
const String _URL_LOGIN="login";
const String _URL_REGISTRATION="registration";

const int _SET_CONNECT_TIMEOUT = 40000;
const int _SET_SEND_TIMEOUT = 60000;
const int _SET_RECEIVE_TIMEOUT = 60000;

class ApiService {

  Map<String,String> buildHeaders(String accessToken) {
    return {
      "Authorization":"Bearer $accessToken",
    };
  }

  Future<EntitySession> login(String username, String password) async {
    try {
      var response = await client.post(_URL_LOGIN,
        data: {
          "username":username,
          "password":password
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json'
          }
        )
      );

      var data=json.decode(response.data);

      if (response.statusCode == 200 && data["access_token"]!=null) {
        return EntitySession(data["access_token"], data["refresh_token"]);
      }
      else {
        var message="Ошибка логина";
        throw ApiException(message);
      }
    } catch (e,s) {
      if (kDebugMode) print(e);
      rethrow;
    }

  }

  Future<EntitySession> register(String username, String password) async {
    try {
      var response = await client.post(_URL_REGISTRATION,
          data: {
            "username":username,
            "password":password
          }
      );

      var data=json.decode(response.data);

      if (response.statusCode == 200 && data["access_token"]!=null) {
        return EntitySession(data["access_token"], data["refresh_token"]);
      }
      else {
        var message="Ошибка регистрации";
        throw ApiException(message);
      }
    } catch (e,s) {
      if (kDebugMode) print(e);
      rethrow;
    }

  }
  
  Dio get client => buildClient();
    
  Dio buildClient([String? baseUrl]) {
    var _dio = Dio(BaseOptions(
        connectTimeout: _SET_CONNECT_TIMEOUT,
        receiveTimeout: _SET_RECEIVE_TIMEOUT,
        sendTimeout: _SET_SEND_TIMEOUT,
        baseUrl: baseUrl ?? _URL_SERVER,
        responseType: ResponseType.plain
    ));

    _dio.interceptors.clear();
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    }
    
    return _dio;
  }

}