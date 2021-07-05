import 'package:hoondok/models/tpwords.dart';


/// creates models of HoonDok Words Categories

class HdkCategory {

  final  int id;
  final String name;
  final String description;
  final String createdAt;
  final int status;
  final List<TpWords> tpwords;

  HdkCategory({this.id, this.name, this.description, this.createdAt, this.status,this.tpwords});
  
  /// create models from Json
  factory HdkCategory.fromJson(Map<String, dynamic> json) => HdkCategory(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    createdAt: json["created_at"],
    status: json["status"],
    tpwords: List<TpWords>.from(json["tpwords"].map((x) => TpWords.fromJson(x))),
  );
  
  /// create models from Json
  factory HdkCategory.fromMap(Map<String, dynamic> json) => HdkCategory(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    createdAt: json["created_at"],
    status: json["status"],
    tpwords: List<TpWords>.from(json["tpwords"].map((x) => TpWords.fromJson(x))),
  );

  /// create models from Json of Categories only
  factory HdkCategory.fromMapNoTPWords(Map<String, dynamic> json) => HdkCategory(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    createdAt: json["created_at"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "created_at": createdAt,
    "status": status,
    "tpwords": List<dynamic>.from(tpwords.map((x) => x.toJson())),
  };


}

