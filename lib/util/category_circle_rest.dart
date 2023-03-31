import 'package:flutter/material.dart';

class CategoryCircleWidget extends StatelessWidget {
  final String categoryImagePath;
  final String categoryName;

  CategoryCircleWidget({
    required this.categoryImagePath,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade400,
            ),
            child: CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.white,
              child: Transform.scale(
                scale: 0.8,
                child: ClipOval(
                  child: Container(
                    height: 100,
                    width: 100,
                    child: FadeInImage.assetNetwork(
                      placeholder: 'lib/images/LoadingCircle.gif',
                      image: categoryImagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            categoryName,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
