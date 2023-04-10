import 'package:flutter/material.dart';
import 'package:flutter_project2/pages/auth_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () async {
      await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthPage()),);
      //Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Image.asset("assets/images/qr-menu.png",
        width: 200,
        height: 200),
      ),
    );
  }
}
