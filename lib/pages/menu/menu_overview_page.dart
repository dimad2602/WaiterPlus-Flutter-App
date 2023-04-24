import 'package:flutter/material.dart';
import 'package:flutter_project2/widgets/menu/backgrount_decoration.dart';
import 'package:get/get.dart';

import '../../controllers/menu_controller/menu_controller.dart';

class MenuOverviewPage extends GetView<MenuPaperController> {
  const MenuOverviewPage({Key? key}) : super(key: key);
  static const String routeName = "/menuoverview";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BackgrountDecoration(
        child: Column(
              children: [
                Center(child: Text(controller.completedMenu),),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: controller.allMenu.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: Get.width ~/75,
                      childAspectRatio: 1,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8
                    ),
                    itemBuilder: (_, index){
                      return Text('${controller.allMenu[index].selectedItem!=null}',
                      style: TextStyle(fontSize: 20),);
                    },
                  ),
                )
              ],
        ),
      ),
    );
  }
}
