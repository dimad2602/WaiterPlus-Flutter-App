import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../components/Small_text.dart';
import '../../components/big_text.dart';
import '../../util/AppColors.dart';
import '../../util/constants.dart';

class CardForCartWidget extends StatelessWidget {
  final String itemName;
  final String imagePath;
  final String itemCosts;
  final String itemWeight;

  CardForCartWidget({
    required this.itemName,
    required this.imagePath,
    required this.itemCosts,
    required this.itemWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.maxFinite,
          height: Constants.height20 * 7,
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(Constants.radius20),
          ),
        ),
        Container(
            width: double.maxFinite,
            height: Constants.height20 * 5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.radius20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: Constants.height20 * 5,
                      height: Constants.height20 * 5,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(imagePath)),
                          borderRadius: BorderRadius.circular(
                              Constants.radius20),
                          color: Colors.white),
                    ),
                    SizedBox(
                      width: Constants.width10,
                    ),
                    Expanded(
                        child: Container(
                          height: Constants.height20 * 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              BigText(
                                text: itemName,
                                color: Colors.black87,
                              ),
                              SmallText(text: itemWeight),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: Constants.height10,
                                        bottom: Constants.height10,
                                        left: Constants.width10,
                                        right: Constants.width10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Constants.radius20),
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            //Item.setQuantity(false);
                                          },
                                          child: const Icon(
                                            Icons.remove,
                                            color: Colors.black45,
                                          ),
                                        ),
                                        SizedBox(
                                          width: Constants.width10 / 2,
                                        ),
                                        BigText(text: "0"),
                                        //Item.inCartItems.toString()),
                                        SizedBox(
                                          width: Constants.width10 / 2,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            //Item.setQuantity(true);
                                          },
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.black45,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                        right: Constants.width10,
                                      ),
                                      child: BigText(
                                        text: "\$ ${itemCosts}",
                                        color: AppColors.redColor,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ))
                  ],
                )
              ],
            ),
        ),
      ],
    );

    /*child:
    Container(
      width: double.maxFinite,
      height: Constants.height20 * 4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Constants.radius20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      */ /*child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Текст в верхнем контейнере',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey,
                child: Center(
                  child: Text(
                    'Текст в нижнем контейнере',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),*/ /*
    )
    ,
    );*/


    /*Stack(
      children: [
        Column(
          children: [
            Row(
              children: [
                Card(
                    color: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Constants.radius20),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: Constants.height20 * 5,
                              height: Constants.height20 * 5,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: CachedNetworkImageProvider(
                                        imagePath,
                                      )),
                                  borderRadius:
                                      BorderRadius.circular(Constants.radius20),
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: Constants.width10,
                            ),
                            Container(
                              height: Constants.height20 * 5,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BigText(
                                      text: itemName,
                                      color: Colors.black87,
                                    ),
                                  ]),
                            ),
                          ],
                        )
                      ],
                    )
                ),
              ],
            ),
            Positioned.fill(
              bottom: 0,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: Colors.black.withOpacity(0.6),
                  ),
                  child: Center(
                    child: Text(
                      itemCosts,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );*/

    /*Container(
      height: Constants.height20 * 7,
      width: double.maxFinite,
      margin: const EdgeInsets.only(bottom: 15),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: Constants.height20 * 5,
                height: Constants.height20 * 5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          imagePath,
                        )),
                    borderRadius: BorderRadius.circular(Constants.radius20),
                    color: Colors.white),
              ),
              SizedBox(
                width: Constants.width10,
              ),
              Expanded(
                  child: Container(
                    height: Constants.height20 * 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(
                          text: itemName,
                          color: Colors.black87,
                        ),
                        SmallText(text: itemWeight),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  top: Constants.height10,
                                  bottom: Constants.height10,
                                  left: Constants.width10,
                                  right: Constants.width10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Constants.radius20),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      //Item.setQuantity(false);
                                    },
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Constants.width10 / 2,
                                  ),
                                  BigText(text: "0"),
                                  //Item.inCartItems.toString()),
                                  SizedBox(
                                    width: Constants.width10 / 2,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      //Item.setQuantity(true);
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                  right: Constants.width10,
                                ),
                                child: BigText(
                                  text: "\$ ${itemCosts}",
                                  color: AppColors.redColor,
                                )),
                          ],
                        )
                      ],
                    ),
              )),
            ],
          ),
          Container(
            color: Colors.grey[200],
            child: Row(
              children: [
                Text("Total"),
              ],
            ),
          ),
        ],
      ),
    );*/
  }
}
