import 'package:flutter_project2/util/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get.dart';
import '../api/api_client.dart';

class UserRepo {
  final ApiClient apiClient;

  UserRepo({required this.apiClient});

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.USER_INFO_URI);
  }
}
