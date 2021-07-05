
import 'package:hoondok/helpers/App.dart';
import 'package:hoondok/models/category.dart';
import 'package:hoondok/providers/db_provider.dart';

class CategoryProvider{
  CategoryProvider._();
  static final CategoryProvider categoryProvider = CategoryProvider._();
  final String categoryTableName = HdkApp.categoryTableName;



  newCategory(HdkCategory category) async{

    //get db connection from DBPRovider
    var db = await DBProvider.db.database;

    //perform insertion
    var rawCategoryData = await db.rawInsert(
        "INSERT INTO $categoryTableName ( `id`,name`, `description`, `created_at`, `status`)"
        "VALUES ( ?,?, ?, ?, ?)",
      [ category.id, category.name, category.description, category.createdAt, category.status]
    );

    return rawCategoryData;
  }

  Future<List<HdkCategory>> getAllCategories() async {
    final db = await DBProvider.db.database;
    var res = await db.query(categoryTableName);
    List<HdkCategory> list = res.isNotEmpty ? res.map((queryResult) => HdkCategory.fromMapNoTPWords(queryResult)).toList() : [];
    return list;
  }

  getCategory(int id) async{
    final db = await DBProvider.db.database;
    var res = await db.query(categoryTableName, where:'id=?', whereArgs: [id]);
    return res.isNotEmpty ? HdkCategory.fromMap(res.first) : null;
  }


}