import 'package:flutter_project2/data/repository/auth_repo.dart';
import 'package:flutter_project2/models/response_model.dart';
import 'package:flutter_project2/models/signup_body_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;
  AuthController({
    required this.authRepo,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel>registration(SignUpBody signUpBody) async {
    print("Getting token"); // just test
    print(authRepo.getUserToken().toString());// just test
    _isLoading = true;
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      print("Backend token");// just test
      authRepo.saveUserToken(response.body["access_token"]);
      print(response.body["token"].toString());// just test
      responseModel = ResponseModel(true, response.body["access_token"]);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = true;
    update();
    return responseModel;
  }

  Future<ResponseModel>login(String login, String password) async {
    _isLoading = true;
    Response response = await authRepo.login(login, password);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      authRepo.saveUserToken(response.body["access_token"]);
      responseModel = ResponseModel(true, response.body["access_token"]);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = true;
    update();
    return responseModel;
  }

  void saveUserNumberAndPassword(String number, String password) {
      authRepo.saveUserNumberAndPassword(number, password);
  }

  bool userLoggedIn() {
    return authRepo.userLogedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }
}