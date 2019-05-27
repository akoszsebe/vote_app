import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vote_app/networking/api_provider.dart';
import 'package:vote_app/networking/request/register_request.dart';
import 'package:vote_app/networking/request/verification_request.dart';
import 'package:vote_app/utils/api_exeption.dart';

class RegisterApiProvider extends ApiProvider {
  Future<bool> register(RegisterRequest registerRequest) async {
    try {
      Response response = await dio.post(baseUrl + "/auth/registration",
          data: registerRequest.toJson(),
          options: Options(contentType: ContentType.parse("application/json")),cancelToken: token);
      if (response.statusCode == 200) {
        return true;
      } 
      throw Exception("StatusCode note 200");
    } on DioError catch (e) {
      print("Exception occured: $e");
       throw ApiExeption.fromDioError(e);
    }
  }

  Future<bool> confirm(
      VerificationRequest verificationRequest, String authToken) async {
    try {
      Response response = await dio.post(baseUrl + "/auth/verification",
          data: verificationRequest.toJson(),
          options: Options(
              headers: {"Authorization": "Bearer $authToken"},
              contentType: ContentType.parse("application/json")),cancelToken: token);
      if (response.statusCode == 200) {
        return true;
      } 
      throw ApiExeption("StatusCode note 200");
    } on DioError catch (e) {
      print("Exception occured: $e");
      throw ApiExeption.fromDioError(e);
    }
  }
}
