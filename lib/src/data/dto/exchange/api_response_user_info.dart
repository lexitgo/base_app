// To parse this JSON data, do
//
//     final getUser = getUserFromJson(jsonString);

import 'dart:convert';
import '../user_info_dto.dart';
import 'base/api_base_response.dart';

class ApiResponseUserInfo extends ApiBaseResponse {
    ApiResponseUserInfo({
        required this.data,
        required DateTime datetimeResponse,
        required String endpoint,
        required bool isError,
        required String errorMsg,
    }) : super(data, errorMsg);

    @override final DtoUserInfo? data;

    static ApiResponseUserInfo parseFromJson(String str) => ApiResponseUserInfo.fromJson(json.decode(str));

    factory ApiResponseUserInfo.fromJson(Map<String, dynamic> json) => ApiResponseUserInfo(
        data: json["data"].isNotEmpty ? DtoUserInfo.fromJson(json["data"]) : null,
        datetimeResponse: DateTime.parse(json["datetime_response"]),
        endpoint: json["endpoint"],
        isError: json["error"],
        errorMsg: json["error_msg"],
    );
}
