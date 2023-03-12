import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/util/dishes_type.dart';
import 'package:flutter_project2/util/top10_dishes_title.dart';
import 'package:google_fonts/google_fonts.dart';

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

  // user tapped on deshes types metod
  void dishesTypeSelected(int index) {
    setState(() {
      for( int i = 0; i < dishesType.length; i++ ) {
        dishesType[i][1] = false;
      }
      dishesType[index][1] = true;
    });
  }

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
          backgroundColor: Color(0xFFD3AF9C),
          items: const [
            BottomNavigationBarItem(
              //Цвет хочеться какойнибуть прикольный
                icon: Icon(Icons.home, color: Color(0xFF79290C)),
                label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket), label: ''),
          ],
        ),
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
                            : Colors
                            .grey.shade600, // Theme.of(context).primaryColor
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
                //Random top10 items
                Container(
                  height: 380,
                    child: ListView(scrollDirection: Axis.horizontal, children: [
                      TopDishesTitle(
                        dishesImagePath: 'https://images.unsplash.com/photo-1593560708920-61dd98c46a4e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8cGl6emF8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
                        dishesPrice: '123',
                        dishesName: 'dfgdf dfgdfg dfg',
                      ),
                      TopDishesTitle(
                        dishesImagePath: 'https://images.unsplash.com/photo-1593560708920-61dd98c46a4e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8cGl6emF8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
                        dishesPrice: '123',
                        dishesName: 'dfgdf dfgdfg dfg',
                      ),
                      TopDishesTitle(
                        dishesImagePath: 'https://images.unsplash.com/photo-1593560708920-61dd98c46a4e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8cGl6emF8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
                        dishesPrice: '123',
                        dishesName: 'dfgdf dfgdfg dfg',
                      ),
                    ]),
                  ),
                //horizontal listview of items
              ],
            ),
          ),
        ));
  }
}
