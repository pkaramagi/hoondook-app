import 'dart:convert';

///creates HdkDiary models from json, map
class HdkDiary {
  HdkDiary({
    this.id,
    this.date,
    this.imageLink,
    this.tpWordsId,
    this.content,
    this.author,
  });

  int id;
  DateTime date;
  String imageLink;
  int tpWordsId;
  String content;
  int author;

  ///creates list of HdkDiary Models from json
  List<HdkDiary> diaryFromJson(String str) => List<HdkDiary>.from(json.decode(str).map((x) => HdkDiary.fromJson(x)));

  String diaryToJson(List<HdkDiary> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  ///creates HdkDiary models from json
  factory HdkDiary.fromJson(Map<String, dynamic> json) => HdkDiary(
    id: json["id"],
    date: json["date"],
    imageLink: json["image_link"],
    tpWordsId: json["tp_words_id"],
    content: json["content"],
    author: json["author_id"],
  );

  ///creates HdkDiary models from map
  factory HdkDiary.fromMap(Map<String, dynamic> json) => HdkDiary(
    id: json["id"],
    date: json["date"],
    imageLink: json["image_link"],
    tpWordsId: json["tp_words_id"],
    content: json["content"],
    author: json["author_id"],
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "image_link": imageLink,
    "tp_words_id": tpWordsId,
    "content": content,
    "author": author,
  };
}
