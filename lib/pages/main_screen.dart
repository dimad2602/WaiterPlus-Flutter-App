import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key, required this.context}) : super(key: key);

  final BuildContext context;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final user = FirebaseAuth.instance.currentUser;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pushNamed(widget.context, '/auth_page');
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(widget.context, '/restaurant_page');
        break;
      case 1:
        Navigator.pushNamed(widget.context, '/menu_page'); //'/login_page'
        break;
      case 2:
        Navigator.pushNamed(widget.context, '/cart_page');
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFD3AF9C),
        // appBar: AppBar(
        //   title: Text('kuku'),
        //   centerTitle: true,
        //   actions: [
        //     IconButton(
        //         onPressed: () {
        //           signUserOut();
        //           print('dfdeeeee');
        //         },
        //         icon: Icon(Icons.logout))
        //   ],
        // ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: false,
          title: const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.logo_dev,
                size: 35,
                color: Colors.black87,
              )),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/user_page');
                  },
                  icon: const Icon(
                    Icons.person_outline,
                    size: 35,
                    color: Colors.black87,
                  )),
            )
          ],
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: 0,
        //   type: BottomNavigationBarType.fixed,
        //   backgroundColor: const Color(0xFFD3AF9C),
        //   selectedItemColor: const Color(0xFF79290C),
        //   selectedLabelStyle: const TextStyle(fontSize: 14),
        //   unselectedLabelStyle: const TextStyle(fontSize: 12),
        //   items: const [
        //     BottomNavigationBarItem(
        //         //Цвет хочеться какойнибуть прикольный
        //         icon: Icon(Icons.home),
        //         label: 'Главное'),
        //     BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Меню'),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.shopping_basket),
        //       label: 'Заказ',
        //     ),
        //   ],
        //   onTap: _onItemTapped,
        // ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 35.0),
              child: Center(
                  child: Text(
                "Settings",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              )),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                //Navigator.pushNamed(context, '/');
                Navigator.pushNamed(context, '/restaurant_page');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text('Заведения',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  ),
                ),
              ),
            ),
            // const Text(
            //   'Main screen',
            //   style: TextStyle(fontSize: 20, color: Colors.white),
            // ),
            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.pushNamed(context, '/todo');
            //       //Navigator.pushNamedAndRemoveUntil(context, '/todo', (route) => false); //отключение стрелки назад
            //       //Navigator.pushReplacementNamed(context, '/todo');
            //     },
            //     style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.purple,
            //         padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            //         textStyle:
            //             TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            //     child: //Text('Заметки'),
            //         const Icon(
            //       Icons.note_alt_rounded,
            //       color: Colors.lightBlueAccent,
            //       size: 40,
            //     )),
            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.pushNamed(context, '/login_page');
            //     },
            //     child: const Icon(
            //       Icons.login,
            //       color: Colors.tealAccent,
            //       size: 40,
            //     )),
            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.pushNamed(context, '/menu_page');
            //     },
            //     child: const Icon(
            //       Icons.restaurant_menu,
            //       color: Colors.tealAccent,
            //       size: 40,
            //     )),
            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.pushNamed(context, '/restaurant_page');
            //     },
            //     child: const Icon(
            //       Icons.maps_home_work,
            //       color: Colors.tealAccent,
            //       size: 40,
            //     )),
            ElevatedButton(
                onPressed: () {
                  //Navigator.pushNamed(context, '/get_material_app');
                  //Navigator.pushNamed(context, '/splash_screen');
                  Navigator.pushNamed(context, '/firerestaurant_page');
                  //splash_screen
                },
                child: const Icon(
                  Icons.restaurant,
                  color: Colors.tealAccent,
                  size: 40,
                )),
            /*ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/get_material_app');
                  //splash_screen
                },
                child: const Icon(
                  Icons.get_app,
                  color: Colors.tealAccent,
                  size: 40,
                )),*/
          ],
        ));
  }
}
