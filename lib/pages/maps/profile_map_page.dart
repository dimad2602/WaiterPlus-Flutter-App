import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../util/constants.dart';

class ProfileMap extends StatelessWidget {
  const ProfileMap({Key? key}) : super(key: key);
  static const String routeName = "/profile_map_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(child: Container(
            padding: EdgeInsets.all(Constants.width10),
            child: const YandexMap(),
          ))
        ],
      ),
    );
  }
}
