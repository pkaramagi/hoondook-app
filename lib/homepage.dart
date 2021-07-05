import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hoondok/bloc/diary_bloc.dart';
import 'package:hoondok/models/diary.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:hoondok/helpers/slide.helper.dart';
import 'package:hoondok/models/category.dart';
import 'package:hoondok/bloc/category_bloc.dart';
import 'package:hoondok/view.diary.dart';
import 'TPWordsPicker.dart';

class HomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffE56A6A),
        title: Text('마음 일기',style: TextStyle(fontWeight: FontWeight.bold, ),),
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
      body: HomepageWidgets(),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              SlideLeftRoute(page:TPWordsPicker()),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Color(0xffE56A6A),

        )


      );


  }
}

class HomepageWidgets extends StatelessWidget{

  final CategoryBloc categoryBloc = CategoryBloc();
  final DiaryBloc diaryBloc = DiaryBloc();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(

          children: [
            Container(
                padding: EdgeInsets.only(top:10, bottom: 10, right:15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    StreamBuilder(
                      stream:  categoryBloc.categories,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);

                        return snapshot.hasData ? new DropDownList(categories: snapshot.data) : Center(child: CircularProgressIndicator());
                      },
                    ),
                  ],
                )
            ),

            StreamBuilder(
              stream:  diaryBloc.diaries,
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData ? /*HomePagePlaceHolder()*/ DiaryGridviewBuilder(diarylist: snapshot.data) : Center(child: CircularProgressIndicator());
              },
            ),

          ],
        )

    );
  }

}

class DropDownList extends StatefulWidget {

  final List<HdkCategory> categories;
  DropDownList({Key key, this.categories}) : super(key: key);
  @override
  _DropDownListState createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList>{
  String _categorySelection;

  @override
  void initState(){
    _categorySelection = widget.categories[0].name;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        hint: Text(_categorySelection.split('-').last),
        items: catNameList(widget.categories).map((String idNameCombo) {
      return new DropdownMenuItem<String>(
        value: idNameCombo,
        child: new Text(idNameCombo.split('-').last),
      );
    }).toList(),
    onChanged: (idNameCombo) {
          setState(() {

            _categorySelection = idNameCombo;
          });
    },
    );
  }

List<String> catNameList(List<HdkCategory> cat){
  List<String> catNames = List<String>();
     cat.forEach((element) {
      catNames.add(element.id.toString()+'-'+element.name);
    });
    return catNames;
  }
}



class DiaryGridviewBuilder extends StatefulWidget {
  
  final List<HdkDiary> diarylist;

  DiaryGridviewBuilder({this.diarylist}) {
  }

  @override
  _DiaryGridviewBuilderState createState() => _DiaryGridviewBuilderState();
}

class _DiaryGridviewBuilderState extends State<DiaryGridviewBuilder> {
  @override
  Widget build(BuildContext context) {
    return  GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      scrollDirection: Axis.vertical,
      physics: ScrollPhysics(),
      shrinkWrap: true,
      padding:EdgeInsets.only(left: 10),
      itemCount: widget.diarylist.length,
      itemBuilder: (context, index) {
        HdkDiary diary = widget.diarylist[index];
        return Container(
          padding:EdgeInsets.only(right: 10,bottom: 10),
          child:
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                SlideLeftRoute(page:Diary(diary: widget.diarylist[index],)),
              ).then((value) => setState(() {
              }));
            },
            child:    Card(
              color: Color(0xfff5f5f5),
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,

              child: Column(

                children: <Widget>[
                  Image.file(new File(diary.imageLink), height: 110 ,width: 300, fit: BoxFit.fitWidth,),
                  ListTile(
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),

                    title: Text(diary.content, style: TextStyle(fontSize:11, fontWeight: FontWeight.bold, letterSpacing: 0),),
                    subtitle: Text(new DateFormat.yMMMd().format(new DateTime.now()),style: TextStyle(fontSize:10, fontWeight: FontWeight.bold, letterSpacing: 0)),
                  ),
                ],
              ),
            ),
          ),

        );
      },
    );
  }




}

class HomePagePlaceHolder extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
          children: [ Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                    child: Center(
                      child: Text(
                          'What is Happening !!!',
                          maxLines: 1,
                          style: TextStyle(color: Colors.black)
                      ),
                    )
                )]
          ),],
        );
  }





}