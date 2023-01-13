import 'package:flutter/material.dart';
import 'package:money_expance/utilies/constant.dart';

class CardWidget extends StatelessWidget {
  final String? category;
  final String? price;
  final String? time;
  final String? description;

  const CardWidget(
      {Key? key, this.category, this.time, this.description, this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 89,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: AppColors.lite20.withOpacity(0.045),
          borderRadius: BorderRadius.circular(24)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: getLiteColor(category.toString()),
                borderRadius: BorderRadius.circular(16)),
            child: Image.asset(getImage(category.toString()),
                height: 30, width: 30),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        category.toString(),
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black50),
                      ),
                      Text(
                        price.toString(),
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.red100),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          description.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppColors.lite20),
                        ),
                      ),
                      Text(
                        time.toString(),
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.lite20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

getImage(String category) {
  switch (category.toLowerCase()) {
    case 'shopping':
      return AppImage.shopping;
    case 'subscription':
      return AppImage.bill;
    case 'food':
      return AppImage.restaurant;
    case 'transportation':
      return AppImage.transportation;
    default:
      return AppImage.salary;
  }
}

Color? getLiteColor(String category) {
  switch (category.toLowerCase()) {
    case 'shopping':
      return AppColors.yellow20;
    case 'subscription':
      return AppColors.violet20;
    case 'food':
      return AppColors.red100.withOpacity(0.20);
    case 'transportation':
      return AppColors.blue20;
    case 'salary':
      return AppColors.green20;
    default:
      return AppColors.blue20;
  }
}

Color? getColor1(String category) {
  switch (category.toLowerCase()) {
    case 'shopping':
      return AppColors.yellow100;
    case 'subscription':
      return AppColors.violet100;
    case 'food':
      return AppColors.red100;
    case 'transportation ':
      return AppColors.green100;
    case 'transportation':
      return AppColors.blue100;
    case 'salary':
      return AppColors.green100;
    default:
      return AppColors.blue100;
  }
}
