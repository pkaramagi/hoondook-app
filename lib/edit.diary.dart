import 'package:flutter/material.dart';
import 'package:hoondok/models/diary.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:hoondok/helpers/slide.helper.dart';
import 'bloc/diary_bloc.dart';
import 'models/tpwords.dart';

class DiaryEditPage extends StatefulWidget {
  
  final HdkDiary diary;
  final TpWords tpwords;
  DiaryEditPage({this.diary,this.tpwords}){

  }
  @override
  _DiaryEditPageWidgetState createState() => _DiaryEditPageWidgetState();
}

class _DiaryEditPageWidgetState extends State<DiaryEditPage>{
  final TextEditingController _diaryTextEditorController = TextEditingController();
  final DiaryBloc diaryBloc = DiaryBloc();

  @override
  Widget build(BuildContext context) {
    _diaryTextEditorController.text = widget.diary.content;
    return Scaffold(
      appBar: AppBar(
        leading: new CloseButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xffE56A6A),
        title: Text('마음 일기 Ten',style: TextStyle(fontWeight: FontWeight.bold),),
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
                        padding: EdgeInsets.only(left:20, top:20,right:20),
                        child: Text(new DateFormat.yMMMd().format(new DateTime.now()))
                    ),
                    Container(
                      padding: EdgeInsets.only(left:20, top:10,right:20, bottom: 10),
                      child: Text(
                        '"${widget.tpwords.content}"',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,  height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide( //                    <--- top side
                            color: Color(0xffdddcdc),
                            width: 0.5,
                          ),
                        ),
                      ),
                      padding: EdgeInsets.only(left:10, top:10,right:10),
                      child: TextField(

                        autofocus: true,
                        maxLines: null,
                        style: TextStyle(fontSize: 20),
                        cursorColor: Color(0xffE56A6A),
                        controller: _diaryTextEditorController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,

                          /**
                              enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(

                              color: Colors.blueAccent,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                      ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),

                           */
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          )

      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.diary.content = _diaryTextEditorController.text;
          diaryBloc.updateDiary(widget.diary);
          Navigator.of(context).pop();
        },
        child: Icon(Icons.send),
        backgroundColor: Color(0xffE56A6A),
      ),

    );
  }

}


