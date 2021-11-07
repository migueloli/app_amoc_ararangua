import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/errors/exceptions.dart';
import '../models/category_model.dart';
import 'categories_remote_datasource.dart';

class CategoriesRemoteDataSourceImplementation extends ICategoriesRemoteDataSource {
  final FirebaseFirestore store;

  CategoriesRemoteDataSourceImplementation(this.store);

  @override
  Future<List<CategoryModel>> getListOfCategories() async {
    try {
      final response = await store.collection('categories').get();

      final categoriesList = <CategoryModel>[];
      for(final doc in response.docs) {
        categoriesList.add(CategoryModel.fromJson(doc.data(), id: doc.id));
      }

      return categoriesList;
    } catch(e, s) {
      log(e.toString(), stackTrace: s);

      throw ServerException();
    }
  }

  @override
  Future<CategoryModel> saveCategory(CategoryModel category) async {
    try {
      final response = await store.collection('categories').doc(category.id).get();
      if(response.exists) {
        await response.reference.update(category.toJson());
      } else {
        await store.collection('categories').add(category.toJson());
      }
      return category;
    } catch(e, s) {
      log(e.toString(), stackTrace: s);

      throw ServerException();
    }
  }
}
