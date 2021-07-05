import 'package:hoondok/models/tpwords.dart';
import 'package:hoondok/providers/tpwords_provider.dart';

/// TPWords Repository
class TpWordsRepository{
  final TpWordsProvider provider = TpWordsProvider.tpWordsProvider;

  Future getAllTpWords(){
      return provider.getAllTpWords();
  }

  
  Future getTpWords({int id}) => provider.getTpWords(id);

  Future insertTpWords(TpWords words) => provider.newTpWords(words);

}