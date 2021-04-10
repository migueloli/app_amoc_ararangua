import 'dart:convert';
import 'dart:io';

import 'package:app_amoc_ararangua/core/errors/exceptions.dart';
import 'package:app_amoc_ararangua/features/data/datasources/categories_remote_data_source.dart';
import 'package:app_amoc_ararangua/features/data/models/category_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/fixture_reader.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late CategoriesRemoteDataSourceImplementation dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = CategoriesRemoteDataSourceImplementation(mockDio);
  });

  group(
    'getListOfCategories',
    () {
      final tListOfCategories = [
        CategoryModel(id: 1, description: "Test Category 1"),
        CategoryModel(id: 2, description: "Test Category 2"),
      ];
      final url = 'https://amoc-api.herokuapp.com/api/v1/category';

      test(
        'should return an List<CategoryModel> when the response code is 200(success)',
        () async {
          //Arrange
          final tCategoryListJson = json.decode(fixture('category_list.json'));

          when(() => mockDio.get(any()))
            .thenAnswer(
              (_) async => Response(
                data: tCategoryListJson,
                statusCode: HttpStatus.ok,
                requestOptions: RequestOptions(
                  path: url,
                ),
              )
            );

          //Act
          final result = await dataSource.getListOfCategories();

          //Assert
          verify(() => mockDio.get(url)).called(1);
          expect(result, tListOfCategories);
        }
      );

      test(
        'should throw a ServerException when the response code is a negative response',
        () async {
          //Arrange
          when(() => mockDio.get(any()))
            .thenAnswer(
              (_) async => Response(
                data: 'Something went wrong.',
                statusCode: HttpStatus.notFound,
                requestOptions: RequestOptions(
                  path: url,
                ),
              )
            );

          //Act
          final call = dataSource.getListOfCategories;

          //Assert
          expect(() => call(), throwsA(isA<ServerException>()));
          verify(() => mockDio.get(url)).called(1);
        }
      );
    }
  );

}