
import 'package:hoondok/models/diary.dart';
import 'package:hoondok/providers/db_provider.dart';

import '../view.diary.dart';

class DiaryProvider{
  DiaryProvider._();
  static final DiaryProvider diaryProvider = DiaryProvider._();
  final String diaryTableName = 'hdk_diary';

  newDiary(HdkDiary diary) async{
    //get db connection from DBPRovider
    var db = await DBProvider.db.database;
  

    //perform insertion
    var raw = await db.rawInsert(
        "INSERT INTO $diaryTableName (`date`, `image_link`, `content`, `tp_words_id`) VALUES (?, ?, ?, ?)",
        [  diary.date, diary.imageLink, diary.content, diary.tpWordsId]
    );
    return raw;
  }

  Future<List<HdkDiary>> getAllDiaries() async {
    final db = await DBProvider.db.database;
    var res = await db.rawQuery('SELECT * FROM $diaryTableName ORDER BY RANDOM()');
    print(res);
    List<HdkDiary> list = res.isNotEmpty ? res.map((queryResult) => HdkDiary.fromMap(queryResult)).toList() : [];
    print('lll'+list[0].id.toString());
    return list;
  }


  getDiary(int id) async{
    final db = await DBProvider.db.database;
    var res = await db.query(diaryTableName, where:'id=?', whereArgs: [id]);
    return res.isNotEmpty ? HdkDiary.fromMap(res.first) : null;
  }

  updateDiary(HdkDiary diary) async{
    final db = await DBProvider.db.database;
    var res = await db.rawUpdate(
        "UPDATE $diaryTableName SET  `content`=?  WHERE id = ? ",
        [diary.content, diary.id]
    );
    return res;
  }



}