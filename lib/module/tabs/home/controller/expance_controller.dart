import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:money_expance/local_database/local_database.dart';
import 'package:money_expance/model/expanses_model.dart';
import 'package:money_expance/model/quotes_model.dart';
import 'package:money_expance/module/remote_config.dart';
import 'package:money_expance/module/tabs/home/ui/add_transation.dart';
import 'package:money_expance/utilies/constant.dart';

class ExpanceController extends GetxController {
  AddTransationScreen addTransationScreen = const AddTransationScreen();
  RxInt foodTotal = 0.obs;
  RxInt shoppingTotal = 0.obs;
  RxInt transportationTotal = 0.obs;
  RxInt salaryTotal = 0.obs;
  RxInt subscriptionTotal = 0.obs;

  RxInt randomNumber = 5.obs;

  late Map<String, double> dataMap = {
    "Shopping": 500,
    "Subscription": 1500,
    "Transportation": 800,
    "Salary": 1400,
    "Food": foodTotal.value.toDouble(),
  };

  RxMap<String, double> y = <String, double>{}.obs;
  RxList<Quote> quote = <Quote>[].obs;
  final RxList<String> items = [
    'Shopping',
    'Subscription',
    'Food',
    'Salary',
    'Transportation',
    'Other',
  ].obs;

  RxString? selectedValue;
  TextEditingController desciption = TextEditingController();
  TextEditingController moneyController = TextEditingController();
  FilePickerResult? result;
  RxList<Expanses> expansesData = <Expanses>[].obs;

  addDataToLocal() async {
    if (desciption.text.isNotEmpty) {
      if (moneyController.text.isNotEmpty) {
        if (selectedValue1 != null) {
          Expanses expanses = Expanses(
              category: selectedValue1,
              description: desciption.text,
              price: moneyController.text,
              time: DateTime.now().millisecondsSinceEpoch,
              file: result == null ? "" : result?.files[0].path);

          await LocalDatabase.addExpanses(expanses);
          desciption.clear();
          moneyController.clear();
        } else {
          Fluttertoast.showToast(
              msg: 'Pleases Select Category',
              backgroundColor: AppColors.violet100,
              textColor: AppColors.white);
        }
      } else {
        Fluttertoast.showToast(
            msg: 'Pleases Enter Money',
            backgroundColor: AppColors.violet100,
            textColor: AppColors.white);
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Pleases Enter Description',
          backgroundColor: AppColors.violet100,
          textColor: AppColors.white);
    }
  }

  getAllData() {
    expansesData.clear();
    LocalDatabase.getAllExpanses().then((value) {
      value?.forEach((element) {
        expansesData.add(element);
      });
    });

    selectedValue1 = null;
  }

  calculate() {
    var food = 0;
    var subscription = 0;
    var transportation = 0;
    var shopping = 0;
    var salary = 0;
    for (var element in expansesData) {
      if (element.category == 'Food') {
        food = food + int.parse(element.price!);
      } else if (element.category == 'Subscription') {
        subscription = subscription + int.parse(element.price!);
      } else if (element.category == 'Transportation') {
        transportation = transportation + int.parse(element.price!);
      } else if (element.category == 'Shopping') {
        shopping = shopping + int.parse(element.price!);
      } else if (element.category == 'Salary') {
        salary = salary + int.parse(element.price!);
      }
    }
    foodTotal.value = food;
    subscriptionTotal.value = subscription;
    transportationTotal.value = transportation;
    shoppingTotal.value = shopping;
    salaryTotal.value = salary;
  }

  @override
  void onInit() {
    super.onInit();
    List<Quote?>? w = quoteFromJson(
        RemoteConfig1.remoteConfig.getString(RemoteConfig1.qouest));
    w?.forEach((element) {
      quote.add(element!);
    });
    getAllData();
    calculate();
  }

  @override
  void onClose() {
    moneyController.dispose();
    desciption.dispose();
    super.onClose();
  }
}
