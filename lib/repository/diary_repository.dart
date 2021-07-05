import 'package:hoondok/models/diary.dart';
import 'package:hoondok/providers/diary_provider.dart';

/// Diary Repository
class DiaryRepository{
  final DiaryProvider provider = DiaryProvider.diaryProvider;

  Future getAllDiaries(){
    return provider.getAllDiaries();
  }

  Future getDiary({int id}) => provider.getDiary(id);

  Future insertDiary(HdkDiary diary) => provider.newDiary(diary);
  
  Future updateDiary(HdkDiary diary) => provider.updateDiary(diary);

}