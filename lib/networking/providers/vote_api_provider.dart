import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vote_app/networking/api_provider.dart';
import 'package:vote_app/networking/response/vote_response.dart';
import 'package:vote_app/utils/api_exeption.dart';
import 'package:vote_app/utils/shared_prefs.dart';

class VoteApiProvider extends ApiProvider {

   Future<List<VoteResponse>> getUpcoming() async {
    try {
      String authToken = await SharedPrefs.getAuthToken();
      Response response = await dio.get(baseUrl + "/vote/upcomming",
          options: Options(
            headers: {"Authorization": "Bearer $authToken"},
            contentType: ContentType.parse("application/json")));
      return List<VoteResponse>.from(response.data);
    } on DioError catch (e) {
      print("Exception occured: $e");
      throw ApiExeption.fromDioError(e);
    }
  }

   Future<List<VoteResponse>> getFinished() async {
    try {
      String authToken = await SharedPrefs.getAuthToken();
      Response response = await dio.get(baseUrl + "/vote/past",
          options: Options(
            headers: {"Authorization": "Bearer $authToken"},
            contentType: ContentType.parse("application/json")));
      return List<VoteResponse>.from(response.data);
    } on DioError catch (e) {
      print("Exception occured: $e");
      throw ApiExeption.fromDioError(e);
    }
  }

   Future<VoteDetailResponse> getDetails(int id) async {
    try {
      String authToken = await SharedPrefs.getAuthToken();
      Response response = await dio.get(baseUrl + "/vote/"+id.toString(),
          options: Options(
            headers: {"Authorization": "Bearer $authToken"},
            contentType: ContentType.parse("application/json")));
      return VoteDetailResponse.fromJson(response.data);
    } on DioError catch (e) {
      print("Exception occured: $e");
      throw ApiExeption.fromDioError(e);
    }
  }
}