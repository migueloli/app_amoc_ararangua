import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/errors/exceptions.dart';
import '../models/category_model.dart';

abstract class ICategoriesRemoteDataSource {

  Future<List<CategoryModel>> getListOfCategories();

}

class CategoriesRemoteDataSourceImplementation extends ICategoriesRemoteDataSource {

  final Dio dio;

  CategoriesRemoteDataSourceImplementation(this.dio);

  @override
  Future<List<CategoryModel>> getListOfCategories() async {
    final response = await dio.get('https://amoc-api.herokuapp.com/api/v1/category');

    if(response.statusCode == HttpStatus.ok) {
      final categoriesList = <CategoryModel>[];
      for(var json in response.data) {
        categoriesList.add(CategoryModel.fromJson(json));
      }

      return categoriesList;
    }

    throw ServerException();
  }

}