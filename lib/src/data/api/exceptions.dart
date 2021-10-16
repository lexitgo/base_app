import 'package:base_app/src/data/dto/exchange/api_error_response.dart';

class ApiException implements Exception {
  final String message;
  final ApiResponseError? responseError;

  ApiException(this.message, [this.responseError]);
}

class ServerException implements Exception {
  final String message;
  final int errorCode;
  final String? url;

  ServerException(this.message, this.errorCode,[this.url]);
}

class NoInternetException implements Exception {
  final String message="Отсутствует подключение к интернету";
  final String? url;

  NoInternetException([this.url]);
}