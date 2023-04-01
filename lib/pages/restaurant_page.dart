import 'package:flutter/material.dart';
import 'package:flutter_project2/util/category_circle_rest.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/app_bar.dart';
import '../util/restaurant_widget.dart';

List<RestaurantWidget> RestaurantPlace() {
  List<RestaurantWidget> RestaurantPlace = [
    RestaurantWidget(
      restaurantImagePath:
          'https://images.unsplash.com/photo-1625173617202-af15666696d0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80',
      restaurantName: 'Name1',
      restaurantCosts: '\$\$',
      restaurantWorktime: '8:00-22:00',
      restaurantAddr: 'Address1',
      restaurantMenuPath: '',
    ),
    RestaurantWidget(
      restaurantImagePath:
          'https://www.candybar.co/wp-content/uploads/2019/07/image39.jpg',
      restaurantName: 'Name2',
      restaurantCosts: '\$\$\$',
      restaurantWorktime: '8:00-23:00',
      restaurantAddr: 'long Address2 >>>>>>>>>>>>>>>>>>>>>>>>>>>',
      restaurantMenuPath: '',
    ),
    RestaurantWidget(
      restaurantImagePath:
          'https://www.candybar.co/wp-content/uploads/2019/07/image84.jpg',
      restaurantName: 'Name3',
      restaurantCosts: '\$\$',
      restaurantWorktime: '8:00-23:30',
      restaurantAddr: 'Address3 >>>>>>>>>>>>>>>>>>>>>>>>>>>',
      restaurantMenuPath: '',
    ),
  ];
  return RestaurantPlace;
}

List<CategoryCircleWidget> CategoryCircle() {
  List<CategoryCircleWidget> CategoryCircle = [
    CategoryCircleWidget(
      categoryImagePath:
          'https://cdn-icons-png.flaticon.com/512/562/562678.png',
      categoryName: 'Все',
    ),
    CategoryCircleWidget(
      categoryImagePath:
          'https://cdn-icons-png.flaticon.com/512/2515/2515157.png',
      categoryName: 'Тематическое',
    ),
    CategoryCircleWidget(
      categoryImagePath:
          'https://cdn-icons-png.flaticon.com/512/1047/1047544.png',
      categoryName: 'Кофейня',
    ),
    CategoryCircleWidget(
      categoryImagePath:
          'https://cdn-icons-png.flaticon.com/512/2494/2494278.png',
      categoryName: 'Пиццерия',
    ),
    CategoryCircleWidget(
      categoryImagePath:
          'https://cdn-icons-png.flaticon.com/512/4074/4074170.png',
      categoryName: 'Бургерная',
    ),
    CategoryCircleWidget(
      categoryImagePath:
          'https://cdn-icons-png.flaticon.com/512/701/701974.png',
      categoryName: 'ПП',
    ),
    CategoryCircleWidget(
      categoryImagePath:
          'https://cdn-icons-png.flaticon.com/512/3081/3081078.png',
      categoryName: 'Ресторан',
    ),
  ];
  return CategoryCircle;
}

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  final List<RestaurantWidget> _restaurantPlace = RestaurantPlace();

  final List<CategoryCircleWidget> _categoryCircle = CategoryCircle();

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xFFf5ebdc),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: false,
          title: const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.logo_dev,
                color: Colors.black,
                size: 35,
              )),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/qr_page');
                  },
                  icon: const Icon(
                    Icons.qr_code,
                    size: 35,
                    color: Colors.black,
                  )),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 150, //_screenWidth * 0.35,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categoryCircle.length,
                    itemBuilder: (context, index) {
                      return CategoryCircleWidget(
                        categoryImagePath:
                            _categoryCircle[index].categoryImagePath,
                        categoryName: _categoryCircle[index].categoryName,
                      );
                    }),
              ),
              ListView.builder(
                  // Позволяем перекрывать категории
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _restaurantPlace.length,
                  itemBuilder: (context, index) {
                    return RestaurantWidget(
                      restaurantImagePath:
                          _restaurantPlace[index].restaurantImagePath,
                      restaurantName: _restaurantPlace[index].restaurantName,
                      restaurantCosts: _restaurantPlace[index].restaurantCosts,
                      restaurantWorktime:
                          _restaurantPlace[index].restaurantWorktime,
                      restaurantAddr: _restaurantPlace[index].restaurantAddr,
                      restaurantMenuPath: '',
                    );
                  }),
            ],
          ),
        ));
  }
}
