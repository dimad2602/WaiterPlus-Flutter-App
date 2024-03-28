import 'dart:convert';

import 'package:flutter_app_for_customers/domain/api/api_provider.dart';
import 'package:flutter_app_for_customers/domain/repositories/sign_in_repo/ISignInRepo.dart';
import 'package:flutter_app_for_customers/locator_get.dart';
import 'package:flutter_app_for_customers/models/response_model/response_model.dart';
import 'package:flutter_app_for_customers/models/restaurant_employee/restaurant_employee.dart';
import 'package:flutter_app_for_customers/models/user/user.dart';
import 'package:flutter_app_for_customers/utils/api_constants.dart';



class SignInRepo implements ISignInRepository {
  final ApiProvider apiProvider = locator.get<ApiProvider>();

  @override
  Future<RestaurantEmployee?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    //if (email == 'example@sample.com' && password == 'password') {
    return RestaurantEmployee(
        email: email,
        id: 200,
        emailVerified: true,
        passwd: '123456',
        employeeId: 1,
        restaurantId: 1);
    // } else {
    //   return null;
    // }
  }

  @override
  Future<RestaurantEmployee?> signInWithSocialNetwork() async {
    await Future.delayed(const Duration(seconds: 2));

    return const RestaurantEmployee(
      email: 'social@example.com',
      id: 100,
      emailVerified: true,
      passwd: '123456',
      employeeId: 1,
      restaurantId: 1,
    );
  }

  @override
  Future<User?> login({required String email, required String password}) async {
    print("login start");
    try {
      final response = await apiProvider.postData(
          AppConstants.AUTH_LOGIN_URI, {"login": email, "passwd": password});

      if (response.statusCode == 200) {
        final DateTime currentTime = DateTime.now();
        final DateTime expirationTime =
            currentTime.add(const Duration(hours: 1));
        // const String expirationTime = "3600"; //responseBody["expiration_time"]; // предположим, что сервер возвращает время истечения токена
        //print('apiProvider.token = ${apiProvider.token}');

        final Map<String, dynamic> responseData = json.decode(response.body);
        apiProvider.updateToken(responseData["access_token"]);
        //print('apiProvider.token = ${apiProvider.token}');

        //await authRepo.saveUserToken(response.body["access_token"]);
        //await authRepo.saveTokenExpiration(expirationTime.toString());

        var responseModel = ResponseModel(true, response.body);

        print("responseModel = ${responseModel.message}");
        print("response.body = ${response.body}");
      } else {
        //var responseModel = ResponseModel(false, response.statusText!);
        print('response.statusCode != 200');
      }
    } catch (e) {
      print('responseNew error = $e');
      print('responseNew error = ${e.toString()}');
    }

    return const User(
        id: 1, name: '', email: '', emailVerified: true, passwd: '');
  }
}
