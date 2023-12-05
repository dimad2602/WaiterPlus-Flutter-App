import 'dart:convert';

import 'package:flutter_project2/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetConnect implements GetxService{
  late String token;
  final String appBaseUrl;
  late SharedPreferences sharedPreferences;

  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}){
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30); //AppConstants.Token
    token = sharedPreferences.getString(AppConstants.TOKEN)??"";
    _mainHeaders ={
      'Content-type':'application/json; charset=utf-8',
      'Authorization':'Bearer $token',
    };
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void updateHeader(String token){
    _mainHeaders ={
      'Content-type':'application/json; charset=utf-8',
      'Authorization':'Bearer $token',
    };
  }

  Future<void> _checkTokenValidity() async {
    final String savedToken = sharedPreferences.getString(AppConstants.TOKEN) ?? "";
    print("TOKEN_EXPIRATION ${AppConstants.TOKEN_EXPIRATION}");
    final DateTime expirationTime = DateTime.fromMillisecondsSinceEpoch(
      sharedPreferences.getInt(AppConstants.TOKEN_EXPIRATION) ?? 0,
    );

    final DateTime currentTime = DateTime.now();
    final DateTime refreshTime = expirationTime.subtract(const Duration(minutes: 55));

    if (savedToken.isNotEmpty && currentTime.isAfter(refreshTime)) {
      // Токен устарел или находится на грани истечения срока действия, обновляем
      // Ваш код для обновления токена, например, вызов метода для получения нового токена
      // ...
      await _refreshToken();
      //REFRESH TOKEN
      // После успешного обновления токена, обновляем заголовки
      token = sharedPreferences.getString(AppConstants.TOKEN) ?? "";
      updateHeader(token);
    }
  }

  Future<void> _refreshToken() async {
    try {
      // Your logic to refresh the token (e.g., calling an API endpoint to get a new token)
      // ...

      // For example, assuming you have a method called refreshTokenApiCall
      final Response refreshTokenResponse = await refreshTokenApiCall();

      if (refreshTokenResponse.status.isOk) {
        print("Refreshing token ${refreshTokenResponse.body}");
        // final Map<String, dynamic> tokenData = json.decode(refreshTokenResponse.bodyString!); //а может просто body
        // token = tokenData['new_token'];
        // sharedPreferences.setString(AppConstants.TOKEN, token);
        // final int expirationTime = tokenData['expiration_time'];
        // sharedPreferences.setInt(AppConstants.TOKEN_EXPIRATION, expirationTime);
      } else {
        // Handle token refresh failure
        print('Token refresh failed');
      }
    } catch (e) {
      // Handle token refresh failure
      print('Token refresh error: $e');
    }
  }

  Future<Response> refreshTokenApiCall() async {
    return await post(AppConstants.REFRESH_TOKEN_URI, {}, headers: _mainHeaders);
  }


  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    print("headers =============================================== $headers");
    print("headers2 = $_mainHeaders");
    //await _checkTokenValidity();
    try{
      print("getData = ${headers}");
      Response response = await get(uri,
        headers: headers??_mainHeaders
      );
      print("getData2 = ${response.body}");
      return response;
    }catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    print("in postData");
    print(body.toString());

    //await _checkTokenValidity();
    try{
      Response response = await post(uri, body, headers: _mainHeaders); // передаем json
      print(response.body);
      return response;
    }
    catch(e){
      print('Error api client');
      print(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}