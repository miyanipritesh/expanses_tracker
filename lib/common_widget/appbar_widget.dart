import 'package:flutter/material.dart';
import 'package:money_expance/utilies/constant.dart';

Widget customAppBar() {
  return AppBar(
    backgroundColor: AppColors.white,
    elevation: 0,
    leading: Padding(
      padding: const EdgeInsets.all(10),
      child: Image.asset(AppIcon.arrowLeft),
    ),
    centerTitle: true,
    title: const Text(
      'Sign Up',
      textAlign: TextAlign.center,
      style: TextStyle(
          color: AppColors.black50, fontSize: 18, fontWeight: FontWeight.w600),
    ),
  );
}
