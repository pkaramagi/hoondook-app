import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hoondok/bloc/diary_bloc.dart';
import 'package:hoondok/models/diary.dart';
import 'package:hoondok/models/tpwords.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:hoondok/helpers/slide.helper.dart';
import 'package:image_picker/image_picker.dart';

//creates diaryadd page
class DiaryAddPage extends StatefulWidget {

  TpWords tpwords;

  DiaryAddPage(TpWords tp){
    this.tpwords = tp;
  }

  @override
  _DiaryAddPageWidgetState createState() => _DiaryAddPageWidgetState();
}

class _DiaryAddPageWidgetState extends State<DiaryAddPage>{

  final _diaryTextEditorController = TextEditingController();
  final DiaryBloc diaryBloc = DiaryBloc();
  File _image;
  Image _diaryImage = Image.asset('assets/images/jump.jpg');
  final diaryImagePicker = ImagePicker( );
  
  Future getDiaryImage() async {
   
    final croppedFile = await ImageCropper.cropImage(
          sourcePath: File((await ImagePicker().getImage(source: ImageSource.camera)).path).path,
          aspectRatioPresets:  [
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio5x3
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarColor: Color(0xffE56A6A),
              statusBarColor: Color(0xffE56A6A),
              activeControlsWidgetColor: Color(0xffE56A6A),
              toolbarTitle: 'Resize',
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.ratio4x3,
              lockAspectRatio: true),
    );
    setState(() {
      if(croppedFile != null){
        _image = File(croppedFile.path);
        _diaryImage = Image.file(_image);
      }
      else{

      }


    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new CloseButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xffE56A6A),
        title: Text(new DateFormat.yMd().format(new DateTime.now())+' 마음 일기',style: TextStyle(fontWeight: FontWeight.bold),),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  getDiaryImage();
                },
                child: Icon(
                    Icons.camera
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
                    Stack(
                      children: [
                        _diaryImage,
                      Positioned(
                          bottom: 0.0,
                          right: 0.0,
                          left: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0.0),
                            child: Container(
                              color:Colors.black.withOpacity(0.5),
                              padding: EdgeInsets.only(left:20, top:10,right:20, bottom: 10),
                              child: Text( widget.tpwords.content,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:Colors.white, height: 1.5),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ),

                      ],
                    ),
                    Container(
                        padding: EdgeInsets.only(left:20, top:20,right:20, bottom: 20),
                        child: Text(new DateFormat.yMMMd().format(new DateTime.now()))
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
                        showCursor: true,
                        maxLines: null,

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
          diaryBloc.addDiary(new HdkDiary(content: _diaryTextEditorController.text,imageLink: _image.path,tpWordsId: widget.tpwords.id  ));
          Navigator.of(context).pop();
        },
        child: Icon(Icons.send),
        backgroundColor: Color(0xffE56A6A),
      ),


    );
  }

}


