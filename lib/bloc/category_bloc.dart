import 'dart:async';
import 'package:hoondok/models/category.dart';
import 'package:hoondok/repository/category_repository.dart';

/// creates category Bloc
class CategoryBloc {
  final _categoryRepository = CategoryRepository();

  final _categoryController = StreamController<List<HdkCategory>>.broadcast();

  get categories => _categoryController.stream;

  CategoryBloc([String source]){
    if(source == 'api'){
     getCategoriesFromApi();
    }else {
      getCategories();
    }
  }

  //returns categories from db
  getCategories() async{
    _categoryController.sink.add( await _categoryRepository.getAllCategories());
  }

  //returns categories from api to insert in database

  getCategoriesFromApi() async{

    _categoryController.sink.add( await _categoryRepository.getAllCategories('api'));

  }


  getCategory({int id}) async {
    await _categoryRepository.getCategory(id:id);
    getCategories();
  }

  addCategory(HdkCategory cat) async{
    await _categoryRepository.insertCategory(cat);
  }

  dispose(){
    _categoryController.close();
  }
}
