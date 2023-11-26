import 'package:flutter_project2/models/user_model.dart';
import 'package:get/get.dart';

import '../../data/repository/user_repo.dart';
import '../../models/response_model.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  bool _isLoading = false;
  UserController({
    required this.userRepo,
  });


  late UserModel _userModel;

  bool get isLoading => _isLoading;
  UserModel get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      _isLoading = true;
      update();
      responseModel = ResponseModel(true, "success");
    }else{
      responseModel = ResponseModel(false, response.statusCode!.toString());
    }
    print("getUserInfo end and loading end");
    _isLoading = false;
    update();
    return responseModel;
  }

  // //Future<ResponseModel>
  // void getUserInfo() async {
  //   print("getUserInfo hello");
  //   Response response = await userRepo.getUserInfo();
  //   late ResponseModel responseModel;
  //   print("test user info api = ${response.statusCode}");
  //   if (response.statusCode == 200) {
  //     print("successfully + ${response.body}");
  //     //_userModel = UserModel.fromJson(response.body);
  //     //print("user model  ${_userModel.name}");
  //     //     _isLoading = true;
  //     //     //responseModel = ResponseModel(true, "successfully");
  //     //     //test
  //     //     responseModel = ResponseModel(false, response.statusText!);
  //     //     print("successfully + ${response.body}");
  //     responseModel = ResponseModel(false, response.statusText!);
  //   } else {
  //     responseModel = ResponseModel(false, response.statusText!);
  //   }
  //   //   _isLoading = false;
  //   //   update();
  //   //   return responseModel;
  //   // }
  // }
}


