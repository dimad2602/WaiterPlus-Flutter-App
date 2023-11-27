import 'dart:convert';

import 'package:flutter_project2/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/app_constants.dart';
import 'package:http/http.dart' as http;

//TODO: Это контроллер а не репозиторий
class RestaurantRepoSql extends GetxService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  RestaurantRepoSql({required this.apiClient, required this.sharedPreferences});

  late Map<String, String> _Headers;

  Future<Response> getRestaurantsList() async {
    var token = sharedPreferences.getString(AppConstants.TOKEN)??"";
    print("getRestaurantsList = $token");
    print("getRestaurantsList toker2 = ${sharedPreferences.getString(AppConstants.TOKEN)}");
    _Headers ={
      'Content-type':'application/json; charset=utf-8',
      'Authorization':'Bearer $token',
    };
    return await apiClient.getData(AppConstants.RESTAURANT_LIST);
    //return await apiClient.getData(AppConstants.RESTAURANT_LIST, headers: _Headers);
  }

  Future<Response> getRestaurantsById() async {
    var token = sharedPreferences.getString(AppConstants.TOKEN)??"";
    return await apiClient.getData(AppConstants.RESTAURANTS_BY_ID, headers: {"Authorization": "Bearer $token"});
  }

  // String? accessToken;
  // Response? response;
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
  //
  // Future<Response> getRestaurantsList() async {
  //   if (accessToken == null) {
  //     // Если токен еще не получен, выполним авторизацию
  //     await login();
  //   }
  //
  //   // Отправка GET-запроса с токеном доступа
  //   final response = await apiClient.getData(
  //     AppConstants.RESTAURANT_LIST,
  //     headers: {"Authorization": "Bearer $accessToken"},
  //   );
  //   print("Api123 $response");
  //   return response;
  // }
}


// class RestaurantRepoSql extends GetxService{
//   final ApiClient apiClient;
//   RestaurantRepoSql({required this.apiClient});
//
//   Future<Response> getRestaurantsList() async{
//     return await apiClient.getData(AppConstants.RESTAURANT_LIST); //"http://www.dbestech.com/api/products/list"
//   }
// }