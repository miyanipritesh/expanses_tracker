import 'dart:convert';

List<Quote?>? quoteFromJson(String str) => json.decode(str) == null
    ? []
    : List<Quote?>.from(json.decode(str)!.map((x) => Quote.fromJson(x)));

String quoteToJson(List<Quote?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class Quote {
  Quote({
    this.quoteText,
    this.quoteAuthor,
  });

  String? quoteText;
  String? quoteAuthor;

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        quoteText: json["quoteText"],
        quoteAuthor: json["quoteAuthor"],
      );

  Map<String, dynamic> toJson() => {
        "quoteText": quoteText,
        "quoteAuthor": quoteAuthor,
      };
}
