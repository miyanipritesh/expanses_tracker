import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_expance/common_widget/bottom_sheet.dart';
import 'package:money_expance/common_widget/button_widget.dart';
import 'package:money_expance/local_database/budget_local_database.dart';
import 'package:money_expance/model/budget_model.dart';
import 'package:money_expance/module/tabs/budget/ui/create_budget.dart';
import 'package:money_expance/module/tabs/budget/widget/liner_percentage.dart';
import 'package:money_expance/module/tabs/home/widget/card_widget.dart';
import 'package:money_expance/utilies/constant.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditDeleteBudgetScreen extends StatefulWidget {
  final Budget? budget;
  final int? remaining;
  final double? per;

  const EditDeleteBudgetScreen(
      {Key? key, this.remaining, this.budget, this.per})
      : super(key: key);

  @override
  State<EditDeleteBudgetScreen> createState() => _EditDeleteBudgetScreenState();
}

class _EditDeleteBudgetScreenState extends State<EditDeleteBudgetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                AppIcon.arrowLeft,
                color: AppColors.black100,
              )),
        ),
        centerTitle: true,
        title: const Text(
          'Detail Budget',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColors.black100,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
                onTap: () {
                  showBottomSheet1(
                      context: context,
                      title: 'Remove this budget?',
                      subTitle: 'Are you sure do you wanna remove this budget?',
                      onNo: () {
                        Get.back();
                      },
                      onYes: () {
                        BudgetLocalDatabase.deleteBudget(widget.budget!.id!);
                      });
                },
                child: Image.asset(
                  AppImage.delete,
                  height: 24,
                  width: 24,
                )),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                30,
            child: Column(
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Center(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                    height: 64,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: AppColors.lite60)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                              color: getLiteColor(widget.budget!.category!),
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child:
                                Image.asset(getImage(widget.budget!.category!)),
                          ),
                        ),
                        Text(
                          widget.budget!.category!,
                          style: const TextStyle(
                              color: AppColors.black50,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 4.h),
                  child: const Text(
                    'Remaining',
                    style: TextStyle(
                        color: AppColors.black100,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  '${widget.remaining}',
                  style: const TextStyle(
                      color: AppColors.black100,
                      fontSize: 64,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: linerPercentage(
                      percentage: widget.per!,
                      progressColor: getColor1(widget.budget!.category!)!,
                      backGroundColor: getLiteColor(widget.budget!.category!)!),
                ),
                int.parse(widget.budget!.budgetInPercentage.toString()) / 100 <=
                            widget.per!.toDouble() &&
                        widget.budget?.isAlert == true
                    ? UnconstrainedBox(
                        child: Container(
                          margin: const EdgeInsets.only(top: 25),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          decoration: BoxDecoration(
                              color: AppColors.red100,
                              borderRadius: BorderRadius.circular(24)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(24)),
                                child: const Center(
                                    child: Text(
                                  '!',
                                  style: TextStyle(
                                      color: AppColors.red100, fontSize: 18),
                                )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'You’ve exceed the limit',
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                const Spacer(),
                button(
                    text: 'Edit',
                    onTap: () {
                      Get.to(CreateBudgetScreen(
                        budget: widget.budget,
                      ));
                    },
                    context: context),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
