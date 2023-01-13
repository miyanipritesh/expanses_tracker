import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_expance/model/expanses_model.dart';
import 'package:money_expance/module/tabs/home/controller/expance_controller.dart';
import 'package:money_expance/module/tabs/home/widget/card_widget.dart';
import 'package:money_expance/utilies/constant.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class TransationScreen extends StatefulWidget {
  const TransationScreen({Key? key}) : super(key: key);

  @override
  State<TransationScreen> createState() => _TransationScreenState();
}

class _TransationScreenState extends State<TransationScreen> {
  ExpanceController expanceController = Get.put(ExpanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 16, top: 12),
                padding:
                    const EdgeInsets.only(right: 8, top: 4, bottom: 4, left: 4),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.lite20.withOpacity(0.50),
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      AppIcon.arrowDown,
                      color: AppColors.violet100,
                      height: 32,
                      width: 32,
                    ),
                    const Text(
                      'Month',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black50),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Obx(() => ListView.builder(
                    padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
                    itemCount: expanceController.expansesData.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      List<Expanses> q =
                          expanceController.expansesData.reversed.toList();
                      bool isSameDate = true;
                      final DateTime date =
                          DateTime.fromMillisecondsSinceEpoch(q[index].time!);
                      if (index == 0) {
                        isSameDate = false;
                      } else {
                        final DateTime prevDate =
                            DateTime.fromMillisecondsSinceEpoch(
                                q[index - 1].time!);
                        isSameDate = date.isSameDate(prevDate);
                      }
                      if (q.isNotEmpty) {
                        if (index == 0 || !(isSameDate)) {
                          return Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: StickyHeader(
                              header: Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                height: 25,
                                child: Text(
                                  DateTime.now().isSameDate(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              q[index].time!.toInt()))
                                      ? 'Today'
                                      : DateTime.now()
                                              .subtract(const Duration(days: 1))
                                              .isSameDate(DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                      q[index].time!.toInt()))
                                          ? 'Yesterday'
                                          : date.formatDate(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black100,
                                      fontSize: 18),
                                ),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: CardWidget(
                                  category: q[index].category,
                                  description: q[index].description,
                                  price: q[index].price,
                                  time: DateFormat('hh:mm a').format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          q[index].time!.toInt())),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: CardWidget(
                              category: q[index].category,
                              description: q[index].description,
                              price: q[index].price,
                              time: DateFormat('hh:mm a').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      q[index].time!.toInt())),
                            ),
                          );
                        }
                      } else {
                        return const Center(
                            child: Text("No transaction found",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.lite20)));
                      }
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }
}

const String dateFormatter = 'MMMM dd, y';

extension DateHelper on DateTime {
  String formatDate() {
    final formatter = DateFormat(dateFormatter);
    return formatter.format(this);
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}
