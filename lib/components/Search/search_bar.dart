import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../controllers/restaurants_controlelr/restaurant_paper_controller.dart';

class SearchBar extends StatefulWidget {

  final TextEditingController controller;
  final RestaurantPaperController restaurantPaperController;

  const SearchBar({
    Key? key,
    required this.controller,
    required this.restaurantPaperController,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  // для изменения цвета иконки поиска
  bool isFocused = false;

  Future<QuerySnapshot>? restaurantList;

  // initSearchCard(String textEntered) {
  //   restaurantList = widget.restaurantPaperController.allPapers
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        onChanged: (textEntered){

        },
        controller: widget.controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            //Статичный цвет иконки
            // color: Colors.white,
            //Цвет меняеться от фокуса
            color: isFocused
                ? Colors.black
                : Colors.grey
                .shade600, // Theme.of(context).primaryColor
          ),
          hintText: 'Search',
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                color: Colors.black,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.grey.shade600,
              )),
        ),
        // Изменение цвета иконки во время фокуса
        onTap: () {
          setState(() {
            isFocused = true;
          });
        },
        onSubmitted: (_) {
          setState(() {
            isFocused = false;
          });
        },
      ),
    );
  }
}
