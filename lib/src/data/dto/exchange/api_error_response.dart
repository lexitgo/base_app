import 'dart:convert';

import 'base/api_base_response.dart';

class ApiResponseError extends ApiBaseResponse{
  ApiResponseError({
    required String errorMsg,
  }) : super(null,  errorMsg);

  static ApiResponseError apiResponseErrorFromJson(String str) {
    return ApiResponseError.fromJson(json.decode(str));
  }

  factory ApiResponseError.fromJson(Map<String, dynamic> json) => ApiResponseError(
    errorMsg: json["error"],
  );
}