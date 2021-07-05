import 'dart:convert';

///create model for HoonDok Words
class TpWords {

  final int id;
  final String content;
  final String author;
  final String date;
  final String page;
  final int categoryId;
  final int status;

  TpWords({
    this.id,
    this.content,
    this.author,
    this.date,
    this.page,
    this.categoryId,
    this.status,
  });

  ///creates TPWords models from Raw json
  factory TpWords.fromRawJson(String str) => TpWords.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  ///creates TPWords models from json
  factory TpWords.fromJson(Map<String, dynamic> json) => TpWords(
    id: json["id"],
    content: json["content"],
    author: json["author"],
    date: json["date"],
    page: json["page"],
    categoryId: json["category_id"],
    status: json["status"],
  );

  ///creates TPWords models from map
  factory TpWords.fromMap(Map<String, dynamic> json) => TpWords(
    id: json["id"],
    content: json["content"],
    author: json["author"],
    date: json["date"],
    page: json["page"],
    categoryId: json["category_id"],
    status: json["status"],
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "author": author,
    "date": date,
    "page": page,
    "category_id": categoryId,
    "status": status,
  };
}
