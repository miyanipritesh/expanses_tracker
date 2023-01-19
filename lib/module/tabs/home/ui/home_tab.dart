import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_expance/model/expanses_model.dart';
import 'package:money_expance/module/tabs/budget/controller/budget_controller.dart';
import 'package:money_expance/module/tabs/controller/home_controller.dart';
import 'package:money_expance/module/tabs/home/controller/expance_controller.dart';
import 'package:money_expance/module/tabs/home/ui/add_transation.dart';
import 'package:money_expance/module/tabs/home/widget/card_widget.dart';
import 'package:money_expance/module/tabs/transtation/ui/transtion_tab.dart';
import 'package:money_expance/utilies/constant.dart';
import 'package:pie_chart/pie_chart.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  ExpanceController expanceController = Get.put(ExpanceController());
  BudgetController budgetController = Get.put(BudgetController());
  HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    Timer.periodic(
      const Duration(seconds: 30),
      (timer) {
        expanceController.randomNumber.value = Random().nextInt(200);
      },
    );
    _tabController = TabController(length: 4, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Color> color = [];
    expanceController.dataMap.forEach((key, value) {
      color.add(getColor1(key)!);
    });

    Timer(
      const Duration(seconds: 1),
      () {
        expanceController.dataMap = {
          "Shopping": expanceController.shoppingTotal.value.toDouble(),
          "Subscription": expanceController.subscriptionTotal.value.toDouble(),
          "Transportation":
              expanceController.transportationTotal.value.toDouble(),
          "Salary": expanceController.salaryTotal.value.toDouble(),
          "Food": expanceController.foodTotal.value.toDouble(),
        };
        expanceController.update();
      },
    );
    budgetController.onInit();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        // title: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Image.asset(
        //       AppIcon.expense,
        //       height: 48,
        //       width: 48,
        //     ),
        //     const SizedBox(
        //       width: 10,
        //     ),
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: const [
        //         Text(
        //           'Expenses',
        //           textAlign: TextAlign.center,
        //           style: TextStyle(
        //               color: AppColors.black100,
        //               fontSize: 14,
        //               fontWeight: FontWeight.w500),
        //         ),
        //         Text(
        //           '₹12520',
        //           textAlign: TextAlign.center,
        //           style: TextStyle(
        //               color: AppColors.black100,
        //               fontSize: 20,
        //               fontWeight: FontWeight.w600),
        //         ),
        //       ],
        //     )
        //   ],
        // ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0, top: 8, bottom: 8),
            child: Stack(children: [
              GestureDetector(
                onTap: () {
                  expanceController.calculate();
                  // LocalNotification.createNotification();
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 3, right: 3, top: 2, bottom: 2),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.lite20.withOpacity(0.50),
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  child: Image.asset(
                    AppIcon.notification,
                    height: 32,
                    width: 32,
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 8,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                      color: AppColors.red100,
                      borderRadius: BorderRadius.circular(100)),
                ),
              )
            ]),
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 10),
          child: Column(
            children: [
              /*   Obx(() => Text(expanceController
                  .quote[expanceController.randomNumber.value].quoteText
                  .toString())),
              Obx(() => Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                      '-${expanceController.quote[expanceController.randomNumber.value].quoteAuthor}'))),*/
              GetBuilder(
                init: ExpanceController(),
                builder: (controller) {
                  return PieChart(
                    dataMap: controller.dataMap,
                    animationDuration: const Duration(milliseconds: 800),
                    chartLegendSpacing: 40,
                    chartRadius: MediaQuery.of(context).size.width / 3,
                    colorList: color,
                    initialAngleInDegree: 0,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 20,
                    legendOptions: const LegendOptions(
                      showLegendsInRow: true,
                      legendPosition: LegendPosition.bottom,
                      showLegends: false,
                      legendShape: BoxShape.circle,
                      legendTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValueBackground: true,
                      showChartValues: true,
                      showChartValuesInPercentage: true,
                      showChartValuesOutside: true,
                      decimalPlaces: 1,
                    ),
                  );
                },
              ),
              /* Container(
                margin: const EdgeInsets.only(bottom: 15),
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ),
                    color: AppColors.yellow20,
                  ),
                  labelColor: AppColors.yellow100,
                  unselectedLabelColor: AppColors.lite20,
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: const [
                    Tab(
                      text: 'Today',
                    ),
                    Tab(
                      text: 'Week',
                    ),
                    Tab(
                      text: 'Month',
                    ),
                    Tab(
                      text: 'Year',
                    ),
                  ],
                ),
              ),
              // tabar view here
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    TodayScreen(),
                    Center(
                      child: Text(
                        'Place Bid',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Place Bid',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Buy Now',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),*/
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Transaction',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black50),
                  ),
                  GestureDetector(
                    onTap: () {
                      homeController.selectBtn.value = 1;
                      homeController.update();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 12),
                      decoration: BoxDecoration(
                          color: AppColors.violet20,
                          borderRadius: BorderRadius.circular(40)),
                      child: const Text(
                        'See All',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.violet100),
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Obx(() => ListView.builder(
                      padding: const EdgeInsets.only(top: 5),
                      itemCount: expanceController.expansesData.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        List<Expanses> q = expanceController.expansesData;
                        bool isSameDate = true;
                        final DateTime date =
                            DateTime.fromMillisecondsSinceEpoch(q[index].time!);
                        if (index == 0) {
                          isSameDate = false;
                        } else {
                          final DateTime prevDate =
                              DateTime.fromMillisecondsSinceEpoch(
                                  q[index - 1].time!);
                          isSameDate = date.isSameDate(prevDate);
                        }
                        /*   if (DateTime.now()
                                .subtract(const Duration(days: 0))
                                .isSameDate(DateTime.fromMillisecondsSinceEpoch(
                                    q[index].time!.toInt())) ||
                            DateTime.now()
                                .subtract(const Duration(days: 1))
                                .isSameDate(DateTime.fromMillisecondsSinceEpoch(
                                    q[index].time!.toInt())) ||
                            DateTime.now()
                                .subtract(const Duration(days: 2))
                                .isSameDate(DateTime.fromMillisecondsSinceEpoch(
                                    q[index].time!.toInt()))) {*/
                        if (index == 0 || !(isSameDate)) {
                          return Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    DateTime.now().isSameDate(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                q[index].time!.toInt()))
                                        ? 'Today'
                                        : DateTime.now()
                                                .subtract(
                                                    const Duration(days: 1))
                                                .isSameDate(DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        q[index].time!.toInt()))
                                            ? 'Yesterday'
                                            : date.formatDate(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.black100,
                                        fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: CardWidget(
                                    category: q[index].category,
                                    description: q[index].description,
                                    price: q[index].price,
                                    time: DateFormat('hh:mm a').format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            q[index].time!.toInt())),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: CardWidget(
                              category: q[index].category,
                              description: q[index].description,
                              price: q[index].price,
                              time: DateFormat('hh:mm a').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      q[index].time!.toInt())),
                            ),
                          );
                        }
                        /*} else {
                          return SizedBox()  */ /*Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: const Center(
                                child: Text('No recent transaction',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.lite20))),
                          )*/ /*;
                        }*/
                      },
                    )),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const AddTransationScreen());
        },
        backgroundColor: AppColors.violet100,
        child: Image.asset(
          AppIcon.plus,
          height: 25,
          width: 25,
        ),
      ),
    );
  }
}
