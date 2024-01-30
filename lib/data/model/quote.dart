import 'dart:convert';

Quote quoteFromJson(String str) => Quote.fromJson(json.decode(str));

class Quote {
  String id;
  String author;
  String quote;
  double? rate;

  Quote({
    required this.id,
    required this.quote,
    required this.author,
    this.rate,
  });

  Quote copyWith({
    String? id,
    String? author,
    String? quote,
    double? rate,
  }) =>
      Quote(
        id: id ?? this.id,
        quote: quote ?? this.quote,
        author: author ?? this.author,
        rate: rate ?? this.rate,
      );

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        id: json["_id"],
        quote: json['content'] ?? json["quoteText"],
        author: json["author"] ?? json['quoteAuthor'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['content'] = quote;
    data['author'] = author;
    return data;
  }
}
