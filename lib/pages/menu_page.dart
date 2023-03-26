import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/model/cart_model.dart';
import 'package:flutter_project2/util/dishes_type.dart';
import 'package:flutter_project2/util/top10_dishes_title.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../components/bottom_nav_bar.dart';
import '../components/grocery_item_title.dart';

List<TopDishesTitle> TopDishes() {
  List<TopDishesTitle> TopDishes = [
    TopDishesTitle(
      dishesImagePath:
      'https://images.unsplash.com/photo-1593560708920-61dd98c46a4e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8cGl6emF8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
      dishesPrice: '123',
      dishesName: 'name 111',
    ),
    TopDishesTitle(
      dishesImagePath:
      'https://images.unsplash.com/photo-1588315029754-2dd089d39a1a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fHBpenphfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
      dishesPrice: '200',
      dishesName: 'long name2 aaaaaaaa',
    ),
    TopDishesTitle(
      dishesImagePath:
      'https://images.unsplash.com/photo-1595854341625-f33ee10dbf94?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjB8fHBpenphfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
      dishesPrice: '300',
      dishesName: 'name3',
    ),
  ];
  return TopDishes;
}


class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  // для изменения цвета иконки поиска
  bool isFocused = false;

  //list of dishes types
  final List dishesType = [
    //[dishes type, isSelected]
    [
      'Pizza',
      true,
    ],
    [
      'Pasta',
      false,
    ],
    [
      'Salad',
      false,
    ],
    [
      'Soup',
      false,
    ],
  ];

  int _selectedIndex = 0;

  // static List<Widget> _pages = <Widget>[
  //   Text(
  //     'Index 0: Home',
  //   ),
  //   Text(
  //     'Index 1: Business',
  //   ),
  //   Text(
  //     'Index 2: School',
  //   ),
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
      //   Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => HomePage(),
      //   ));
      //   break;
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/menu_page');  //'/login_page'
        break;
      case 2:
        Navigator.pushNamed(context, '/cart_page');
        //Navigator.of(context).push(MaterialPageRoute(
        //onTap: () => Navigator.pushNamed(context, '/login_page'),
        //builder: (context) => ('/login_page'),
        break;
      default:
        break;
    }
  }

  // user tapped on deshes types metod
  void dishesTypeSelected(int index) {
    setState(() {
      for (int i = 0; i < dishesType.length; i++) {
        dishesType[i][1] = false;
      }
      dishesType[index][1] = true;
    });
  }

  final List<TopDishesTitle> _topDishes = TopDishes();


  // List<TopDishesTitle> getTopDishes() {
  //   return _topDishes
  // }

  int _selectedIndexBottonBar = 1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFD3AF9C),
        appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
            //Colors.grey[700],
            // Это может быть выдвигающееся меню с контактами
            title: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Name',
                style: GoogleFonts.bebasNeue(
                  fontSize: 22,
                ),
              ),
            ),
            //Icon(Icons.logo_dev, size: 40),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.logo_dev, size: 40),
              )
            ]),
        // Переключение между меню и корзинкой нужно будет сделать
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFFD3AF9C),
          selectedItemColor: const Color(0xFF79290C),
          selectedLabelStyle: const TextStyle(fontSize: 14),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Главное',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Меню'),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket),
              label: 'Заказ',
            ),
          ],
          onTap: _onItemTapped,
          // appBar: AppBar(
          //   title: Text('Alo kuku'),
          //   centerTitle: true,
          //   actions: [IconButton(onPressed: _menuOpen,
          //       icon: Icon(Icons.menu_sharp))
          //   ],
          // ),
        ),
        // bottomNavigationBar: MyBottomNavBar(
        // ),
        // bottomNavigationBar: Container(
        //   child:  GNav(
        //       color: Color(0xFF57382F),
        //       activeColor: Color(0xFFd82300),
        //       backgroundColor: Colors.transparent,
        //       //tabActiveBorder: Border.all(color: Color(0xFFD3AF9C)),
        //       // tabBackgroundColor: Color(0xFFDCA179),
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       //onTabChange: (value) => onTabChanged!(value),
        //       tabs: [
        //         //GButton(icon: Icons.home, text: 'Начало',), //Главное
        //         GButton(
        //           icon: Icons.menu_book,
        //           text: 'Меню',
        //           onPressed: () => Navigator.pushNamed(context, '/menu_page',
        //               arguments: {'selectedTabIndex': _onItemTapped}),
        //         ),
        //         GButton(
        //             icon: Icons.shopping_basket,
        //             text: 'Корзина',
        //             onPressed: () => Navigator.pushNamed(context, '/cart_page',
        //                 arguments: {'selectedTabIndex': _onItemTapped}))
        //         //Может по другому назвать?
        //       ]),
        // ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              children: [
                //Кухня бар Кнопки
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: OutlinedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromRGBO(
                                  200, 200, 200, 0.5) /*Colors.grey[600]*/),
                          side: MaterialStateProperty.all(
                              BorderSide(color: Colors.black, width: 1)),
                          // set border side to red with width of 1
                          minimumSize: MaterialStateProperty.all(Size(140, 40)),
                          // set width to 150
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Kitchen",
                          style: GoogleFonts.bebasNeue(
                              fontSize: 22, color: Colors.black),
                        ),
                      ),
                    ),
                    Container(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromRGBO(
                                  200, 200, 200, 0.5) /*Colors.grey[600]*/),
                          // set background color to blue
                          side: MaterialStateProperty.all(
                              BorderSide(color: Colors.black, width: 1)),
                          // set border side to red with width of 1
                          minimumSize: MaterialStateProperty.all(Size(140, 40)),
                          // set width to 150
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        ),
                        child: Text(
                          // Шрифт кирилицу не поддерживает
                          'Bar',
                          style: GoogleFonts.bebasNeue(
                              fontSize: 22, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),

                //Search? // поменять местами с кнопками?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        //Статичный цвет иконки
                        // color: Colors.white,
                        //Цвет меняеться от фокуса
                        color: isFocused
                            ? Colors.black
                            : Colors.grey
                            .shade600, // Theme.of(context).primaryColor
                      ),
                      hintText: 'Search',
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: Colors.black,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.grey.shade600,
                          )),
                    ),
                    // Изменение цвета иконки во время фокуса
                    onTap: () {
                      setState(() {
                        isFocused = true;
                      });
                    },
                    onSubmitted: (_) {
                      setState(() {
                        isFocused = false;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                // Types of dishes // возможно не нужно, можно будет перенести в другое место
                Container(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dishesType.length,
                    itemBuilder: (context, index) {
                      return DishesType(
                          dishesType: dishesType[index][0],
                          isSelected: dishesType[index][1],
                          onTap: () {
                            dishesTypeSelected(index);
                          });
                    },
                  ),
                ),
                // //Random top10 items
                // Container(
                //   height: 380,
                //   child: ListView.builder(
                //     itemCount: _topDishes.length,
                //     scrollDirection: Axis.horizontal,
                //     itemBuilder: (BuildContext context, int index) {
                //       final dish = _topDishes[index];
                //       return TopDishesTitle(
                //         dishesImagePath: dish.dishesImagePath,
                //         dishesPrice: dish.dishesPrice,
                //         dishesName: dish.dishesName,
                //       );
                //     },
                //   ),
                // ),
                //horizontal listview of items
                Container(
                  height: 380,
                  child: Consumer<CartModel>(
                          builder: (context, value, child) {
                            //return GridView.builder(
                            return ListView.builder(
                              itemCount: _topDishes.length,
                              scrollDirection: Axis.horizontal,
                              // Выбираем как хранить элементы, 2 учейки в ряд
                              // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              //     crossAxisCount: 1),
                              itemBuilder: (context, index) {
                                return GroceryItemTitle(
                                  itemName: value.shopItems[index].dishesName,
                                  itemPrice: value.shopItems[index].dishesPrice,
                                  imagePath: value.shopItems[index].dishesImagePath,
                                  onPressed: (){
                                    Provider.of<CartModel>(context, listen: false)
                                        .addItemToCart(index);
                                  },
                                );
                              },
                            );
                          },
                        ),
                )

                // Expanded(
                //     child: Consumer<CartModel>(
                //       builder: (context, value, child) {
                //         return GridView.builder(
                //           // Выбираем как хранить элементы, 2 учейки в ряд
                //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //               crossAxisCount: 2),
                //           itemBuilder: (context, index) {
                //             return GroceryItemTitle(
                //               itemName: value.shopItems[index].dishesName,
                //               itemPrice: value.shopItems[index].dishesPrice,
                //               imagePath: value.shopItems[index].dishesImagePath,
                //             );
                //           },
                //         );
                //       },
                //     ),
                // )
              ],
            ),
          ),
        ));
  }
}
