import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vote_app/networking/api_provider.dart';
import 'package:vote_app/networking/response/vote_response.dart';
import 'package:vote_app/repository/session_repository.dart';
import 'package:vote_app/utils/api_exeption.dart';
import 'package:vote_app/utils/shared_prefs.dart';

class VoteApiProvider extends ApiProvider {
  Future<List<VoteResponse>> getUpcoming() async {
    try {
      var queryParameters = {
        'page': 0,
        'size': 100,
      };
      String authToken = await SharedPrefs.getAuthToken();
      Response response = await dio.get(baseUrl + "/vote/upcoming",
          queryParameters: queryParameters,
          options: Options(
              headers: {"Authorization": "Bearer $authToken"},
              contentType: ContentType.parse("application/json")),
          cancelToken: token);
      return List<VoteResponse>.from(response.data.map((x) => VoteResponse.fromJson(x)));
    } on DioError catch (e) {
      print("Exception occured: $e");
      throw ApiExeption.fromDioError(e);
    }
  }

  Future<List<FinishedVoteResponse>> getFinished() async {
    try {
      var queryParameters = {
        'page': 0,
        'size': 100,
      };
      String authToken = await SharedPrefs.getAuthToken();
      Response response = await dio.get(baseUrl + "/vote/past",
          queryParameters: queryParameters,
          options: Options(
              headers: {"Authorization": "Bearer $authToken"},
              contentType: ContentType.parse("application/json")),
          cancelToken: token);
      return List<FinishedVoteResponse>.from(response.data.map((x) => FinishedVoteResponse.fromJson(x)));
    } on DioError catch (e) {
      print("Exception occured: $e");
      throw ApiExeption.fromDioError(e);
    }
  }

  Future<VoteDetailResponse> getDetails(int id) async {
    try {
      String authToken = await SharedPrefs.getAuthToken();
      Response response = await dio.get(baseUrl + "/vote/" + id.toString(),
          options: Options(
              headers: {"Authorization": "Bearer $authToken"},
              contentType: ContentType.parse("application/json")),
          cancelToken: token);
      return VoteDetailResponse.fromJson(response.data);
    } on DioError catch (e) {
      print("Exception occured: $e");
      throw ApiExeption.fromDioError(e);
    }
  }

   Future<VerifyVoteResopnse> verifyVote(String voteId,String optionId) async {
    try {
      String authToken = SessionRepository().getAuthToken();
      Response response = await dio.get(baseUrl + "/vote/$voteId/$optionId",
          options: Options(
              headers: {"Authorization": "Bearer $authToken"},
              contentType: ContentType.parse("application/json")),cancelToken: token);
      return VerifyVoteResopnse.fromJson(response.data);
    } on DioError catch (e) {
      print("Exception occured: $e");
      throw ApiExeption.fromDioError(e);
    }
  }
}
