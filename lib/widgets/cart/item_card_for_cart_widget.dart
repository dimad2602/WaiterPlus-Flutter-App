import 'package:flutter/material.dart';

import '../../util/constants.dart';

//TODO: Больше не использую
class ItemCardForCartWidget extends StatelessWidget {
  final String testName;
  final String imagePath;
  final String itemCosts;

  ItemCardForCartWidget({
    required this.testName,
    required this.imagePath,
    required this.itemCosts,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: Constants.height20*7,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            // Изображение слева в верхней части карточки
            Positioned(
              top: 0,
              left: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular( Constants.radius20),
                child: Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                  width: Constants.width20*5,
                  height: Constants.height20*5,
                ),
              ),
            ),
            // Название блюда и цена справа
            Positioned(
              top: 10,
              right: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    testName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    itemCosts,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            // Дублированная цена в нижней части карточки
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
        ),
      ),
    );
  }
}


