import 'package:app_amoc_ararangua/core/errors/exceptions.dart';
import 'package:app_amoc_ararangua/core/errors/failures.dart';
import 'package:app_amoc_ararangua/core/network/network_info.dart';
import 'package:app_amoc_ararangua/features/data/datasources/categories_remote_datasource.dart';
import 'package:app_amoc_ararangua/features/data/models/category_model.dart';
import 'package:app_amoc_ararangua/features/data/repositories/categories_repository_implementation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCategoriesDatasource extends Mock implements ICategoriesRemoteDataSource {}
class MockNetworkInfo extends Mock implements INetworkInfo {}

void main() {

  late CategoriesRepositoryImplementation repository;
  late ICategoriesRemoteDataSource datasource;
  late INetworkInfo networkInfo;

  setUp(() {
    datasource = MockCategoriesDatasource();
    networkInfo = MockNetworkInfo();
    repository = CategoriesRepositoryImplementation(datasource, networkInfo);
  });

  group(
    'getListOfCategories success',
    () {
      test(
        'should return a list of categories models when calls the datasource',
        () async {
          //Arrange
          const tListOfCategories = [
            CategoryModel(id: "", description: "Test Category 1"),
            CategoryModel(id: "", description: "Test Category 2"),
          ];

          when(datasource.getListOfCategories).thenAnswer((_) async => tListOfCategories);
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);

          //Act
          final result = await repository.getListOfCategories();

          //Assert
          expect(result, const Right(tListOfCategories));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.getListOfCategories()).called(1);
        }
      );
    }
  );

  group(
    'getListOfCategories failure',
    () {
      test(
        'should return a ServerFailure when call to datasource is unsuccessful',
        () async {
          //Arrange
          when(datasource.getListOfCategories).thenThrow(ServerException());
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);

          //Act
          final result = await repository.getListOfCategories();

          //Assert
          expect(result, Left(ServerFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verify(() => datasource.getListOfCategories()).called(1);
        }
      );

      test(
        'should return a NetworkFailure when call to datasource is unsuccessful',
        () async {
          //Arrange
          when(() => networkInfo.isConnected).thenAnswer((_) async => false);

          //Act
          final result = await repository.getListOfCategories();

          //Assert
          expect(result, Left(NetworkFailure()));
          verify(() => networkInfo.isConnected).called(1);
          verifyNever(() => datasource.getListOfCategories());
        }
      );
    }
  );

}