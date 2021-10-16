import 'api_base_data.dart';

abstract class ApiBaseResponse {
  ApiBaseResponse(
    this.data,
    this.errorMsg,
 );

  final ApiBaseData? data;
  String errorMsg;

  static ApiBaseResponse apiResponseFromJson(String str) {
    throw UnimplementedError();
  }

}
