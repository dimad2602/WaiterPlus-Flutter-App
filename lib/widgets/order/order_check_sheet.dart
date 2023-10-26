import 'package:flutter/material.dart';

import '../../util/constants.dart';

void showCustomBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Center(
              /*child: Image.asset(
                "assets/images/table_order.jpg",
                height: 100,
              ),*/

            ),
            Image.asset(
              'assets/images/tO.png',
              width: Constants.width20 * 10,
              height: Constants.height20 * 10,
            ),
            SizedBox(height: 16.0),
            Text(
              'Некоторый текст1',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8.0),
            Text(
              'Ещё некоторый текст',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    },
  );
}
