import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vote_app/networking/api_provider.dart';
import 'package:vote_app/repository/session_repository.dart';
import 'package:vote_app/utils/api_exeption.dart';


class TypesApiProvider extends ApiProvider {
  Future<List<String>> getTypes() async {
    try {
      String authToken = SessionRepository().getAuthToken();
      Response response = await dio.get(baseUrl + "/types/names",
          options: Options(
              headers: {"Authorization": "Bearer $authToken"},
              contentType: ContentType.parse("application/json")),
          cancelToken: token);
          print(response.data);
      return List.from(response.data);
    } on DioError catch (e) {
      print("Exception occured: $e");
      throw ApiExeption.fromDioError(e);
    }
  }
}