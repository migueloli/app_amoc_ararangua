import '../models/category_model.dart';

abstract class ICategoriesRemoteDataSource {
  Future<List<CategoryModel>> getListOfCategories();
}
