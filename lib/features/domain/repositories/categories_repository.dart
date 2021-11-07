import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../entities/category_entity.dart';

abstract class ICategoriesRepository {
  Future<Either<Failure, List<CategoryEntity>>> getListOfCategories();
  Future<Either<Failure, CategoryEntity>> saveCategory(CategoryEntity entity);
}
