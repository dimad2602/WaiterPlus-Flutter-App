import 'package:flutter/material.dart';

class TopDishesTitle extends StatelessWidget {
  final String dishesImagePath;
  final String dishesName;
  final String dishesPrice;

  TopDishesTitle(
      {required this.dishesImagePath,
        required this.dishesName,
        required this.dishesPrice});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, bottom: 30),
      child: Container(
        width: 200,
        //height: 300,
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
            //Установка соотношения сторон
            AspectRatio(
              aspectRatio: 7 / 9,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
                child:
                //Картинка из интеренета
                FadeInImage.assetNetwork(
                  //Шарик загрузки
                  placeholder: 'lib/images/LoadingBall.gif',
                  // тест другой картинки
                  //image: 'https://images.unsplash.com/photo-1588315029754-2dd089d39a1a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fHBpenphfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
                  image: dishesImagePath,
                  //'https://images.unsplash.com/photo-1593560708920-61dd98c46a4e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8cGl6emF8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
                  fit: BoxFit.cover,
                ),
                //Картинка из папки
                //Image.asset('lib/images/pizzajpg1.jpg', fit: BoxFit.cover),
              ),
            ),

            // Pizza name
            Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Padding(
                          padding:
                          EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8),
                          child: Text( dishesName,
                            // Сокрашение текста до ...
                            overflow: TextOverflow.ellipsis,
                            //Без переноса - 1 строчка
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                        EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8),
                        //padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        child: Text(
                          dishesPrice + '\$',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ]),
                const SizedBox(
                  height: 4,
                ),
                // Weight and plus button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 15,
                                width: 25,
                                child: Image.asset('lib/icons/kg.png'),
                              ),
                              Text(
                                ' 400.0 г',
                                style: TextStyle(
                                    color: Colors.grey[800], fontSize: 17),
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              padding: EdgeInsets.all(4),
                              //Цвет не знаю какой выбрать
                              decoration: BoxDecoration(color: Colors
                                  .green[400],
                                  borderRadius: BorderRadius.circular(6)),
                              child: Icon(Icons.add))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
