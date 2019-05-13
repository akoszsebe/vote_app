import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vote_app/networking/request/refreshToken_request.dart';
import 'package:vote_app/utils/jwt_decode.dart';
import 'package:vote_app/utils/shared_prefs.dart';

class ApiProvider {
  final String baseUrl = "https://voting-chain.herokuapp.com/api";
  final Dio dio = Dio();

  ApiProvider() {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      // Do something before request is sent
      return options; //continue
      // If you want to resolve the request with some custom data，
      // you can return a `Response` object or return `dio.resolve(data)`.
      // If you want to reject the request with a error message,
      // you can return a `DioError` object or return `dio.reject(errMsg)`
    }, onResponse: (Response response) {
      // Do something with response data
      return response; // continue
    }, onError: (DioError e) {
      // Do something with response error
      return e; //continue
    }));
    Dio tokenDio = new Dio(); //Create a new instance to request the token.
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        // If no token, request token firstly and lock this interceptor
        // to prevent other request enter this interceptor.
        dio.interceptors.requestLock.lock();
        if (options.path == baseUrl + '/auth' && options.method == 'POST') {
          dio.interceptors.requestLock.unlock();
          return options;
        }
        if (options.path != baseUrl + '/auth/refresh') {
          String authToken = await SharedPrefs.getAuthToken();
          String refreshToken = await SharedPrefs.getRefreshToken();
          int exp = parseJwt(authToken)["exp"];
          if (exp < (DateTime.now().millisecondsSinceEpoch/1000)) {
            RefreshTokenRequest refreshTokenRequest =
                RefreshTokenRequest(refreshToken: refreshToken);
            try {
              Response response = await tokenDio.put(baseUrl + "/auth/refresh",
                  data: refreshTokenRequest.toJson(),
                  options: Options(
                      contentType: ContentType.parse("application/json")));
              print(response);
              if (response.statusCode == 200) {
                String token = response.data["authToken"];
                SharedPrefs.setAuthToken(token);
                options.headers["Authorization"] = 'Bearer $token';
                dio.interceptors.requestLock.unlock();
                return options;
              }
            } on DioError catch (e) {
              print("Exception occured: $e");
              dio.interceptors.requestLock.unlock();
              return options;
            }
          }
        }
        dio.interceptors.requestLock.unlock();
        return options;
      },
    ));
    dio.interceptors.add(LogInterceptor(responseBody: true));
  }
}
