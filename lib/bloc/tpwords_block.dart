import 'dart:async';
import 'package:hoondok/models/category.dart';
import 'package:hoondok/models/tpwords.dart';
import 'package:hoondok/repository/category_repository.dart';
import 'package:hoondok/repository/tpwords_repository.dart';

class TpWordsBloc {
  final _tpWordsRepository = TpWordsRepository();

  final _tpWordsController = StreamController<List<TpWords>>.broadcast();

  get tpwords => _tpWordsController.stream;

  TpWordsBloc(){

      getTpWords();

  }

  getTpWords() async{
    _tpWordsController.sink.add( await _tpWordsRepository.getAllTpWords());
  }


  getTpWord({int id}) async {
    return await _tpWordsRepository.getTpWords(id:id);

  }

  addTpWords(TpWords words) async{
    await _tpWordsRepository.insertTpWords(words);

  }

  dispose(){
    _tpWordsController.close();
  }
}
