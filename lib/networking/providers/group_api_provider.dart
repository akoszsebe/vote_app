import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vote_app/networking/api_provider.dart';
import 'package:vote_app/networking/request/gorupaccenpt_request.dart';
import 'package:vote_app/networking/response/group_response.dart';
import 'package:vote_app/utils/api_exeption.dart';
import 'package:vote_app/utils/shared_prefs.dart';

class GroupApiProvider extends ApiProvider {
  Future<List<GroupResponse>> getAll() async {
    try {
      String authToken = await SharedPrefs.getAuthToken();
      Response response = await dio.get(baseUrl + "/group",
          options: Options(
              headers: {"Authorization": "Bearer $authToken"},
              contentType: ContentType.parse("application/json")),cancelToken: token);
      return List<GroupResponse>.from(response.data.map((x) => GroupResponse.fromJson(x))); 
    } on DioError catch (e) {
      print("Exception occured: $e");
      throw ApiExeption.fromDioError(e);
    }
  }

  Future<bool> accept(int id) async {
    try {
      GroupAcceptRequest body = GroupAcceptRequest(id: id, accepted: true);
      String authToken = await SharedPrefs.getAuthToken();
      Response response = await dio.post(baseUrl + "/group/invite",
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

  Future<bool> reject(int id) async {
    try {
      GroupAcceptRequest body = GroupAcceptRequest(id: id, accepted: false);
      String authToken = await SharedPrefs.getAuthToken();
      Response response = await dio.post(baseUrl + "/group/invite",
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
