// To parse this JSON data, do
//
//     final budget = budgetFromJson(jsonString);

import 'dart:convert';

List<Budget?>? budgetFromJson(String str) => json.decode(str) == null
    ? []
    : List<Budget?>.from(json.decode(str)!.map((x) => Budget.fromJson(x)));

String budgetToJson(List<Budget?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class Budget {
  Budget(
      {this.id,
      this.category,
      this.isAlert,
      this.budget,
      this.budgetInPercentage,
      this.witchMonth});

  int? id;
  String? category;
  bool? isAlert;
  String? budget;
  String? witchMonth;
  String? budgetInPercentage;

  factory Budget.fromJson(Map<String, dynamic> json) => Budget(
        id: json["id"],
        category: json["category"],
        isAlert: json["isAlert"] == 1 ? true : false,
        budget: json["budget"],
        witchMonth: json["witchMonth"],
        budgetInPercentage: json["budgetInPercentage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "isAlert": isAlert,
        "budget": budget,
        "witchMonth": witchMonth,
        "budgetInPercentage": budgetInPercentage,
      };
}
