import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vote_app/networking/api_provider.dart';
import 'package:vote_app/networking/response/notification_response.dart';
import 'package:vote_app/repository/session_repository.dart';
import 'package:vote_app/utils/api_exeption.dart';
import 'package:vote_app/utils/shared_prefs.dart';

class NotificationApiProvider extends ApiProvider {

   Future<List<NotificationResponse>> getAll() async {
    try {
      var queryParameters = {
        'page': 0,
        'size': 100,
      };
      String authToken = await SharedPrefs.getAuthToken();
      Response response = await dio.get(baseUrl + "/notification",
      queryParameters: queryParameters,
          options: Options(
            headers: {"Authorization": "Bearer $authToken"},
            contentType: ContentType.parse("application/json")),cancelToken: token);
      return List<NotificationResponse>.from(response.data.map((x) => NotificationResponse.fromJson(x))); 
    } on DioError catch (e) {
      print("Exception occured: $e");
      throw ApiExeption.fromDioError(e);
    }
  }


  Future<List<NotificationResponse>> getNew() async {
    try {
      var queryParameters = {
        'page': 0,
        'size': 10,
      };
      String authToken = SessionRepository().getAuthToken();
      Response response = await dio.get(baseUrl + "/notification/new",
      queryParameters: queryParameters,
          options: Options(
            headers: {"Authorization": "Bearer $authToken"},
            contentType: ContentType.parse("application/json")),cancelToken: token);
      return List<NotificationResponse>.from(response.data.map((x) => NotificationResponse.fromJson(x))); 
    } on DioError catch (e) {
      print("Exception occured: $e");
      throw ApiExeption.fromDioError(e);
    }
  }
}