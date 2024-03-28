import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_for_customers/components/app_icon.dart';
import 'package:flutter_app_for_customers/components/big_text.dart';
import 'package:flutter_app_for_customers/components/custom_app_bar.dart';
import 'package:flutter_app_for_customers/pages/first/from_card_to_page_widget.dart';
import 'package:flutter_app_for_customers/utils/app_colors.dart';

class CardItem {
  final String text;
  final IconData icon;
  final String? destinationPage;

  const CardItem(
      {required this.text, required this.icon, this.destinationPage});
}

class FirstPage extends StatelessWidget {
  FirstPage({super.key});

  final List<CardItem> cardItems = [
    const CardItem(
        text: 'Заказы',
        icon: Icons.ac_unit,
        destinationPage: '/ActiveOrdersPage'),
    const CardItem(
        text: 'Создать заказ',
        icon: Icons.access_alarm,
        destinationPage: '/CreateOrderPage'),
    const CardItem(
        text: 'Кухня',
        icon: Icons.access_time,
        destinationPage: '/KitchenOrderPage'),
  ];

  @override
  Widget build(BuildContext context) {
    //var sizeConstants = locator.get<Constants>();
    return Scaffold(
        backgroundColor: AppColors.mainColor,
        appBar: CustomAppBar(
          label: "",
          hideBackArrow: true,
          rightAppIconFirst: Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: AppIcon(
              icon: Icons.person_outlined,
              iconColor: Colors.black,
              backgroundColor: AppColors.mainColorAppbar,
              iconSize24: true,
              onTap: () {
                Navigator.of(context).pushNamed('/ProfilePage');
              },
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GridView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount:
                      cardItems.length, // Используем длину списка карточек
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                  ),
                  itemBuilder: (context, index) {
                    // Получаем карточку из списка по индексу
                    final cardItem = cardItems[index];
                    return GestureDetector(
                      onTap: () {
                        if (cardItems[index].destinationPage != null) {
                          Navigator.of(context)
                              .pushNamed(cardItems[index].destinationPage!);
                        }
                      },
                      child: FromCardToPageWidget(
                        text: cardItem.text,
                        icon: cardItem.icon,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 200, // Регулируйте высоту блока с кнопками
              child: ListView(
                scrollDirection: Axis.vertical, // Прокрутка горизонтальная
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff6750a4),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed('/ActiveOrdersPage');
                          },
                          child: const BigText(
                            text: "Заказы",
                            color: Colors.white,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff6750a4),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed('/ActiveOrdersOldPage');
                          },
                          child: const BigText(
                            text:
                                "ActiveOrdersPage (Полученные нереализованные заказы)",
                            color: Colors.white,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff6750a4),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/ProfilePage');
                          },
                          child: const BigText(
                            text: "Профиль",
                            color: Colors.white,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff6750a4),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/CreateOrderPage');
                          },
                          child: const BigText(
                            text:
                                "Страница создания заказа(создают официанты для клиентов сами, через приложение, оплата постаринке как до приложения )",
                            color: Colors.white,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff6750a4),
                          ),
                          onPressed: () {},
                          child: const BigText(
                            text: "Взять перерыв",
                            color: Colors.white,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff6750a4),
                          ),
                          onPressed: () {},
                          child: const BigText(
                            text: "Начать рабочий день",
                            color: Colors.white,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff6750a4),
                          ),
                          onPressed: () {},
                          child: const BigText(
                            text: "Закончить рабочий день",
                            color: Colors.white,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff6750a4),
                          ),
                          onPressed: () async {
                            await SystemChrome.setPreferredOrientations([
                              DeviceOrientation.landscapeLeft,
                              DeviceOrientation.landscapeRight,
                            ]);

                            Navigator.of(context)
                                .pushNamed('/KitchenOrderPage');
                          },
                          child: const BigText(
                            text: "Заказ на кухне (удобная информация)",
                            color: Colors.white,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff6750a4),
                          ),
                          onPressed: () async {
                            Navigator.of(context).pushNamed('/TestCountPage');
                          },
                          child: const BigText(
                            text: "Счетчик test",
                            color: Colors.white,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff6750a4),
                          ),
                          onPressed: () async {
                            Navigator.of(context).pushNamed('/NewCartPage');
                          },
                          child: const BigText(
                            text: "New Cart DELETE",
                            color: Colors.white,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff6750a4),
                          ),
                          onPressed: () async {
                            Navigator.of(context).pushNamed('/ListTestPage');
                          },
                          child: const BigText(
                            text: "ListTest DELETE",
                            color: Colors.white,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff6750a4),
                          ),
                          onPressed: () async {
                            Navigator.of(context)
                                .pushNamed('/websockettestPage');
                          },
                          child: const BigText(
                            text: "Web Socket test",
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
