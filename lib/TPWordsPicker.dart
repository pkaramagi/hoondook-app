import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hoondok/bloc/tpwords_block.dart';
import 'package:hoondok/create.diary.dart';
import 'package:http/http.dart' as http;
import 'package:hoondok/models/tpwords.dart';
import 'dart:developer';

import 'helpers/slide.helper.dart';


class TPWordsPicker extends StatefulWidget{

  _TPWordsPickerState createState() => _TPWordsPickerState();
}

class _TPWordsPickerState extends State<TPWordsPicker>{

      // list to track AJAX results
  final TpWordsBloc tpWordsBloc = TpWordsBloc();
     List<TpWords> _tpWordsList;
     TpWords _tpWordsForDiary;

     // init - set initial values
     @override
     void initState() {
       super.initState();
       // initial load


     }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffE56A6A),
          title: Text('마음 일기',style: TextStyle(fontWeight: FontWeight.bold, ),),
        ),
        body: Center(
            child: Container(
                 padding: EdgeInsets.all(30),
                 child: StreamBuilder(
                     stream: tpWordsBloc.tpwords,
                     builder: (BuildContext context, snapshot) {
                       if (snapshot.hasError) {
                         return Text('Something went wrong...');
                       }
                         _tpWordsForDiary = snapshot.data[0];
                       return snapshot.hasData ? Text(_tpWordsForDiary.content, style: TextStyle(fontSize:20, fontWeight: FontWeight.bold,height: 2) ) : Center(child: CircularProgressIndicator());
                     }
                 ),
          ),
        ),

        bottomNavigationBar:BottomNavigationBar(

          type: BottomNavigationBarType.fixed ,
          fixedColor: Color(0xffE56A6A),
          unselectedItemColor: Color(0xffE56A6A),
          currentIndex: 0,

          items: [

            BottomNavigationBarItem(
              icon: Icon(Icons.refresh) ,
              label: 'Refresh'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_forward) ,
                label: 'Continue'
            ),
          ],
          onTap: (index){
            if (index == 0){
              print(_tpWordsForDiary.id.toString()+'yes');
              setState(() {
                tpWordsBloc.getTpWords();

              });
            }else{

              Navigator.push(
                context,
                SlideLeftRoute(page:DiaryAddPage(_tpWordsForDiary)),
              );
            }

          },
        ),


      );
    }

}

