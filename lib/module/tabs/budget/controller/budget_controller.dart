import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:money_expance/local_database/budget_local_database.dart';
import 'package:money_expance/model/budget_model.dart';
import 'package:money_expance/module/tabs/controller/home_controller.dart';
import 'package:money_expance/module/tabs/home/ui/add_transation.dart';
import 'package:money_expance/module/tabs/home_screen.dart';
import 'package:money_expance/utilies/constant.dart';

class BudgetController extends GetxController {
  HomeController homeController = Get.find<HomeController>();
  final RxList<String> items = [
    'Shopping',
    'Subscription',
    'Food',
    'Salary',
    'Transportation',
  ].obs;
  RxInt currentMonth = DateTime.now().month.obs;
  RxDouble slider = 0.0.obs;
  RxBool isReceiveAlert = false.obs;

  RxList<Budget> budget = <Budget>[].obs;
  TextEditingController spendMoneyController = TextEditingController();

  addBudget() {
    Budget budget1 = Budget(
        budget: spendMoneyController.text,
        isAlert: isReceiveAlert.value,
        category: selectedValue1,
        witchMonth: changeMonth(currentMonth.value),
        budgetInPercentage: (slider.value * 100).toString().split('.').first);

    var e = budget.map((element) => element.category == selectedValue1);
    if (e.contains(true)) {
      Fluttertoast.showToast(
          msg: 'You have already create budget',
          backgroundColor: AppColors.violet100,
          textColor: AppColors.white);
    } else {
      if (spendMoneyController.text.isNotEmpty) {
        if (selectedValue1 != null) {
          if (spendMoneyController.text.isNotEmpty && selectedValue1 != null) {
            BudgetLocalDatabase.addBudget(budget1).then((value) {
              spendMoneyController.clear();
              selectedValue1 = null;
              isReceiveAlert.value = false;
              onInit();
              Get.off(const HomeScreen());
              homeController.selectBtn.value = 2;
              homeController.update();
            });
          } else {
            Fluttertoast.showToast(
                msg: 'Pleases Enter Data',
                backgroundColor: AppColors.violet100,
                textColor: AppColors.white);
          }
        } else {
          Fluttertoast.showToast(
              msg: 'Pleases Select Category',
              backgroundColor: AppColors.violet100,
              textColor: AppColors.white);
        }
      } else {
        Fluttertoast.showToast(
            msg: 'Pleases Enter Spend Money',
            backgroundColor: AppColors.violet100,
            textColor: AppColors.white);
      }
    }
  }

  updateBudget({id}) {
    Budget budget1 = Budget(
        id: id,
        budget: spendMoneyController.text,
        isAlert: isReceiveAlert.value,
        category: selectedValue1,
        witchMonth: changeMonth(currentMonth.value),
        budgetInPercentage: (slider.value * 100).toString().split('.').first);

    // var e=budget.map((element) => element.category==selectedValue1);
    if (spendMoneyController.text.isNotEmpty) {
      if (selectedValue1 != null) {
        if (spendMoneyController.text.isNotEmpty && selectedValue1 != null) {
          BudgetLocalDatabase.updateBudget(budget1).then((value) {
            spendMoneyController.clear();
            selectedValue1 = null;
            isReceiveAlert.value = false;
            onInit();
            Get.off(const HomeScreen());
            homeController.selectBtn.value = 2;
            homeController.update();
          });
        } else {
          Fluttertoast.showToast(
              msg: 'Pleases Enter Data',
              backgroundColor: AppColors.violet100,
              textColor: AppColors.white);
        }
      } else {
        Fluttertoast.showToast(
            msg: 'Pleases Select Category',
            backgroundColor: AppColors.violet100,
            textColor: AppColors.white);
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Pleases Enter Spend Money',
          backgroundColor: AppColors.violet100,
          textColor: AppColors.white);
    }
  }

  getAllBudget() {
    BudgetLocalDatabase.getAllBudget().then((value) {
      budget.value = value ?? [];
    });
  }

  changeCurrentMonth() {
    currentMonth++;
  }

  changeReceiveValue({value}) {
    isReceiveAlert.value = value;
  }

  changeSliderValue({value}) {
    slider.value = value;
  }

  backCurrentMonth() {
    currentMonth--;
  }

  String? changeMonth(int a) {
    switch (a) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
    }
    return null;
  }

  @override
  void onInit() {
    // BudgetLocalDatabase.deleteDatabase();
    getAllBudget();
    super.onInit();
  }

  @override
  void onClose() {
    spendMoneyController.dispose();
    super.onClose();
  }
}
