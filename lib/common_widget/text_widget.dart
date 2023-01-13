import 'package:flutter/cupertino.dart';
import 'package:money_expance/utilies/constant.dart';

Widget coustonText700({required String text}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: const TextStyle(
        color: AppColors.black100, fontSize: 32, fontWeight: FontWeight.w700),
  );
}

Widget coustonText500({required String text}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: const TextStyle(
        color: AppColors.lite20, fontSize: 16, fontWeight: FontWeight.w500),
  );
}
