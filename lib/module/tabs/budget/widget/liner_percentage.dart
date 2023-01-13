import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/percent_indicator.dart';

Widget linerPercentage(
    {required double percentage,
    required Color progressColor,
    required Color backGroundColor}) {
  return LinearPercentIndicator(
    lineHeight: 13,
    barRadius: const Radius.circular(15),
    percent: percentage,
    padding: EdgeInsets.zero,
    alignment: MainAxisAlignment.start,
    linearStrokeCap: LinearStrokeCap.roundAll,
    progressColor: progressColor,
    backgroundColor: backGroundColor,
    animation: true,
    animationDuration: 2200,
  );
}
