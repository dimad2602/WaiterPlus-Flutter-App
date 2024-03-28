import 'package:flutter/material.dart';

class ButtonAddItem extends StatefulWidget {
  final Color color;
  final String text;
  final int itemQuantity;
  //final CartModel? cardModel;
  final Function()? onPressedLeft;
  final Function()? onPressedRight;

  const ButtonAddItem(
      {super.key,
      required this.color,
      required this.text,
      this.onPressedLeft,
      this.onPressedRight, this.itemQuantity = 0, 
      //this.cardModel
      });

  @override
  _ButtonAddItemState createState() => _ButtonAddItemState();
}

class _ButtonAddItemState extends State<ButtonAddItem> {
  //int itemCount = 0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //if (widget.cardModel == null) {
          if (widget.itemQuantity == 0 ) {
          print("onPressedRight");
          if (widget.onPressedLeft != null) {
            widget.onPressedRight!();
            // setState(() {
            //   itemCount++; // Увеличиваем количество товаров при нажатии
            // });
          } else {
            // Выполнить пустую функцию или ничего не делать
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        height: 30.0, // Задаем высоту кнопки
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: 
        //widget.cardModel == null
         widget.itemQuantity == 0
            ? Center(
                child: Text(
                  widget.text,
                  style: const TextStyle(color: Colors.black),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          print("onPressedLeft");
                          if (widget.onPressedLeft != null) {
                            widget.onPressedLeft!();
                            // setState(() {
                            //   itemCount--; // Уменьшаем количество товаров при нажатии
                            // });
                          } else {}
                        },
                        child: const Icon(
                          Icons.remove,
                          color: Colors.black,
                          size: 16.0,
                        ),
                      ),
                    ],
                  ),
                  Text(
                     widget.itemQuantity.toString(), 
                    //widget.cardModel == null ? "":widget.cardModel!.quantity.toString(),
                    style: const TextStyle(color: Colors.black),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("onPressedRight");
                          if (widget.onPressedLeft != null) {
                            widget.onPressedRight!();
                            // setState(() {
                            //   itemCount++; // Увеличиваем количество товаров при нажатии
                            // });
                          } else {
                            // Выполнить пустую функцию или ничего не делать
                          }
                        },
                        child: const Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 16.0,
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
