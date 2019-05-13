import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vote_app/networking/api_provider.dart';
import 'package:vote_app/networking/request/login_request.dart';
import 'package:vote_app/networking/response/login_response.dart';

class LoginApiProvider extends ApiProvider {
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    try {
      Response response = await dio.post(baseUrl + "/auth",
          data: loginRequest.toJson(),
          options: Options(contentType: ContentType.parse("application/json")));
      return LoginResponse.fromJson(response.data);
    } on DioError catch (e) {
      print("Exception occured: $e");
      return LoginResponse(error: e.response.data["message"]);
    }
  }

  Future<bool> loginPin(LoginPinRequest loginpinRequest,String authToken) async {
    try {
      Response response = await dio.put(baseUrl + "/auth",
          data: loginpinRequest.toJson(),
          options: Options(
            headers: {"Authorization": "Bearer $authToken"},
            contentType: ContentType.parse("application/json")));
      return response.statusCode == 200;
    } on DioError catch (e) {
      print("Exception occured: $e");
      return false;
    }
  }
}
