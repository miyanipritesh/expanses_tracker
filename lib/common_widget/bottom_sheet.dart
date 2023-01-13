import 'package:flutter/material.dart';
import 'package:money_expance/utilies/constant.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

showBottomSheet1(
    {context,
    String? title,
    String? subTitle,
    required Function() onNo,
    required Function() onYes}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.only(top: 5, bottom: 15),
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(100), topRight: Radius.circular(100))),
        // height: 150,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              height: 5,
              width: 36,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.violet20),
            ),
            Text(
              title.toString(),
              style: const TextStyle(
                  color: AppColors.black100,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                subTitle.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: AppColors.lite20,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: onNo,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 2.h, horizontal: 16.w),
                      decoration: BoxDecoration(
                          color: AppColors.violet20,
                          borderRadius: BorderRadius.circular(16)),
                      child: const Text(
                        'No',
                        style: TextStyle(
                            color: AppColors.violet100,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onYes,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 2.h, horizontal: 16.w),
                      decoration: BoxDecoration(
                          color: AppColors.violet100,
                          borderRadius: BorderRadius.circular(16)),
                      child: const Text(
                        'Yes',
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}
