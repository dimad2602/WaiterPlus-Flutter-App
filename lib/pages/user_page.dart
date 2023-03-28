import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key, required this.context}) : super(key: key);

  final BuildContext context;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pushNamed(widget.context, '/auth_page');
  }

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5ebdc),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 35.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: RichText(
                      text: TextSpan(
                          text: 'Hello, ',
                          style: const TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          children: <TextSpan>[
                        TextSpan(
                            text: user?.email ?? 'Guest',
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('Tap');
                              })
                      ])),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 2,
                ),
                _listTiles(
                    title: 'Профиль',
                    // subtitle: 'Subtitle',
                    icon: Icons.person,
                    onPressed: () {}),
                _listTiles(
                    title: 'Мои заказы', icon: Icons.history, onPressed: () {}),
                _listTiles(
                    title: 'Любимое', icon: Icons.favorite, onPressed: () {}),
                _listTiles(
                    title: 'Выйти из профиля',
                    icon: Icons.logout,
                    onPressed: () async {
                      await _showLogoutDialog();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showLogoutDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.exit_to_app, size: 20, weight: 20),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text('Sign out'),
                )
              ],
            ),
            content: Text('Do you want to sign out'),
            actions: [
              TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
              ),
              TextButton(
                onPressed: () {
                  // if (Navigator.canPop(context)) {
                  //   Navigator.pop(context);
                  // }
                  signUserOut();
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              ),
            ],
          );
        });
  }

  Widget _listTiles(
      {required String title,
      String? subtitle,
      required IconData icon,
      required Function onPressed}) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: title == 'Выйти из профиля' ? Color(0xFFd60000) : Colors.black,
        ),
      ),
      // subtitle: Text(
      //   subtitle ?? "",
      //   style: const TextStyle(fontSize: 15),
      // ),
      leading: Icon(icon,
          color: title == 'Выйти из профиля' ? Color(0xFFd60000) : null),
      trailing: const Icon(Icons.keyboard_arrow_right),
      onTap: () {
        onPressed();
      },
    );
  }
}
