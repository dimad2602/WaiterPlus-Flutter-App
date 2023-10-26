import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/big_text.dart';
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
            BigText(
              text: 'Заказ скоро принесут к твоему столу №...?',
              bold: true,
            ),
            Center(
              child: SvgPicture.asset(
                'assets/images/table_order.svg',
                height: MediaQuery.of(context).size.height * 0.22,
                width: MediaQuery.of(context).size.width * 0.22,
              ),
            ),
            SizedBox(height: 16.0),
            BigText(
              text: 'Некоторый текст1',
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
