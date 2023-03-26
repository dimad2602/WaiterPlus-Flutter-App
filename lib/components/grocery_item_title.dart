import 'package:flutter/material.dart';

class GroceryItemTitle extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String imagePath;

  void Function()? onPressed;

  GroceryItemTitle(
      {Key? key,
      required this.itemName,
      required this.itemPrice,
      required this.imagePath,
      required this.onPressed})
      : super(key: key);

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
          color: Colors.white54,
        ),
        child: Column(
          //Делаем надпись слева
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Image pizza
            //Установка соотношения сторон
            GestureDetector(
              // Тут должен быть переход на страницу блюда, пока болванка
              onTap: () => Navigator.pushNamed(context, '/login_page'),
              child: AspectRatio(
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
                    image: imagePath,
                    fit: BoxFit.cover,
                  ),
                  //Картинка из папки. Это просто подсказка
                  //Image.asset('lib/images/pizzajpg1.jpg', fit: BoxFit.cover),
                ),
              ),
            ),

            // Pizza name
            Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 8.0, top: 8.0, bottom: 4),
                          child: Text(
                            itemName,
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
                            EdgeInsets.only(right: 8.0, top: 8.0, bottom: 4),
                        //padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        child: Text(
                          itemPrice + '\$',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ]),
                // const SizedBox(
                //   height: 4,
                // ),
                // Weight and plus button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
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
                          GestureDetector(
                            // Тут должно быть добваление блюда в корзину,
                            // ну и хотелось бы отобразить то что мы его добавили, пока болванка
                            //onTap: () => Navigator.pushNamed(context, '/login_page'),
                            // onTap: () =>
                            //     Provider.of<CartModel>(context, listen: false)
                            //         .addItemToCart(0),
                            //.removeItemFromCart(0),
                            // child: Container(
                              // padding: EdgeInsets.all(4),
                              // //Цвет не знаю какой выбрать
                              // decoration: BoxDecoration(
                              //     color: Colors.green[400],
                              //     borderRadius: BorderRadius.circular(6)),
                              child: IconButton(
                                  iconSize: 40,
                                  // такой себе цвет
                                  color: Colors.green,
                                  onPressed: onPressed,
                                  icon: Icon(Icons.add_circle_outline_rounded)),
                            ),
                          //)
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
