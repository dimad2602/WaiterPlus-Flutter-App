// import 'package:flutter_project2/data/repository/popular_product_repo.dart';
// import 'package:get/get.dart';
//
// import '../models/restaurants_model.dart';
//
// class PopularProductController extends GetxController {
//   final PopularProductRepo popularProductRepo;
//
//   PopularProductController({required this.popularProductRepo});
//
//   List<dynamic> _popularProductList = [];
//   List<dynamic> get popularProductList => _popularProductList;
//   Future<void> getPopularProductList() async{
//     Response response = await popularProductRepo.getPopularProductList();
//     if(response.statusCode == 200){
//       print("got menu");
//       _popularProductList=[];
//       _popularProductList.addAll(Restaurant.fromJson(response.body).menu);
//       update(); // like a setState
//     }else{
//
//     }
//   }
// }
