
import 'package:hoondok/helpers/App.dart';
import 'package:hoondok/models/category.dart';
import 'package:hoondok/models/tpwords.dart';
import 'package:hoondok/providers/db_provider.dart';

class TpWordsProvider{
  TpWordsProvider._();
  static final TpWordsProvider tpWordsProvider = TpWordsProvider._();
  final String tpwordsTableName = HdkApp.tpwordsTableName;

  newTpWords(TpWords tpwords) async{
    //get db connection from DBPRovider
    var db = await DBProvider.db.database;
 

    //perform insertion
    var raw = await db.rawInsert(
        "INSERT INTO $tpwordsTableName ( `content`, `author`, `date`, `page`, `status`, `category_id`) VALUES(?,?,?,?,?,?)",
        [ tpwords.content, tpwords.author,tpwords.date, tpwords.page, tpwords.status, tpwords.categoryId]
    );
    return raw;
  }

  Future<List<TpWords>> getAllTpWords({int categoryId}) async {

    final db = await DBProvider.db.database;
    var res = await db.rawQuery('SELECT * FROM $tpwordsTableName ORDER BY RANDOM()');
    print(res.length);
    List<TpWords> list = res.isNotEmpty ? res.map((queryResult) => TpWords.fromMap(queryResult)).toList() : [];
    return list;
  }


  getTpWords(int id) async{
    final db = await DBProvider.db.database;
    var res = await db.query(tpwordsTableName, where:'id=?', whereArgs: [id]);
    return res.isNotEmpty ? TpWords.fromMap(res.first) : null;
  }



}