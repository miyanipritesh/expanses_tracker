import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:money_expance/module/tabs/budget/ui/budget_tab.dart';
import 'package:money_expance/module/tabs/home/ui/home_tab.dart';
import 'package:money_expance/module/tabs/profile/ui/profile_tab.dart';
import 'package:money_expance/module/tabs/transtation/ui/transtion_tab.dart';

class HomeController extends GetxController {
  RxInt selectBtn = 0.obs;

  RxList<Widget> tabs = <Widget>[
    const HomeTab(),
    const TransationScreen(),
    const BudgetScreen(),
    const ProfileScreen(),
  ].obs;
}
