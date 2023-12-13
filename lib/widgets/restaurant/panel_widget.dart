import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../components/big_text.dart';
import '../../models/restaurant_model_sql.dart';
import '../../util/constants.dart';

class PanelWidget extends StatelessWidget {
  //final RestaurantModelSql restaurantModelSql;
  final ScrollController controller;
  final PanelController panelController;

  const PanelWidget(
      {Key? key, required this.controller, required this.panelController,
        //required this.restaurantModelSql
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) => ListView.builder(
      physics: panelController.isPanelOpen
          ? ClampingScrollPhysics()
          : NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(0),
      controller: controller,
      itemCount: 1,
      itemBuilder: (context, index) {
        return Column(
          children: [
            SizedBox(
              height: 13,
            ),
            buildDragHandle(),
            buildAboutText(),
            SizedBox(
              height: 30,
            )
          ],
        );
      });

  Widget buildDragHandle() => GestureDetector(
        onTap: togglePanel,
        child: Center(
          child: Stack(
            children: [
              Container(height: 15, width: Constants.width20*1.5, color: Colors.red),
              Positioned(
                top: 5,
                child: Container(
                  width: Constants.width20*1.5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  void togglePanel() {
    print("Toggling panel");
    panelController.isPanelOpen
        ? panelController.close()
        : panelController.open();
  }

  Widget buildAboutText() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigText(text: "dfgfgggggggggggggggggggggggggg"),
            BigText(text: "dfgfgggggggggggggggggggggggggg"),
            BigText(text: "dfgfgggggggggggggggggggggggggg"),
            BigText(text: "dfgfgggggggggggggggggggggggggg"),
            BigText(text: "dfgfgggggggggggggggggggggggggg"),
            BigText(text: "dfgfgggggggggggggggggggggggggg"),
            BigText(text: "dfgfgggggggggggggggggggggggggg"),
            BigText(text: "dfgfgggggggggggggggggggggggggg"),
            BigText(text: "dfgfgggggggggggggggggggggggggg"),
            BigText(text: "dfgfgggggggggggggggggggggggggg"),
            BigText(text: "dfgfgggggggggggggggggggggggggg"),
            BigText(text: "dfgfgggggggggggggggggggggggggg"),
            BigText(text: "dfgfgggggggggggggggggggggggggg"),
            BigText(text: "dfgfgggggggggggggggggggggggggg"),
            BigText(text: "dfgfgggggggggggggggggggggggggg"),
            BigText(text: "dfgfgggggggggggggggggggggggggg"),
            BigText(text: "dfgfgggggggggggggggggggggggggg"),
            BigText(text: "dfgfgggggggggggggggggggggggggg"),
            BigText(text: "dfgfgggggggggggggggggggggggggg"),
            BigText(text: "dfgfgggggggggggggggggggggggggg"),
            SizedBox(
              height: 12,
            ),
            BigText(text: "dfg"),
          ],
        ),
      );
}
