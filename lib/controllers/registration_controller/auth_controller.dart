import 'package:flutter_project2/data/repository/auth_repo.dart';
import 'package:flutter_project2/models/response_model.dart';
import 'package:flutter_project2/models/signup_body_model.dart';
import 'package:get/get.dart';

import 'dart:convert';
import '../../util/app_constants.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;
  AuthController({
    required this.authRepo,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //TODO: Переделать на репозиторий а не http
  Future<void> AuthTokenLogin(String email, String passwd) async {
    // Пример данных для отправки
    Map<String, dynamic> data = {
      "login": email,
      "passwd": passwd,
    };
    try{
      final response = await http.post(
        Uri.parse("http://${AppConstants.AUTH_LOGIN_URI}"),
        body: data,
      );
      if (response.statusCode == 200) {
        // Получаем токен доступа из ответа
        final Map<String, dynamic> responseData = json.decode(response.body);
        //new
        authRepo.saveUserToken(responseData["access_token"]);
        //old
        //accessToken = responseData["access_token"];
      } else {
        print("Failed to auth token");
        throw Exception("Failed to auth token");
      }
    }
    catch(e){
      print("ошибка api auth token$e");
    }
  }

  //TODO: Переделать на репозиторий а не http
  Future<void> AuthTokenLogout() async {
    try{
      final response = await http.post(
        Uri.parse("http://${AppConstants.AUTH_LOGOUT_URI}"),
      );
      if (response.statusCode == 200) {
        print("AUTH_LOGOUT_URI done");
      } else {
        throw Exception("Failed to auth token");
      }
    }
    catch(e){
      print("ошибка api AuthTokenLogout$e");
    }
  }

  //TODO: Добавить AuthLogin?
  Future<ResponseModel>registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    print("registration print test ${response.statusCode} AND ${response.body}");
    if(response.statusCode == 201){
      print("Backend token");// just test
      responseModel = ResponseModel(true, response.statusText!);
      //responseModel = ResponseModel(true, response.body["access_token"]);
    }else{
      print('Error creating');
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  //TODO: Обработать прием ошибки от бека и отобразить на экране
  Future<ResponseModel>login(String email, String password) async {
    print("Getting token"); // just test
    _isLoading = true;
    update();
    Response response = await authRepo.login(email, password);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      authRepo.saveUserToken(response.body["access_token"]);
      print(response.body["access_token"].toString());
      responseModel = ResponseModel(true, response.body["access_token"]);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  // Future<void> loginTest(String login, String password) async {
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

  void saveUserNumberAndPassword(String number, String email, String password) {
      authRepo.saveUserNumberAndPassword(number, email, password);
  }

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }
}