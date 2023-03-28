import 'package:flutter/material.dart';

import '../components/app_bar.dart';


class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFf5ebdc),
      appBar: MyAppBar(),
      body: Text('fgf')
    );
  }
}
