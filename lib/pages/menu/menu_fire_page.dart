import 'package:flutter/material.dart';
import 'package:flutter_project2/controllers/menu_controller/menu_controller.dart';
import 'package:flutter_project2/firebase_ref/loading_status.dart';
import 'package:flutter_project2/widgets/menu/backgrount_decoration.dart';
import 'package:get/get.dart';
 
class MenuFirePage extends GetView<MenuPaperController> {
  const MenuFirePage({Key? key}) : super(key: key);
  static const String routeName = "/firemenu_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgrountDecoration(child: Obx(
          () =>Column(
            children: [
              if(controller.loadingStatus.value==LoadingStatus.loading)
                const Expanded(child: CircularProgressIndicator()),
              if(controller.loadingStatus.value == LoadingStatus.completed)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                            controller.currentMenu.value!.name
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
      ),),
    );
  }
}
