import 'package:flutter/material.dart';
import 'package:flutter_project2/Configs/ui_parametrs.dart';
import 'package:flutter_project2/components/AppBar/custom_app_bar2.dart';
import 'package:flutter_project2/components/main_button.dart';
import 'package:flutter_project2/controllers/menu_controller/menu_controller.dart';
import 'package:flutter_project2/firebase_ref/loading_status.dart';
import 'package:flutter_project2/pages/menu/menu_overview_page.dart';
import 'package:flutter_project2/pages/restaurants/restaurant_fire_page.dart';
import 'package:flutter_project2/widgets/content_area.dart';
import 'package:flutter_project2/widgets/menu/Menu_cart_widget.dart';
import 'package:flutter_project2/widgets/menu/backgrount_decoration.dart';
import 'package:flutter_project2/widgets/menu/menu_fire_card.dart';
import 'package:flutter_project2/widgets/shimmer%20effect/menu/menu_shimmer.dart';
import 'package:get/get.dart';

import '../../widgets/menu/dish_card_widget.dart';
import '../../widgets/restaurant/restaurant_card.dart';

class MenuFirePage extends GetView<MenuPaperController> {
  const MenuFirePage({Key? key}) : super(key: key);
  static const String routeName = "/firemenu_page";

  @override
  Widget build(BuildContext context) {
    MenuPaperController _menuPaperController = Get.find();
    // TODO: // Мне кажется из за Obx возникают ошибки
    return Obx(
      () => Scaffold(
        appBar: controller.loadingStatus.value == LoadingStatus.completed
            ? CustomAppBar2(
                restName: _menuPaperController.restaurantModel.name,
                restImg: _menuPaperController.restaurantModel.img,
              )
            : null,
        backgroundColor: Color(0xFFf5ebdc),
        body: BackgrountDecoration(
          child: Obx(() => Column(
                children: [
                  /*GestureDetector(
                      child: ListView.separated(
                        // Позволяем перекрывать категории
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return
                              RestaurantCard(model: _restaurantPaperController.allPapers[index]);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                          itemCount: _restaurantPaperController.allPapers.length),
                    ),*/
                  /*Container(
                      height: 150, //_screenWidth * 0.35,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _categoryCircle.length,
                          itemBuilder: (context, index) {
                            return CategoryCircleWidget(
                              categoryImagePath:
                              _categoryCircle[index].categoryImagePath,
                              categoryName: _categoryCircle[index].categoryName,
                            );
                          }),
                    ),*/
                  /*Container(
                      height: 150, //_screenWidth * 0.35,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller
                              .currentMenu.value!.items.length,
                          itemBuilder: (context, index) {
                            final item = controller
                                .currentMenu.value!.items[index];
                            return MenuWidget(
                                menuCard: '${item.id}. ${item.itemName}.'
                            );
                          }, separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            width: 20,
                          );
                      },),
                    ),*/
                  /*Container(
                      height: 180,
                      child: ListView.separated(
                        // делаем лист вертикальным
                        // Позволяем перекрывать категории
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          //physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final item = controller
                                .currentMenu.value!.items[index];
                            return
                              DishCardWidget(testName: 'test111n',);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              width: 20,
                            );
                          },
                          itemCount: controller
                              .currentMenu.value!.items.length),
                    ),*/
                  if (controller.loadingStatus.value == LoadingStatus.loading)
                    //Content Area это собственный виджет по обертке
                    //shimmer
                    const Expanded(child: ContentArea(child: MenuShimmer())),
                  //CircularProgressIndicator(),
                  if (controller.loadingStatus.value == LoadingStatus.completed)
                    Expanded(
                      child: ListView.separated(
                          // делаем лист вертикальным
                          // Позволяем перекрывать категории
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          //physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            /*final item = controller
                                .currentMenu.value!.items[index];*/
                            //final allItems = controller.currentMenu.value!.items;
                            /*final menu =
                                controller.allCategories;*/
                            /*final menu2 =
                                controller.currentMenu.value!.name;*/
                            return //Text('${_menuPaperController.allItemsForCategory[index].itemName}');
                                MenuWidget(
                              menuCard:
                                  '${_menuPaperController.allCategories[index].name}',
                              IndexCount: index,
                              //model: allItems,
                              // testModel: '${_menuPaperController.allItems[index].itemName}',

                              // itemName: item.itemName,
                              // itemWeight: item.weight,
                              //'${item.id}. ${item.itemName}. ${menu}'
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              width: 20,
                            );
                          },
                          itemCount: _menuPaperController.allCategories.length),
                      //controller.currentMenu.value!.items.length
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  // shimmer effect

                  // Лист по видео
                  /*if (controller.loadingStatus.value == LoadingStatus.loading)
                      //Content Area это собственный виджет по обертке
                      const Expanded(child: ContentArea(child: MenuShimmer())),
                    // отображаем контент
                    if (controller.loadingStatus.value == LoadingStatus.completed)
                      Expanded(
                        //Content Area это собственный виджет по обертке
                        child: ContentArea(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.only(top: 25),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    controller.currentMenu.value!.name,
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ),
                                GetBuilder<MenuPaperController>(
                                    id: 'menu_list',
                                    builder: (context) {
                                      return ListView.separated(
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.only(top: 25),
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            //тут пока береться item, но скорее нужно просто menu
                                            final item = controller
                                                .currentMenu.value!.items[index];
                                            final menu =
                                                controller.currentMenu.value!.name;
                                            return MenuCard(
                                              menuCard:
                                                  '${item.id}. ${item.itemName} test ${menu}',
                                              onTap: () {
                                                controller.selectedItem(item.id);
                                              },
                                              isSelected: item.id ==
                                                  controller.currentMenu.value!
                                                      .selectedItem,
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context, int index) =>
                                                  const SizedBox(height: 10),
                                          itemCount: controller
                                              .currentMenu.value!.items.length);
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),*/

                  // Кнопка next и назад
                  /*ColoredBox(
                      color: Colors.brown.shade300,
                      child: Padding(
                        padding: UIParameters.mobileScreenPadding,
                        child: Row(
                          children: [
                            Visibility(
                              visible: controller.isFirstMenu,
                              child: SizedBox(
                                width: 55,
                                height: 55,
                                child: MainButton(
                                    onTap: () {
                                      controller.prevMenu();
                                    },
                                    child: Icon(
                                      Icons.arrow_back_ios_new,
                                      size: 40,
                                    )),
                              ),
                            ),
                            SizedBox(width: 8,),
                            Expanded(
                              child: Visibility(
                                visible: controller.loadingStatus.value ==LoadingStatus.completed,
                                  child: MainButton(
                                      onTap: () {
                                        controller.isLastMenu?Get.toNamed(MenuOverviewPage.routeName):
                                        controller.nextMenu();
                                      },
                                      title: controller.isLastMenu?'Complete': 'Next',
                                  ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )*/
                ],
              )),
        ),
      ),
    );
  }
}
