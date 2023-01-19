// ignore_for_file: must_be_immutable

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:money_expance/common_widget/button_widget.dart';
import 'package:money_expance/model/budget_model.dart';
import 'package:money_expance/module/tabs/budget/controller/budget_controller.dart';
import 'package:money_expance/module/tabs/home/ui/add_transation.dart';
import 'package:money_expance/utilies/constant.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class CreateBudgetScreen extends StatefulWidget {
  Budget? budget;

  CreateBudgetScreen({Key? key, this.budget}) : super(key: key);

  @override
  State<CreateBudgetScreen> createState() => _CreateBudgetScreenState();
}

class _CreateBudgetScreenState extends State<CreateBudgetScreen> {
  BudgetController budgetController = Get.find<BudgetController>();
  final RxList<String> items = [
    'Shopping',
    'Subscription',
    'Food',
    'Salary',
    'Transportation',
    'Other',
  ].obs;

  @override
  void initState() {
    super.initState();
    if (widget.budget != null) {
      budgetController.spendMoneyController.text = widget.budget?.budget ?? '';
      budgetController.isReceiveAlert.value = widget.budget?.isAlert ?? false;
      selectedValue1 = widget.budget?.category ?? '';
      budgetController.slider.value =
          double.parse(widget.budget?.budgetInPercentage ?? '') / 100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.violet100,
      appBar: AppBar(
        backgroundColor: AppColors.violet100,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
              onTap: () {
                Get.back();
                budgetController.spendMoneyController.clear();
                selectedValue1 == null;
                budgetController.isReceiveAlert.value = false;
                budgetController.slider.value = 0.0;
              },
              child: Image.asset(
                AppIcon.arrowLeft,
                color: AppColors.white,
              )),
        ),
        centerTitle: true,
        title: Text(
          widget.budget != null ? 'Edit Budget' : 'Create Budget',
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 25),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'How much do yo want to spend?',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 4.0,
                    ),
                    child: TextFormField(
                      controller: budgetController.spendMoneyController,
                      textAlignVertical: TextAlignVertical.top,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white),
                      cursorColor: AppColors.white,
                      decoration: const InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: "Enter Your Amount",
                          hintStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          height: 55,
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: const Text(
                                'Select Item',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.lite20,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              items: items
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.black100,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              value: selectedValue1,
                              onChanged: widget.budget != null
                                  ? null
                                  : (value) {
                                      setState(() {
                                        selectedValue1 = value as String;
                                      });
                                    },
                              icon: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 10, bottom: 10),
                                child: Image.asset(
                                  AppIcon.arrowDown,
                                  color: AppColors.lite20,
                                ),
                              ),
                              iconSize: 10,
                              iconEnabledColor: AppColors.black50,
                              iconDisabledColor: Colors.grey,
                              buttonHeight: 50,
                              buttonWidth: 160,
                              buttonPadding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: AppColors.lite20.withOpacity(0.40),
                                ),
                                color: AppColors.white,
                              ),
                              buttonElevation: 0,
                              itemHeight: 40,
                              itemPadding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              dropdownMaxHeight: 200,
                              dropdownPadding: null,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: AppColors.white,
                              ),
                              dropdownElevation: 8,
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 6,
                              scrollbarAlwaysShow: true,
                            ),
                          ),
                        ),
                        Obx(
                          () => ListTileSwitch(
                            onChanged: (value) {
                              budgetController.changeReceiveValue(value: value);
                            },
                            value: budgetController.isReceiveAlert.value,
                            title: const Text(
                              'Receive Alert',
                              style: TextStyle(
                                  color: AppColors.black100,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            subtitle: const Text(
                              'Receive alert when it reaches\nsome point.',
                              style: TextStyle(
                                  color: AppColors.lite20,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                            switchActiveColor: AppColors.violet100,
                            switchInactiveColor: AppColors.violet20,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 5),
                          ),
                        ),
                        Obx(() => SizedBox(
                              height: budgetController.isReceiveAlert.value
                                  ? 15
                                  : 0,
                            )),
                        Obx(() => budgetController.isReceiveAlert.value
                            ? SfSlider(
                                onChanged: (value) {
                                  budgetController.changeSliderValue(
                                      value: value);
                                },
                                enableTooltip: true,
                                tooltipTextFormatterCallback: (value, v) {
                                  return '${(budgetController.slider.value.toDouble() * 100).toString().split('.').first} %';
                                },
                                labelPlacement: LabelPlacement.betweenTicks,
                                value: budgetController.slider.value,
                                activeColor: AppColors.violet100,
                                inactiveColor: AppColors.violet20,
                              )
                            : const SizedBox.shrink()),
                        // const Spacer(),
                        SizedBox(
                          height: 12.h,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: button(
                              text: 'Continue',
                              onTap: () {
                                if (widget.budget != null) {
                                  budgetController.updateBudget(
                                      id: widget.budget?.id);
                                  budgetController.update();
                                  budgetController.onInit();
                                } else {
                                  budgetController.addBudget();
                                }

                                // Get.to(const CreateBudgetScreen());
                              },
                              context: context),
                        ),
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
