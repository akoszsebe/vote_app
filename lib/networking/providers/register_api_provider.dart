
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vote_app/networking/api_provider.dart';
import 'package:vote_app/networking/request/register_request.dart';
import 'package:vote_app/networking/request/verification_request.dart';

class RegisterApiProvider extends ApiProvider{
  Future<bool> register(RegisterRequest registerRequest) async {
    try {
      Response response = await dio.post(baseUrl+"/auth/registration", data: registerRequest.toJson(), options: Options(contentType : ContentType.parse("application/json")));
      if (response.statusCode == 200){
        return true;
      } else{
        return false;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return false;
    }
  }
  
  Future<bool> confirm(VerificationRequest verificationRequest,String authToken) async {
    try {
      Response response = await dio.post(baseUrl+"/auth/verification", data: verificationRequest.toJson(), options: Options(headers: {"Authentication" : "Bearer $authToken"}, contentType : ContentType.parse("application/json")));
      if (response.statusCode == 200){
        return true;
      } else{
        return false;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return false;
    }
  }
}