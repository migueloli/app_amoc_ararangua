import 'package:app_amoc_ararangua/core/errors/failures.dart';
import 'package:app_amoc_ararangua/features/domain/entities/category_entity.dart';
import 'package:app_amoc_ararangua/features/domain/repositories/categories_repository.dart';
import 'package:app_amoc_ararangua/features/domain/usecases/get_categories_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCategoriesRepository extends Mock implements ICategoriesRepository {}

void main() {

  late GetCategoriesUseCase usecase;
  late ICategoriesRepository repository;

  setUp(() {
    repository = MockCategoriesRepository();
    usecase = GetCategoriesUseCase(repository);
  });

  group(
    'GetCategoriesUseCase success',
    () {
      test(
        'should get a list of categories from the repository',
        () async {
          //Arrange
          const tListOfCategories = [
            CategoryEntity(id: "", description: 'Test Category 1'),
            CategoryEntity(id: "", description: 'Test Category 2'),
          ];

          when(repository.getListOfCategories).thenAnswer((_) async => const Right(tListOfCategories));

          //Act
          final result = await usecase();

          //Assert
          expect(result, const Right(tListOfCategories));
          verify(() => repository.getListOfCategories()).called(1);
        },
      );
    }
  );

  group(
    'GetCategoriesUseCase failure',
    () {
      test(
        "should get a ServerFailure when don't succeed",
        () async {
          //Arrange
          final tServerFailure = ServerFailure();

          when(repository.getListOfCategories).thenAnswer((_) async => Left(tServerFailure));

          //Act
          final result = await usecase();

          //Assert
          expect(result, Left(tServerFailure));
          verify(() => repository.getListOfCategories()).called(1);
        },
      );

      test(
        'should get a NetworkFailure when out of connectivity',
        () async {
          //Arrange
          final tNetworkFailure = NetworkFailure();

          when(repository.getListOfCategories).thenAnswer((_) async => Left(tNetworkFailure));

          //Act
          final result = await usecase();

          //Assert
          expect(result, Left(tNetworkFailure));
          verify(() => repository.getListOfCategories()).called(1);
        },
      );
    }
  );

}