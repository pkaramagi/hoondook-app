import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hoondok/bloc/tpwords_block.dart';
import 'package:hoondok/edit.diary.dart';
import 'package:hoondok/models/diary.dart';
import 'package:intl/intl.dart';
import 'package:hoondok/helpers/slide.helper.dart';

import 'models/tpwords.dart';



class Diary extends StatefulWidget {
  final HdkDiary diary;
  TpWords tpwords;

  Diary({this.diary}) {

  }
  @override
  _DiaryViewPageState createState() => _DiaryViewPageState();
}

class _DiaryViewPageState extends State<Diary> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Color(0xffE56A6A),
        title: Text(
          '마음 일기 Ten', style: TextStyle(fontWeight: FontWeight.bold),),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                    Icons.more_vert
                ),
              )
          ),

        ],
      ),
      body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.file(new File(widget.diary.imageLink)),
                    Container(
                        padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                        child: Text(
                            new DateFormat.yMMMd().format(new DateTime.now()))
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 20, top: 10, right: 20),
                        child: new FutureBuilder<dynamic>(
                            future: new TpWordsBloc().getTpWord(id: widget.diary.tpWordsId), // a Future<String> or null
                            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                              widget.tpwords = snapshot.data;
                              return Text(
                                snapshot.data.content,
                                style: TextStyle(fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    height: 1.5),
                                textAlign: TextAlign.center,
                              );
                            }

                        )
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                      child: Text(
                        widget.diary.content,
                        style: TextStyle(fontSize: 15,
                            fontWeight: FontWeight.normal,
                            height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),

            ],
          )

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            SlideLeftRoute(page: DiaryEditPage(diary:widget.diary, tpwords:widget.tpwords)),
          ).then((value) => setState(() {

          }));
        },
        child: Icon(Icons.edit),
        backgroundColor: Color(0xffE56A6A),
      ),
    );
  }

}
