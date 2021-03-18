import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/network/network_info.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/categories_repository.dart';
import '../datasources/categories_remote_datasource.dart';

class CategoriesRepositoryImplementation implements ICategoriesRepository {

  final ICategoriesRemoteDatasource datasource;
  final INetworkInfo networkInfo;

  CategoriesRepositoryImplementation(this.datasource, this.networkInfo);

  @override
  Future<Either<Failure, List<CategoryEntity>>> getListOfCategories() async {
    try {
      final networkConnected = await networkInfo.isConnected;
      if(!networkConnected)
        return Left(NetworkFailure());

      final result = await datasource.getListOfCategories();
      return Right(result);
    } on Exception {
      return Left(ServerFailure());
    }
  }

}