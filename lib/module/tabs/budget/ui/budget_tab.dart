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
  ExpanceController expanceController = Get.find<ExpanceController>();
  BudgetController budgetController = Get.find<BudgetController>();

  @override
  void initState() {
    super.initState();
  }

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
                        budgetController.getFilterData(
                            value: budgetController
                                .changeMonth(
                                    budgetController.currentMonth.value)
                                .toString());
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
                    child: Obx(() => Text(
                          '${budgetController.changeMonth(budgetController.currentMonth.value)}  2023',
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
                        budgetController.getFilterData(
                            value: budgetController
                                .changeMonth(
                                    budgetController.currentMonth.value)
                                .toString());
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
                  child: GetBuilder(
                    init: BudgetController(),
                    builder: (controller) {
                      return ListView(
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.filterData.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(EditDeleteBudgetScreen(
                                    budget: controller.filterData[index],
                                    remaining: int.parse(controller
                                            .filterData[index].budget
                                            .toString()) -
                                        expanceController.foodTotal.value,
                                    per: (int.parse(controller
                                                    .filterData[index].budget
                                                    .toString()) -
                                                expanceController
                                                    .foodTotal.value)
                                            .isNegative
                                        ? 1
                                        : expanceController.foodTotal.value /
                                            int.parse(budgetController
                                                .filterData[index].budget
                                                .toString()),
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
                                                            controller
                                                                .filterData[
                                                                    index]
                                                                .category
                                                                .toString()),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14)),
                                                  ),
                                                  Text(
                                                    controller.filterData[index]
                                                        .category
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
                                            int.parse(controller
                                                            .filterData[index]
                                                            .budgetInPercentage
                                                            .toString()) /
                                                        100 <=
                                                    expanceController
                                                            .foodTotal.value /
                                                        int.parse(controller
                                                            .filterData[index]
                                                            .budget
                                                            .toString())
                                                ? Image.asset(
                                                    AppImage.error,
                                                    height: 24,
                                                    width: 24,
                                                  )
                                                : const SizedBox.shrink()
                                          ],
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 5, top: 5),
                                          child: Text(
                                            'Remaining ${int.parse(controller.filterData[index].budget.toString()) - expanceController.foodTotal.value}',
                                            style: const TextStyle(
                                                color: AppColors.black100,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        linerPercentage(
                                            percentage: (int.parse(controller.filterData[index].budget.toString()) -
                                                        expanceController
                                                            .foodTotal.value)
                                                    .isNegative
                                                ? 1
                                                : expanceController
                                                        .foodTotal.value /
                                                    int.parse(controller
                                                        .filterData[index]
                                                        .budget
                                                        .toString()),
                                            progressColor: getColor1(controller
                                                .filterData[index].category
                                                .toString())!,
                                            backGroundColor: getLiteColor(
                                                budgetController.filterData[index].category.toString())!),
                                        Container(
                                          margin: const EdgeInsets.only(top: 5),
                                          child: Text(
                                            '${expanceController.foodTotal.value} of ${controller.filterData[index].budget.toString()}',
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
                          ),
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
                      );
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
