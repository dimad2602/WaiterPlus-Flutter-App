import 'package:flutter_app_for_customers/domain/api/api_provider.dart';
import 'package:flutter_app_for_customers/domain/repositories/restaurants_repo/IRestaurantRepo.dart';
import 'package:flutter_app_for_customers/locator_get.dart';
import 'package:flutter_app_for_customers/models/restaurant/restaurant_model.dart';
import 'package:flutter_app_for_customers/utils/api_constants.dart';

class RestaurantRepo implements IRestaurantRepo {
  final ApiProvider apiProvider = locator.get<ApiProvider>();

  @override
  Future<Restaurant> getRestaurants()async {
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
}
