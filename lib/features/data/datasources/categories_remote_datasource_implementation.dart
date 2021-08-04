import 'package:app_amoc_ararangua/core/errors/exceptions.dart';
import 'package:app_amoc_ararangua/features/data/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'categories_remote_datasource.dart';

class CategoriesRemoteDataSourceImplementation extends ICategoriesRemoteDataSource {

  final FirebaseFirestore store;

  CategoriesRemoteDataSourceImplementation(this.store);

  @override
  Future<List<CategoryModel>> getListOfCategories() async {
    try {
      final response = await store.collection('categories').get();

      final categoriesList = <CategoryModel>[];
      for(var doc in response.docs) {
        categoriesList.add(CategoryModel.fromJson(doc.data()));
      }

      return categoriesList;
    } catch(exception) {
      throw ServerException();
    }
  }

}