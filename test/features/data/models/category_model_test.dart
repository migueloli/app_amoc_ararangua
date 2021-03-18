import 'dart:convert';

import 'package:app_amoc_ararangua/features/data/models/category_model.dart';
import 'package:app_amoc_ararangua/features/domain/entities/category_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';
void main() {

  final tCategoryModel = CategoryModel(
    id: 1,
    description: "Test Category",
  );

  test(
    'should be a subclass of CategoryEntity',
    () async {
      expect(tCategoryModel, isA<CategoryEntity>());
    }
  );

  group(
    'fromJson',
    () {
      test(
        'should return a valid model when the JSON is valid',
        () async {
          //Arrange
          final Map<String, dynamic> jsonMap = json.decode(fixture('category.json'));

          //Act
          final result = CategoryModel.fromJson(jsonMap);

          //Assert
          expect(result, tCategoryModel);
        }
      );
    }
  );

  group(
    'toJson',
    () {
      test(
        'should return a JSON map with the proper data',
        () async {
          //Act
          final result = tCategoryModel.toJson();

          //Assert
          final expectedMap = {
            'id': 1,
            'description': "Test Category",
          };
          expect(result, expectedMap);
        }
      );
    }
  );

}