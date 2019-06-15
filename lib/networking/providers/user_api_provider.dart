import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vote_app/networking/api_provider.dart';
import 'package:vote_app/networking/response/userdetails_response.dart';
import 'package:vote_app/utils/api_exeption.dart';
import 'package:vote_app/utils/shared_prefs.dart';

class UserApiProvider extends ApiProvider {
  Future<UserDetailsResponse> getMe() async {
    try {
      String authToken = await SharedPrefs.getAuthToken();
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
}