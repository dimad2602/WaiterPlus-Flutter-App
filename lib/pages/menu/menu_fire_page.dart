import 'package:flutter/material.dart';
import 'package:flutter_project2/controllers/menu_controller/menu_controller.dart';
import 'package:flutter_project2/firebase_ref/loading_status.dart';
import 'package:flutter_project2/widgets/content_area.dart';
import 'package:flutter_project2/widgets/menu/backgrount_decoration.dart';
import 'package:flutter_project2/widgets/menu/menu_fire_card.dart';
import 'package:flutter_project2/widgets/shimmer%20effect/menu/menu_shimmer.dart';
import 'package:get/get.dart';

class MenuFirePage extends GetView<MenuPaperController> {
  const MenuFirePage({Key? key}) : super(key: key);
  static const String routeName = "/firemenu_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgrountDecoration(
        child: Obx(() => Column(
              children: [
                // shimmer effect
                if (controller.loadingStatus.value == LoadingStatus.loading)
                  //Content Area это собственный виджет по обертке
                  const Expanded(child: ContentArea(child: MenuShimmer())),
                // отображаем контент
                if (controller.loadingStatus.value == LoadingStatus.completed)
                  Expanded(
                    //Content Area это собственный виджет по обертке
                    child: ContentArea(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                controller.currentMenu.value!.name,
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                            GetBuilder<MenuPaperController>(builder: (context) {
                              return ListView.separated(
                                shrinkWrap: true,
                                  itemBuilder: (BuildContext context, int index){
                                    //тут пока береться item, но скорее нужно просто menu
                                   final item =  controller.currentMenu.value!.items[index];
                                   final menu = controller.currentMenu.value!.name;
                                    return MenuCard(menuCard: '${item.id}. ${item.itemName} test ${menu}', onTap: (){
                                      controller.selectedItem(item.id);
                                      },
                                      isSelected: item.id == controller.currentMenu.value!.selectedItem,
                                    );
                                  },
                                  separatorBuilder: (BuildContext context, int index)=>const SizedBox(height:10),
                                  itemCount: controller.currentMenu.value!.items.length);
                            })
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            )),
      ),
    );
  }
}
