import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    //var iconColor; // не нужна
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
        // Может и не нужно
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFFD3AF9C),
          items: const [
            BottomNavigationBarItem(
                //Цвет хочеться какойнибуть прикольный
                icon: Icon(Icons.home, color: Color(0xFF79290C)),
                label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.question_mark), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.question_mark), label: ''),
          ],
        ),
        body: Padding(
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
              SizedBox(height: 25),
              //Random top10 items
              Expanded(
                child: ListView(scrollDirection: Axis.horizontal, children: [
                  TopDishesTitle(),
                ]),
              )
              //horizontal listview of items
            ],
          ),
        ));
  }
}
