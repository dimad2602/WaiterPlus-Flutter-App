import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  //void Function(int)? onTabChanged;
  MyBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GNav(
          color: Color(0xFF57382F),
          activeColor: Color(0xFFd82300),
          backgroundColor: Colors.transparent,
          //tabActiveBorder: Border.all(color: Color(0xFFD3AF9C)),
          // tabBackgroundColor: Color(0xFFDCA179),
          mainAxisAlignment: MainAxisAlignment.center,
          //onTabChange: (value) => onTabChanged!(value),
          tabs: [
            //GButton(icon: Icons.home, text: 'Начало',), //Главное
            GButton(
              icon: Icons.menu_book,
              text: 'Меню',
              onPressed: () => Navigator.pushNamed(context, '/menu_page',),
            ),
            GButton(
                icon: Icons.shopping_basket,
                text: 'Корзина',
                onPressed: () => Navigator.pushNamed(context, '/cart_page',))
            //Может по другому назвать?
          ]),
    );
  }
}
