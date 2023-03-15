import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../model/cart_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD3AF9C),
      // стрелку назад я бы поменял по дизайну
      appBar: AppBar(
          //automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          //Colors.grey[700],
          // Это может быть выдвигающееся меню с контактами
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Name',
              style: GoogleFonts.bebasNeue(
                fontSize: 22,
              ),
            ),
          ),
          //Icon(Icons.logo_dev, size: 40),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.logo_dev, size: 40),
            )
          ]),
      body: Consumer<CartModel>(builder: (context, value, child) {
        return Column(
          children: [
            // list of cart items
            Expanded(
              child: ListView.builder(
                itemCount: value.cartItems.length,
                padding: EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(8)),
                      child: ListTile(
                        leading: AspectRatio(
                          aspectRatio: 7 / 9,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              topRight: Radius.circular(12.0),
                            ),
                            child: FadeInImage.assetNetwork(
                              height: 100,
                              image: value.cartItems[index].dishesImagePath,
                              placeholder: 'lib/images/LoadingBall.gif',
                            ),
                          ),
                        ),
                        title: Text(value.cartItems[index].dishesName),
                        subtitle: Text(value.cartItems[index].dishesPrice + '\$'),
                        trailing: IconButton(color: Colors.red, icon: Icon(Icons.close), onPressed: () =>
                        Provider.of<CartModel>(context, listen: false).removeItemFromCart(index)),
                      ),
                    ),
                  );
                },
              ),
            ),
            // total Price
            Padding(
              padding: const EdgeInsets.all(36.0),
              child: Container(
                decoration: BoxDecoration(color: Color(0xFF88A763)),
                padding: EdgeInsets.all(24),
                child: Row(
                  children: [
                    Text('Total Price'),
                  ],
                ),

              ),
            )
          ],
        );
      }),

    );
  }
}
