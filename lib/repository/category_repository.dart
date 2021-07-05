import 'package:hoondok/models/category.dart';
import 'package:hoondok/providers/api_provider.dart';
import 'package:hoondok/providers/category_provider.dart';

/// Category Repository 
class CategoryRepository{
  final CategoryProvider provider = CategoryProvider.categoryProvider;
  final ApiProvider apiProvider = ApiProvider.apiProvider;

  
  Future getAllCategories([String prov]){
    if(prov == 'api'){
      return apiProvider.getCategoryData();
    }else{
      return provider.getAllCategories();
    }
  }

  Future getCategory({int id}) => provider.getCategory(id);

  Future insertCategory(HdkCategory cat) => provider.newCategory(cat);



}