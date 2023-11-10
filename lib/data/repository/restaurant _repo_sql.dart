import 'dart:convert';

import 'package:flutter_project2/data/api/api_client.dart';
import 'package:get/get.dart';

import '../../util/app_constants.dart';
import 'package:http/http.dart' as http;

class RestaurantRepoSql extends GetxService {
  final ApiClient apiClient;
  RestaurantRepoSql({required this.apiClient});

  String? accessToken;
  Response? response;
  Future<void> login() async {
    print("api login");
    // Пример данных для отправки
    Map<String, dynamic> data = {
      "login": "admin@mail.ru",
      "passwd": "1789",
    };

    // Отправка POST-запроса для авторизации
    try{
      final response = await http.post(
        Uri.parse("http://${AppConstants.LOGIN_URI}"),
        body: data,
      );
      print("Api0 $response");
      if (response.statusCode == 200) {
        // Получаем токен доступа из ответа
        final Map<String, dynamic> responseData = json.decode(response.body);
        accessToken = responseData["access_token"];
      } else {
        throw Exception("Failed to login");
      }
    }
    catch(e){
      print("ошибка api $e");
    }
  }

  Future<Response> getRestaurantsList() async {
    if (accessToken == null) {
      // Если токен еще не получен, выполним авторизацию
      await login();
    }

    // Отправка GET-запроса с токеном доступа
    final response = await apiClient.getData(
      AppConstants.RESTAURANT_LIST,
      headers: {"Authorization": "Bearer $accessToken"},
    );
    print("Api1 $response");
    return response;
  }
}


// class RestaurantRepoSql extends GetxService{
//   final ApiClient apiClient;
//   RestaurantRepoSql({required this.apiClient});
//
//   Future<Response> getRestaurantsList() async{
//     return await apiClient.getData(AppConstants.RESTAURANT_LIST); //"http://www.dbestech.com/api/products/list"
//   }
// }