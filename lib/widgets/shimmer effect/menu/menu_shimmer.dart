import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MenuShimmer extends StatelessWidget {
  const MenuShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var line = Container(
        width: double.infinity,
        height: 12.0,
        color: Theme.of(context).scaffoldBackgroundColor);
    var menuPaper = Container(
        width: double.infinity,
        height: 50.0,
        color: Theme.of(context).scaffoldBackgroundColor);
    return Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.blueGrey.withOpacity(0.5),
        child: EasySeparatedColumn(
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 20,
            );
          },
          children: [
            EasySeparatedColumn(
              children: [
                line,
                line,
                line,
                line
              ],
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 20,
                );
              },
            ),
            menuPaper,
            menuPaper,
            menuPaper
          ],
        ));
  }
}
