import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hoondok/bloc/category_bloc.dart';
import 'package:hoondok/bloc/tpwords_block.dart';
import 'package:hoondok/helpers/App.dart';
import 'package:hoondok/homepage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'create.diary.dart';
import 'helpers/slide.helper.dart';
import 'models/category.dart';

class Install extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Installing'),
        ),
        body: Center(child: Body()),
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
          if (index == 1){
            Navigator.push(
              context,
              SlideLeftRoute(page:HomePage()),
            );
          }

        },
      ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class Body extends StatelessWidget {
  
  final CategoryBloc bloc = CategoryBloc('api');
  final TpWordsBloc tpBloc = TpWordsBloc();



  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: StreamBuilder(
          stream: bloc.categories,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<HdkCategory> cat = snapshot.data;
              cat.forEach((category) { 
                bloc.addCategory(category);
                category.tpwords.forEach((tpWord) {
                  tpBloc.addTpWords(tpWord);
                });
              });
              return Text(snapshot.data.toString());
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}



