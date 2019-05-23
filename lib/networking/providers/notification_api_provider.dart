import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vote_app/networking/api_provider.dart';
import 'package:vote_app/networking/response/notification_response.dart';
import 'package:vote_app/utils/api_exeption.dart';
import 'package:vote_app/utils/shared_prefs.dart';

class NotificationApiProvider extends ApiProvider {

   Future<List<NotificationResponse>> getAll() async {
    try {
      String authToken = await SharedPrefs.getAuthToken();
      Response response = await dio.get(baseUrl + "/notification",
          options: Options(
            headers: {"Authorization": "Bearer $authToken"},
            contentType: ContentType.parse("application/json")));
      return List<NotificationResponse>.from(response.data.map((x) => NotificationResponse.fromJson(x))); 
    } on DioError catch (e) {
      print("Exception occured: $e");
      throw ApiExeption.fromDioError(e);
    }
  }
}