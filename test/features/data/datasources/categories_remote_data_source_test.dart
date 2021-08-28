import 'package:app_amoc_ararangua/features/data/datasources/categories_remote_datasource_implementation.dart';
import 'package:app_amoc_ararangua/features/data/models/category_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CategoriesRemoteDataSourceImplementation dataSource;
  late FakeFirebaseFirestore mockFirebaseStore;

  setUp(() {
    mockFirebaseStore = FakeFirebaseFirestore();
    dataSource = CategoriesRemoteDataSourceImplementation(mockFirebaseStore);
  });

  group(
    'getListOfCategories',
    () {
      const tListOfCategories = [
        CategoryModel(id: "", description: "Test Category 1"),
        CategoryModel(id: "", description: "Test Category 2"),
      ];

      test(
        'should return an List<CategoryModel>',
        () async {
          //Arrange
          for(final tCategory in tListOfCategories) {
            mockFirebaseStore.collection('categories').add(tCategory.toJson());
          }

          //Act
          final result = await dataSource.getListOfCategories();

          //Assert
          expect(result, tListOfCategories);
        }
      );

      // test(
      //   'should throw a ServerException when the response code is a negative response',
      //   () async {
      //     //Arrange
      //     when(() => mockDio.get(any()))
      //       .thenAnswer(
      //         (_) async => Response(
      //           data: 'Something went wrong.',
      //           statusCode: HttpStatus.notFound,
      //           requestOptions: RequestOptions(
      //             path: url,
      //           ),
      //         )
      //       );

      //     //Act
      //     final call = dataSource.getListOfCategories;

      //     //Assert
      //     expect(() => call(), throwsA(isA<ServerException>()));
      //     verify(() => mockDio.get(any())).called(1);
      //   }
      // );
    }
  );

}