import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../entities/category_entity.dart';

abstract class ICategoriesRepository {

  Future<Either<Failure, List<CategoryEntity>>> getListOfCategories();

}