import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vote_app/networking/api_provider.dart';
import 'package:vote_app/networking/request/user_request.dart';
import 'package:vote_app/networking/response/userdetails_response.dart';
import 'package:vote_app/repository/session_repository.dart';
import 'package:vote_app/utils/api_exeption.dart';

class UserApiProvider extends ApiProvider {
  Future<UserDetailsResponse> getMe() async {
    try {
      String authToken = SessionRepository().getAuthToken();
      Response response = await dio.get(baseUrl + "/user/me",
          options: Options(
              headers: {"Authorization": "Bearer $authToken"},
              contentType: ContentType.parse("application/json")),
          cancelToken: token);
      return UserDetailsResponse.fromJson(response.data);
    } on DioError catch (e) {
      print("Exception occured: $e");
      throw ApiExeption.fromDioError(e);
    }
  }

   Future<bool> updateProfilePic(String base64Picture) async {
    try {
      ProfilPicUpdateRequest body = ProfilPicUpdateRequest(picture: base64Picture);
      String authToken = SessionRepository().getAuthToken();
      Response response = await dio.put(baseUrl + "/user/picture",
          data: body.toJson(),
          options: Options(
              headers: {"Authorization": "Bearer $authToken"},
              contentType: ContentType.parse("application/json")),cancelToken: token);
      return response.statusCode == 200;
    } on DioError catch (e) {
      print("Exception occured: $e");
      throw ApiExeption.fromDioError(e);
    }
  }
}