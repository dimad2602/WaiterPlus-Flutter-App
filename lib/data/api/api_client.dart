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
    timeout = const Duration(seconds: 30); //
    token = sharedPreferences.getString(AppConstants.TOKEN)??"";
    _mainHeaders ={
      'Content-type':'application/json; charset=utf-8',
      'Authorization':'Bearer $token',
    };
  }

  void updateHeader(String token){
    _mainHeaders ={
      'Content-type':'application/json; charset=utf-8',
      'Authorization':'Bearer $token',
    };
  }

  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try{
      Response response = await get(uri,
        headers: headers??_mainHeaders
      );
      return response;
    }catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    print("in postData");
    print(body.toString());
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