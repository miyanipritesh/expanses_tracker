import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:money_expance/local_database/local_database.dart';
import 'package:money_expance/model/expanses_model.dart';
import 'package:money_expance/module/tabs/home/ui/add_transation.dart';
import 'package:money_expance/utilies/constant.dart';

class ExpanceController extends GetxController {
  AddTransationScreen addTransationScreen = const AddTransationScreen();

  Map<String, double> dataMap = {
    "Shopping": 500,
    "Subscription": 1500,
    "Transportation": 800,
    "Salary": 1400,
  };

  RxMap<String, double> y = <String, double>{}.obs;

  final RxList<String> items = [
    'Shopping',
    'Subscription',
    'Food',
    'Salary',
    'Transportation',
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

    // var y=  expansesData.map((element) => element.category?.contains(selectedValue1!));
    //
    // if(y.contains(true) ){}else{
    //
    // }

    selectedValue1 = null;
  }

  @override
  void onInit() {
    super.onInit();
    getAllData();
  }

  @override
  void onClose() {
    moneyController.dispose();
    desciption.dispose();
    super.onClose();
  }
}
