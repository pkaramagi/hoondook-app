import 'dart:async';
import 'package:hoondok/models/diary.dart';
import 'package:hoondok/repository/diary_repository.dart';

class DiaryBloc {
  final _diaryRepository = DiaryRepository();

  final _diaryController = StreamController<List<HdkDiary>>.broadcast();

  get diaries => _diaryController.stream;

  DiaryBloc(){

    getDiaries();

  }

  getDiaries() async{
    _diaryController.sink.add( await _diaryRepository.getAllDiaries());
  }

  getDiary({int id}) async {
    await _diaryRepository.getDiary(id:id);
    getDiaries();
  }

  addDiary(HdkDiary diary) async{
    await _diaryRepository.insertDiary(diary);
  }

  updateDiary(HdkDiary diary) async{
    await _diaryRepository.updateDiary(diary);
  }


  dispose(){
    _diaryController.close();
  }
}
