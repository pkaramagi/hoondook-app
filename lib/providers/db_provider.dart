import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:hoondok/bloc/category_bloc.dart';
import 'package:hoondok/helpers/App.dart';
import 'package:hoondok/models/category.dart';
import 'package:hoondok/models/tpwords.dart';
import 'package:hoondok/providers/api_provider.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// class to setup database and prepare db connection
class DBProvider{

  DBProvider._();
  static final DBProvider db = DBProvider._();

final migrationScript = [
 'DROP TABLE hdk_diary;',
  '''
 CREATE TABLE hdk_diary (
  id INTEGER PRIMARY KEY  ,
  date datetime(6) ,
  image_link varchar(200) ,
  content longtext ,
  tp_words_id int(11) ,
  CONSTRAINT fk_tpwords FOREIGN KEY (tp_words_id) REFERENCES hdk_tpwords(id)
  
);
   '''

];

  final initDatabaseScript = [
    '''
 CREATE TABLE hdk_category (
  id INTEGER PRIMARY KEY  ,
  name varchar(255) ,
  description longtext ,
  created_at datetime(6) ,
  status int(11) 
);
 ''',
    '''
 CREATE TABLE hdk_tpwords (
  id INTEGER PRIMARY KEY  ,
  content longtext ,
  author varchar(255) ,
  date datetime ,
  page varchar(255) ,
  status int(11) ,
  category_id int(11) ,
   CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES hdk_category(id)
);

 ''',
    '''
 CREATE TABLE hdk_diary (
  id INTEGER PRIMARY KEY  ,
  date datetime(6) ,
  image_link varchar(200) ,
  content longtext ,
  tp_words_id int(11) ,
  CONSTRAINT fk_tpwords FOREIGN KEY (tp_words_id) REFERENCES hdk_tpwords(id)
  
);
   '''
  ];

  Database _database;
  bool _databaseExists;



  Future<bool> get checkDatabase async {
    String path = await getDatabasePath();
    return databaseExists(path);
  }

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    //get db path
    String path = await getDatabasePath();

    return await openDatabase(path, version: 4,
        onCreate: (Database db, int version) async {
          initDatabaseScript.forEach((dbScript) async => await db.execute(dbScript) );

          //Install categories on initial db setup
          CategoryBloc categoryBlock = CategoryBloc('api');
          categoryBlock.categories.listen((List<HdkCategory> cat) {
            print(cat);
            cat.forEach((category) async {
              String categoryTable = HdkApp.categoryTableName;
              await db.rawInsert(
                  "INSERT INTO $categoryTable ( `id`,`name`, `description`, `created_at`, `status`) VALUES ( ?,?, ?, ?, ?)",
                  [ category.id, category.name, category.description, category.createdAt, category.status]
              );

              category.tpwords.forEach((tpwords) async {
                String tpWordsTable = HdkApp.tpwordsTableName;
                await db.rawInsert(
                    "INSERT INTO $tpWordsTable ( `content`, `author`, `date`, `page`, `status`, `category_id`) VALUES(?,?,?,?,?,?)",
                    [ tpwords.content, tpwords.author,tpwords.date, tpwords.page, tpwords.status, tpwords.categoryId]
                );
              });
            });
          });


        },

    );
  }


  //returns database path
  Future<String> getDatabasePath() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, HdkApp.dbName);
    return path;
  }

}

