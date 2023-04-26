import 'package:flutter/material.dart';
import 'package:flutter_project2/components/app_icon.dart';

import '../../components/big_text.dart';
import '../../util/constants.dart';
import '../../util/expandable_text_widget.dart';
import '../../util/food_detail_text.dart';

class TopFoodDetailPage extends StatelessWidget {
  const TopFoodDetailPage({Key? key}) : super(key: key);
  static const String routeName = "/top_food_detail_page";

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    // final constants = Constants(
    //     screenHeight: MediaQuery.of(context).size.height,
    //     screenWidth: MediaQuery.of(context).size.width);
    return Scaffold(
      backgroundColor: Color(0xFFD3AF9C),
      body: Stack(
        children: [
          //background image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: _screenHeight / 2.41,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1593560708920-61dd98c46a4e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8cGl6emF8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
                        ))),
              )),
          //icon widgets
          Positioned(
              top: Constants.height45,
              left: Constants.width20,
              right: Constants.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(icon: Icons.arrow_back_ios, onTap: () {Navigator.pop(context);},),
                  AppIcon(icon: Icons.shopping_cart_outlined, onTap: () {Navigator.pushNamed(context, '/cart_page');},)
                ],
              )),
          //introduction of food
          Positioned(
              left: 0,
              right: 0,
              //Если поставить bottom: 0, то элемент будет на всю длину экрана
              bottom: 0,
              top: Constants.popularFoodImgSize - 20,
              child: Container(
                  padding: EdgeInsets.only(
                      left: Constants.width20,
                      right: Constants.width20,
                      top: Constants.height20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Constants.radius20),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FoodDetailtextWidget(
                        foodName: 'Название',
                      ),
                      SizedBox(
                        height: Constants.height20,
                      ),
                      BigText(
                        text: 'Описание',
                      ),
                      SizedBox(
                        height: Constants.height20,
                      ),
                      //expandeble text widget
                      Expanded(child: SingleChildScrollView(child: ExpandableTextWidget(text: 'For the dough, combine in a large bowl the flour, sugar, instant yeast and salt. Heat milk in a small pot over the stove or in the microwave until quite warm. Add butter and stir until melted. Add vegetable oil and vanilla. Cool milk mixture to lukewarm if necessary. You should barely be able to feel it when you stick your finger in it. Make a well in the dry ingredients and add milk mixture. Add egg and water. Mix by hand or using stand mixer until the mixture forms a very soft, sticky dough. Knead 6-8 minutes using the dough hook attachment or by hand. Add 2-3 tablespoons of flour if the dough looks too much like a thick batter, but it should still be very sticky. If the dough is very dry and easy to handle, add more water to make it sticky. Knead until it feels very smooth. Cover well with plastic wrap and proof for 1½ - 2 hours or until doubled in bulk. While dough is rising, combine the brown sugar and cinnamon in a small bowl for the filling. Once the dough has proofed, roll out into a rectangle that measures 15x10 inches. Use a small amount of flour on your work surface to prevent sticking. Spread the soft butter over entire surface of the dough, then sprinkle on the brown sugar and cinnamon mixture. Starting from long edge closest to you, roll dough as tightly as you can. When you reach the end, pinch the seam very well to seal.',))),
                      SizedBox(height: 15,)
                    ],
                  ))),
        ],
      ),
      bottomNavigationBar: Container(
        height: Constants.bottomHeightBar,
        padding: EdgeInsets.only(
            top: Constants.height20,
            bottom: Constants.height20,
            left: Constants.width20,
            right: Constants.width20),
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Constants.radius20*2),
            topRight: Radius.circular(Constants.radius20*2),
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(top: Constants.height20, bottom: Constants.height20, left: Constants.width20, right: Constants.width20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Constants.radius20),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Icon(Icons.remove, color: Colors.black45,),
                  SizedBox(width: Constants.width10/2,),
                  BigText(text: '0'),
                  SizedBox(width: Constants.width10/2,),
                  Icon(Icons.add, color: Colors.black45,),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: Constants.height20, bottom: Constants.height20, left: Constants.width20, right: Constants.width20),
              child: BigText(text: '\$10 | Add to cart', color: Colors.white,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Constants.radius20),
                color: Color(0xFF4ecb71),
              ),
            )

          ],
        ),
      ),
    );
  }
}
