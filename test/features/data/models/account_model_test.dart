import 'dart:convert';

import 'package:app_amoc_ararangua/features/data/models/account_model.dart';
import 'package:app_amoc_ararangua/features/domain/entities/account_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const  tAccountModel = AccountModel(
    id: "",
    name: "Test",
    document: "123",
    email: "test@test.com",
    phone: "123456",
    zip: "123456",
    address: "Test",
    number: "123",
    neighborhood: "Test",
    city: "Test",
    state: "Test",
    isWorker: true,
    description: "Test",
    status: 0,
    cause: "Test",
    categoryId: '',
  );

  test(
    'should be a subclass of AccountEntity',
    () async {
      expect(tAccountModel, isA<AccountEntity>());
    }
  );

  group(
    'fromJson',
    () {
      test(
        'should return a valid model when the JSON is valid',
        () async {
          //Arrange
          final Map<String, dynamic> jsonMap = json.decode(fixture('account.json')) as Map<String, dynamic>;

          //Act
          final result = AccountModel.fromJson(jsonMap);

          //Assert
          expect(result, tAccountModel);
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
          final result = tAccountModel.toJson();

          //Assert
          final expectedMap = {
            "id": "",
            "name": "Test",
            "document": "123",
            "email": "test@test.com",
            "phone": "123456",
            "zip": "123456",
            "address": "Test",
            "number": "123",
            "neighborhood": "Test",
            "city": "Test",
            "state": "Test",
            "is_worker": true,
            "description": "Test",
            "status": 0,
            "cause": "Test",
            "categoryId": "",
          };
          expect(result, expectedMap);
        }
      );
    }
  );

}