import 'package:flutter/material.dart';
import 'package:money_expance/utilies/constant.dart';

Widget button({required String text, required Function() onTap, context}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0),
    child: SizedBox(
      height: 56,
      width: MediaQuery.of(context).size.width * 0.90,
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
              backgroundColor: MaterialStateProperty.all(AppColors.violet100)),
          onPressed: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          )),
    ),
  );
}

Widget button2({required String text, required Function() onTap, context}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0),
    child: SizedBox(
      height: 56,
      width: MediaQuery.of(context).size.width * 0.90,
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
              backgroundColor: MaterialStateProperty.all(AppColors.violet20)),
          onPressed: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppColors.violet100,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          )),
    ),
  );
}
