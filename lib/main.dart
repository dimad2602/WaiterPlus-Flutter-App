import 'package:flutter/material.dart';
import 'package:flutter_project2/controllers/cart_controller/cart_controller.dart';
import 'package:flutter_project2/controllers/items_controller/item_detail_controller.dart';
import 'package:flutter_project2/controllers/popular_product_controller.dart';
import 'package:flutter_project2/data/repository/cart_repo.dart';
import 'package:flutter_project2/data_uploader_screen.dart';
import 'package:flutter_project2/pages/auth_page.dart';
import 'package:flutter_project2/pages/cart/cart_page_fire.dart';
import 'package:flutter_project2/pages/cart_page.dart';
import 'package:flutter_project2/pages/food/top_food_detail.dart';
import 'package:flutter_project2/pages/home.dart';
import 'package:flutter_project2/pages/login/login_or_register_page.dart';
import 'package:flutter_project2/pages/login/login_page.dart';
import 'package:flutter_project2/pages/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_project2/pages/menu/menu_overview_page.dart';
import 'package:flutter_project2/pages/menu_page.dart';
import 'package:flutter_project2/pages/order/order_incoming.dart';
import 'package:flutter_project2/pages/qr_page.dart';
import 'package:flutter_project2/pages/login/register_page.dart';
import 'package:flutter_project2/pages/splash/splash_new_page.dart';
import 'package:flutter_project2/pages/splash/splash_screen.dart';
import 'package:flutter_project2/pages/user_page.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bindings.dart';
import 'controllers/menu_controller/menu_controller.dart';
import 'controllers/restaurants_controlelr/restaurant_detail_controller.dart';
import 'controllers/restaurants_controlelr/restaurant_paper_controller.dart';
import 'pages/menu/menu_fire_page.dart';
import 'pages/menu_rest2_page.dart';
import 'pages/order/order_history.dart';
import 'pages/restaurant_page.dart';
import 'pages/restaurants/restaurant_detail_page.dart';
import 'pages/restaurants/restaurant_fire_page.dart';
import 'services/firebase_storage_service.dart';
import 'util/top10_dishes_title.dart';
import 'model/cart_model.dart';
import 'helper/dependencies.dart' as dep;

/*Future<void> init() async {

  Get.lazyPut(() => CartRepo(sharedPreferences:Get.find()));
}*/

void main() async {
  /*final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);*/
  WidgetsFlutterBinding.ensureInitialized();
  //await dep.init();
  await Firebase.initializeApp();
  //Get.find<CartController>().getCartData();
  //Get.find<PopularProductController>().getPopularProductList();
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.deepPurpleAccent,
          pageTransitionsTheme: PageTransitionsTheme(
            // Анимеция перехода
            builders: {
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),
        ),
        initialRoute: '/splash_screen', //'/auth_page',

        routes: {
          '/': (context) => MainScreen(context: context,),
          '/auth_page': (context) => AuthPage(),
          '/todo': (context) => Home(),
          '/login_page': (context) => LoginPage(),
          '/login_or_register_page': (context) => LoginOrRegisterPage(),
          '/register_page': (context) => RegisterPage(),
          '/menu_page': (context) => MenuPage(),
          '/menu_rest2_page': (context) => MenuRest2Page(),
          '/cart_page': (context) => CartPage(),
          '/qr_page': (context) => QrPage(),
          '/user_page': (context) => UserPage(context: context,),
          '/restaurant_page': (context) => RestaurantPage(),
          '/top_food_detail_page': (context) {
            return TopFoodDetailPage();
          },
          '/get_material_app': (context) => DataUploaderScreen(),
          '/splash_screen': (context) {
            //OLD
            /*Get.put(FirebaseStorageService());
            Get.put(RestaurantPaperController());
            Get.put(MenuPaperController());
            Get.put(ItemDetailController());
            Get.put(CartController());*/
            return SplashPage();
            // OLD
           // return SplashScreen();
          },
          '/firerestaurant_page': (context) {
            //Get.put(FirebaseStorageService());
            //Get.put(RestaurantPaperController());
            return RestaurantFirePage();
          },
          '/firerestaurantdetail_page': (context) {
            //Get.put(FirebaseStorageService());
            //Get.put(RestaurantPaperController());


            //Get.put(RestaurantDetailController());
            return RestaurantDetailPage();
          },
          '/firemenu_page': (context) {
            //Get.put(FirebaseStorageService());
            //Get.put(RestaurantPaperController());
            //Get.put(MenuPaperController());
            return MenuFirePage();
          },
          '/menuoverview': (context) {
            //Get.put(MenuPaperController());
            return MenuOverviewPage();
          },
          '/cart_fire_page': (context) {
            return CartPageFire();
          },
          '/order_history': (context) {
            return OrderHistory();
          },
          '/order_incoming': (context) {
            return OrderIncoming();
          },
        },
      ),
    ),
  );
}




// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => CartModel(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           primaryColor: Colors.deepPurpleAccent,
//         ),
//         initialRoute: '/auth_page',
//         routes: {
//           '/': (context) => MainScreen(context: context,),
//           '/auth_page': (context) => AuthPage(),
//           '/todo': (context) => Home(),
//           '/login_page': (context) => LoginPage(),
//           '/login_or_register_page': (context) => LoginOrRegisterPage(),
//           '/register_page': (context) => RegisterPage(),
//           '/menu_page': (context) => MenuPage(),
//           '/menu_rest2_page': (context) => MenuRest2Page(),
//           '/cart_page': (context) => CartPage(),
//           '/qr_page': (context) => QrPage(),
//           '/user_page': (context) => UserPage(context: context,),
//           '/restaurant_page': (context) => RestaurantPage(),
//           '/top_food_detail_page': (context) => TopFoodDetailPage(),
//         },
//       ),
//     ),
//   );
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(
//     theme: ThemeData(
//       primaryColor: Colors.deepPurpleAccent,
//       // brightness: Brightness.dark
//     ),
//     //home: Home(),
//     initialRoute: '/',
//     routes: {
//       '/': (context) => MainScreen(),
//       '/todo': (context) => Home(),
//       '/login_page': (context) => LoginPage(),
//       '/menu_page': (context) => MenuPage(),
//     },
//   ));
// }

