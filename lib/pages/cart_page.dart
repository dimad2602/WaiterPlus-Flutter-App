import 'package:flutter/material.dart';
import 'package:flutter_project2/pages/login_page.dart';
import 'package:flutter_project2/pages/qr_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import '../components/bottom_nav_bar.dart';
import '../model/cart_model.dart';

// раньше было stateless
class CartPage extends StatefulWidget // StatelessWidget
{
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with TickerProviderStateMixin {

  int _selectedIndex = 0;

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
        Navigator.pushNamed(context, '/menu_page'); //'/login_page'
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD3AF9C),
      // стрелку назад я бы поменял по дизайну
      appBar: AppBar(
          //automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          // Делает иконки черными
          //iconTheme: IconThemeData(color: Colors.black),
          //Colors.grey[700],
          // Это может быть выдвигающееся меню с контактами
          title: Text(
            'Name',
            style: GoogleFonts.bebasNeue(
              fontSize: 22,
            ),
          ),
          //Icon(Icons.logo_dev, size: 40),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.logo_dev, size: 40),
            )
          ]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFD3AF9C),
        selectedItemColor: const Color(0xFF79290C),
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: const [
          BottomNavigationBarItem(
            //Цвет хочеться какойнибуть прикольный
              icon: Icon(Icons.home),
              label: 'Главное'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Меню'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Заказ',
          ),
        ],
        onTap: _onItemTapped,
      ),
      // bottomNavigationBar: MyBottomNavBar(
      //   //onTabChanged: (index) => _onItemTapped(index)//_onItemTapped,
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
      body: Consumer<CartModel>(builder: (context, value, child) {
        return Column(
          children: [
            // list of cart items
            Expanded(
              child: ListView.builder(
                itemCount: value.cartItems.length,
                padding: EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(8)),
                      child: ListTile(
                        leading: AspectRatio(
                          aspectRatio: 11 / 11,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              topRight: Radius.circular(12.0),
                              bottomLeft: Radius.circular(12.0),
                              bottomRight: Radius.circular(12.0),
                            ),
                            child: FadeInImage.assetNetwork(
                              height: 100,
                              fit: BoxFit.fill,
                              image: value.cartItems[index].dishesImagePath,
                              placeholder: 'lib/images/LoadingBall.gif',
                            ),
                          ),
                        ),
                        title: Text(
                          value.cartItems[index].dishesName,
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          value.cartItems[index].dishesPrice + '\$',
                          style: TextStyle(fontSize: 16),
                        ),
                        trailing: IconButton(
                            color: Colors.red,
                            icon: Icon(Icons.close),
                            onPressed: () =>
                                Provider.of<CartModel>(context, listen: false)
                                    .removeItemFromCart(index)),
                      ),
                    ),
                  );
                },
              ),
            ),
            // total Price
            Padding(
              padding: const EdgeInsets.all(36.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFF88A763),
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Price',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          value.calculateTotalPrice() + '\$',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    // place an order button
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green.shade100),
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.all(12),
                      child: const Row(
                        children: [
                          Text(
                            "Оформить",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.white,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  //   _startAnimation();
  //   switch (index) {
  //     case 0:
  //       //   Navigator.of(context).push(MaterialPageRoute(
  //       //     builder: (context) => HomePage(),
  //       //   ));
  //       //   break;
  //       Navigator.pushNamed(context, '/');
  //       break;
  //     case 1:
  //       Navigator.pushNamed(context, '/menu_page'); //'/login_page'
  //       break;
  //     case 2:
  //       Navigator.pushNamed(context, '/cart_page');
  //       //Navigator.of(context).push(MaterialPageRoute(
  //       //onTap: () => Navigator.pushNamed(context, '/login_page'),
  //       //builder: (context) => ('/login_page'),
  //       break;
  //     default:
  //       break;
  //   }
  // }
}
