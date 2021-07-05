import 'dart:convert';
import 'package:hoondok/helpers/App.dart';
import 'package:hoondok/models/tpwords.dart';
import 'package:http/http.dart' as http;
import 'package:hoondok/models/category.dart';

/// Api Providedr class
class ApiProvider{

  ApiProvider._();

  static final ApiProvider apiProvider = ApiProvider._();
  final String apiLink = HdkApp.apiLink;
  final http.Client client = http.Client();

  Future<List<HdkCategory>> getCategoryData() async {
    final response = await client.get(apiLink);
    return parseCategories(utf8.decode(response.bodyBytes));
  }

  Future<List<TpWords>> getTpWords() async {
    final response = await client.get(apiLink);
    return parseTpWords(utf8.decode(response.bodyBytes));
  }


  /// converts a response body into a List<HdkCategory>.
  List<HdkCategory> parseCategories(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<HdkCategory>((json) => HdkCategory.fromJson(json)).toList();

  }


  //converts a response body into a List<TpWords>.
  List<TpWords> parseTpWords(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<TpWords>((json) => TpWords.fromJson(json)).toList();
  }


}




