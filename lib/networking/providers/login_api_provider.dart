import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vote_app/networking/api_provider.dart';
import 'package:vote_app/networking/request/login_request.dart';
import 'package:vote_app/networking/response/login_response.dart';
import 'package:vote_app/utils/api_exeption.dart';
import 'package:vote_app/utils/shared_prefs.dart';

class LoginApiProvider extends ApiProvider {

  Future<LoginResponse> login(LoginRequest loginRequest) async {
    try {
      Response response = await dio.post(baseUrl + "/auth",
          data: loginRequest.toJson(),
          options: Options(contentType: ContentType.parse("application/json")),cancelToken: token);
      return LoginResponse.fromJson(response.data);
    } on DioError catch (e) {
      print("Exception occured: $e");
      throw ApiExeption.fromDioError(e);
    }
  }

  Future<bool> loginPin(LoginPinRequest loginpinRequest) async {
    try {
      String authToken = await SharedPrefs.getAuthToken();
      Response response = await dio.put(baseUrl + "/auth",
          data: loginpinRequest.toJson(),
          options: Options(
              headers: {"Authorization": "Bearer $authToken"},
              contentType: ContentType.parse("application/json")),cancelToken: token);
      return response.statusCode == 200;
    } on DioError catch (e) {   
      throw ApiExeption.fromDioError(e);
    }
  }
}
