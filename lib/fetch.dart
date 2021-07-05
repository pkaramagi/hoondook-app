import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hoondok/models/category.dart';


// A function that converts a response body into a List<Photo>.
List<HdkCategory> parseCategories(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<HdkCategory>((json) => HdkCategory.fromJson(json)).toList();
}

Future<List<HdkCategory>> fetchCategories(http.Client client) async {
  final response =
  await client.get('https://jsonplaceholder.typicode.com/photos');
  
  return  parseCategories(response.body);
}

