import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_expance/common_widget/button_widget.dart';
import 'package:money_expance/module/tabs/budget/controller/budget_controller.dart';
import 'package:money_expance/module/tabs/budget/ui/create_budget.dart';
import 'package:money_expance/module/tabs/budget/ui/delete_edit_budget.dart';
import 'package:money_expance/module/tabs/budget/widget/liner_percentage.dart';
import 'package:money_expance/module/tabs/home/controller/expance_controller.dart';
import 'package:money_expance/module/tabs/home/widget/card_widget.dart';
import 'package:money_expance/utilies/constant.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({Key? key}) : super(key: key);

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  BudgetController budgetController = Get.put(BudgetController());
  ExpanceController expanceController = Get.find<ExpanceController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.violet100,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (budgetController.currentMonth.value > 1) {
                        budgetController.backCurrentMonth();
                      }
                    },
                    child: SizedBox(
                      height: 32,
                      width: 32,
                      child: Transform.rotate(
                          angle: 110,
                          child: Image.asset(
                            AppIcon.arrowRight,
                            color: AppColors.white,
                            height: 32,
                            width: 32,
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Obx(() => Text(
                          budgetController
                              .changeMonth(budgetController.currentMonth.value)
                              .toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                              color: AppColors.white),
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (budgetController.currentMonth.value >= 12) {
                      } else {
                        budgetController.changeCurrentMonth();
                      }
                    },
                    child: SizedBox(
                      height: 32,
                      width: 32,
                      child: Image.asset(AppIcon.arrowRight,
                          color: AppColors.white, height: 32, width: 32),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 8,
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 16, bottom: 16),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: ListView(
                    children: [
                      Obx(() => ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: budgetController.budget.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(EditDeleteBudgetScreen(
                                    budget: budgetController.budget[index],
                                  ));
                                },
                                child: Card(
                                  elevation: 1,
                                  shadowColor: AppColors.white,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        top: 16,
                                        bottom: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: AppColors.white,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4,
                                                      horizontal: 8),
                                              height: 33,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(32),
                                                  border: Border.all(
                                                      color: AppColors.lite60)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    height: 14,
                                                    width: 14,
                                                    decoration: BoxDecoration(
                                                        color: getColor1(
                                                            budgetController
                                                                .budget[index]
                                                                .category
                                                                .toString()),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14)),
                                                  ),
                                                  Text(
                                                    budgetController
                                                        .budget[index].category
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color:
                                                            AppColors.black50,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Image.asset(
                                              AppImage.error,
                                              height: 24,
                                              width: 24,
                                            )
                                          ],
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 5, top: 5),
                                          child: const Text(
                                            'Remaining \$0',
                                            style: TextStyle(
                                                color: AppColors.black100,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        linerPercentage(
                                            percentage: 0.75,
                                            progressColor: getColor1(
                                                budgetController
                                                    .budget[index].category
                                                    .toString())!,
                                            backGroundColor: getLiteColor(
                                                budgetController
                                                    .budget[index].category
                                                    .toString())!),
                                        Container(
                                          margin: const EdgeInsets.only(top: 5),
                                          child: Text(
                                            '${budgetController.budget[index].budget.toString()}',
                                            style: const TextStyle(
                                                color: AppColors.lite20,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )),
                      // const Text(
                      //   "You don’t have a budget.\nLet’s make one so you in control.",
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.w500,
                      //       fontSize: 16,
                      //       color: AppColors.lite20),
                      // ),
                      // const Spacer(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: button(
                            text: 'Create a budget',
                            onTap: () {
                              Get.to(CreateBudgetScreen());
                            },
                            context: context),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
