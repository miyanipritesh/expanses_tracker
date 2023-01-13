// To parse this JSON data, do
//
//     final expanses = expansesFromJson(jsonString);

import 'dart:convert';

List<Expanses?>? expansesFromJson(String str) => json.decode(str) == null
    ? []
    : List<Expanses?>.from(json.decode(str)!.map((x) => Expanses.fromJson(x)));

String expansesToJson(List<Expanses?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class Expanses {
  Expanses({
    this.id,
    this.category,
    this.price,
    this.time,
    this.description,
    this.file,
  });

  int? id;
  String? category;
  String? price;
  int? time;
  String? description;
  String? file;

  factory Expanses.fromJson(Map<String, dynamic> json) => Expanses(
        id: json["id"],
        category: json["category"],
        price: json["price"],
        time: json["time"],
        description: json["description"],
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "price": price,
        "time": time,
        "description": description,
        "file": file,
      };
}
