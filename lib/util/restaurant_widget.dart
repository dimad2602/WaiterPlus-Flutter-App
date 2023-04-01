import 'package:flutter/material.dart';

class RestaurantWidget extends StatelessWidget {
  //const RestaurantWidget({Key? key}) : super(key: key);

  final String restaurantImagePath;
  final String restaurantName;
  final String restaurantCosts;
  final String restaurantWorktime;
  final String restaurantAddr;
  final String restaurantMenuPath;

  RestaurantWidget({
    required this.restaurantImagePath,
    required this.restaurantName,
    required this.restaurantCosts,
    required this.restaurantWorktime,
    required this.restaurantAddr,
    required this.restaurantMenuPath,
  });

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          height: _screenWidth * 0.71,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
            //Хочеться слабо прозрачный черный // Хотя цвет с цифрой, очень не плох
            //color: Colors.white38,
            color: Color(0xffffffff),
            border: Border.all(color: Colors.black.withOpacity(0.7), width: 2),
          ),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: _screenWidth * 0.69,
                width: _screenWidth * 0.9,
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //         image: AssetImage(restaurantImagePath), fit: BoxFit.fill)),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ClipRRect(
                    //     borderRadius: const BorderRadius.only(
                    //       topLeft: Radius.circular(12.0),
                    //     ),
                    //     child: FadeInImage.assetNetwork(
                    //       //Шарик загрузки
                    //       placeholder: 'lib/images/Loadingaaa.gif',
                    //       image: restaurantImagePath,
                    //       height: 200,
                    //       width: _screenWidth * 0.9,
                    //       fit: BoxFit.cover, // BoxFit.fill,
                    //     )),
                    Stack(
                      children: [
                        Container(
                          height: 200,
                          width: _screenWidth * 0.9,
                        ),
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                          ),
                          child: FadeInImage(
                            placeholder: AssetImage('lib/images/LoadingCircle.gif'),
                            image: NetworkImage(restaurantImagePath),
                            height: 200,
                            width: _screenWidth * 0.9,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            restaurantName,
                            style: TextStyle(fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Text(
                              restaurantCosts,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black45),
                            ),
                          ),
                          // Ещё можно добавить оценку
                        ],
                      ),
                    ),
                    //const SizedBox(height: 10),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.access_time_filled, size: 20, ),
                                  Text(restaurantWorktime, style: TextStyle(fontSize: 17),),
                                ],
                              )
                              // Ещё можно добавить
                              //Text('Время до закрытия'),
                            ],
                          ),
                        ),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.only(right: 15.0),
                        //       child: Row(
                        //         children: [
                        //           Icon(Icons.room),
                        //           Text(restaurantAddr,
                        //             // // Сокрашение текста до ...
                        //             // overflow: TextOverflow.ellipsis,
                        //             // //Без переноса - 1 строчка
                        //             // maxLines: 1,
                        //             style: TextStyle(
                        //               fontSize: 17,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     )
                        //   ],
                        // ),
                        SizedBox(width: 60),
                        Icon(Icons.room),
                        Flexible(
                          child: Padding(
                            padding:
                            EdgeInsets.only(left: 8.0, right: 15),
                            child:
                            Text(
                              restaurantAddr,
                              // Сокрашение текста до ...
                              overflow: TextOverflow.ellipsis,
                              //Без переноса - 1 строчка
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
