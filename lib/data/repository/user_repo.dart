import 'dart:convert';

import 'package:flutter_project2/util/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api_client.dart';
import 'package:http/http.dart' as http;

class UserRepo {
  final ApiClient apiClient;
  //final SharedPreferences sharedPreferences;
  UserRepo({required this.apiClient});
  //  String? accessToken;

  Future<Response> getUserInfo() async {
    //var token = sharedPreferences.getString(AppConstants.TOKEN)??"";
    return await apiClient.getData(AppConstants.USER_INFO_URI);
  }

  // Future<void> login() async {
  //   print("api login");
  //   // Пример данных для отправки
  //   Map<String, dynamic> data = {
  //     "login": "admin@mail.ru",
  //     "passwd": "1789",
  //   };
  //
  //   // Отправка POST-запроса для авторизации
  //   try{
  //     final response = await http.post(
  //       Uri.parse("http://${AppConstants.AUTH_LOGIN_URI}"),
  //       body: data,
  //     );
  //     print("Api0 $response");
  //     if (response.statusCode == 200) {
  //       // Получаем токен доступа из ответа
  //       final Map<String, dynamic> responseData = json.decode(response.body);
  //       accessToken = responseData["access_token"];
  //     } else {
  //       throw Exception("Failed to login");
  //     }
  //   }
  //   catch(e){
  //     print("ошибка api $e");
  //   }
  // }
}
