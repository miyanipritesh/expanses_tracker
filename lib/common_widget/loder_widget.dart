import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_expance/utilies/constant.dart';

Future loder() {
  return Get.dialog(
      barrierColor: Colors.transparent.withOpacity(0.50),
      barrierDismissible: false,
      Center(
          child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: AppColors.violet100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Padding(
                padding: EdgeInsets.all(18.0),
                child: CircularProgressIndicator(
                  color: AppColors.white,
                ),
              ))));
}
