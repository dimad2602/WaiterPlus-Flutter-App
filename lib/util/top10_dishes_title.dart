import 'package:flutter/material.dart';

class TopDishesTitle extends StatelessWidget {
  const TopDishesTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, bottom: 25),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          //Хочеться слабо прозрачный черный // Хотя цвет с цифрой, очень не плох
          color: Colors.white38,
        ),
        child: Column(
          //Делаем надпись слева
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Image pizza
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
              child: Image.asset('lib/images/pizzajpg1.jpg'),
            ),
            // Pizza name
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.0, top: 4.0),
                    child: Text(
                      'Namedsfghjghjghjghjghjghjghjghjghjghjghj',
                      // Сокрашение текста до ...
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 4.0, top: 4.0),
                  child: Text(
                    '123\$\$\$',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
