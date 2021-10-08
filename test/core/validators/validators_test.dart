import 'package:app_amoc_ararangua/core/validators/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'validateName',
    () {
      test(
        'name invalid because length smaller than 3 (Jo)',
        () {
          //Arrange
          const name = 'Jo';

          //Act
          final result = validateName(name);

          //Assert
          expect(result, invalidShortNameMessage);
        }
      );

      test(
        'name valid (João)',
        () {
          //Arrange
          const name = 'João';

          //Act
          final result = validateName(name);

          //Assert
          expect(result, null);
        }
      );
    }
  );

  group(
    'validateDocument',
    () {
      test(
        'CPF invalid (000.000.000-00)',
        () {
          //Arrange
          const document = '000.000.000-00';

          //Act
          final result = validateDocument(document);

          //Assert
          expect(result, invalidDocumentMessage);
        }
      );

      test(
        'CPF valid (091.748.650-13)',
        () {
          //Arrange
          const document = '091.748.650-13';

          //Act
          final result = validateDocument(document);

          //Assert
          expect(result, null);
        }
      );

      test(
        'CNPJ invalid (00.000.000/0000-00)',
        () {
          //Arrange
          const document = '00.000.000/0000-00';

          //Act
          final result = validateDocument(document);

          //Assert
          expect(result, invalidDocumentMessage);
        }
      );

      test(
        'CNPJ valid (21.629.800/0001-46)',
        () {
          //Arrange
          const document = '21.629.800/0001-46';

          //Act
          final result = validateDocument(document);

          //Assert
          expect(result, null);
        }
      );
    }
  );

  group(
    'validatePhone',
    () {
      test(
        'phone invalid ((99)9999)',
        () {
          //Arrange
          const phone = '(99)9999';

          //Act
          final result = validatePhone(phone);

          //Assert
          expect(result, invalidPhoneMessage);
        }
      );

      test(
        'phone valid with parentheses with dash ((99) 99999-9999)',
        () {
          //Arrange
          const phone = '(99) 99999-9999';

          //Act
          final result = validatePhone(phone);

          //Assert
          expect(result, null);
        }
      );

      test(
        'phone valid with parentheses without dash ((99) 999999999)',
        () {
          //Arrange
          const phone = '(99) 999999999';

          //Act
          final result = validatePhone(phone);

          //Assert
          expect(result, null);
        }
      );

      test(
        'phone valid without parentheses without dash (99999999999)',
        () {
          //Arrange
          const phone = '99999999999';

          //Act
          final result = validatePhone(phone);

          //Assert
          expect(result, null);
        }
      );
    }
  );

  group(
    'validateZip',
    () {
      test(
        'zip code invalid (88.)',
        () {
          //Arrange
          const zip = '88.';

          //Act
          final result = validateZip(zip);

          //Assert
          expect(result, invalidZipCodeMessage);
        }
      );

      test(
        'zip code valid (88.906-664)',
        () {
          //Arrange
          const zip = '88.906-664';

          //Act
          final result = validateZip(zip);

          //Assert
          expect(result, null);
        }
      );
    }
  );

  group(
    'validateAddress',
    () {
      test(
        'address invalid because length smaller than 6 (Rua)',
        () {
          //Arrange
          const address = 'Rua';

          //Act
          final result = validateAddress(address);

          //Assert
          expect(result, invalidShortAddressMessage);
        }
      );

      test(
        'address valid (João)',
        () {
          //Arrange
          const address = 'Rua Teste Novembro';

          //Act
          final result = validateAddress(address);

          //Assert
          expect(result, null);
        }
      );
    }
  );

  group(
    'validateNeighborhood',
    () {
      test(
        'neighborhood invalid because length smaller than 4 (Col)',
        () {
          //Arrange
          const address = 'Col';

          //Act
          final result = validateNeighborhood(address);

          //Assert
          expect(result, invalidShortNeighborhoodMessage);
        }
      );

      test(
        'address valid (Coloninha)',
        () {
          //Arrange
          const address = 'Coloninha';

          //Act
          final result = validateNeighborhood(address);

          //Assert
          expect(result, null);
        }
      );
    }
  );

  group(
    'validateEmail',
    () {
      test(
        'e-mail invalid (teste@)',
        () {
          //Arrange
          const email = 'teste@';

          //Act
          final result = validateEmail(email);

          //Assert
          expect(result, invalidEmailMessage);
        }
      );

      test(
        'e-mail valid (teste@teste.com)',
        () {
          //Arrange
          const email = 'teste@teste.com';

          //Act
          final result = validateEmail(email);

          //Assert
          expect(result, null);
        }
      );
    }
  );

  group(
    'validatePassword',
    () {
      test(
        'password invalid (123)',
        () {
          //Arrange
          const password = '123';

          //Act
          final result = validatePassword(password);

          //Assert
          expect(result, invalidShortPasswordMessage);
        }
      );

      test(
        'password valid (123456)',
        () {
          //Arrange
          const password = '123456';

          //Act
          final result = validatePassword(password);

          //Assert
          expect(result, null);
        }
      );
    }
  );

  group(
    'validateDescription',
    () {
      test(
        'description invalid because length smaller than 20 (Teste)',
        () {
          //Arrange
          const description = 'Teste';

          //Act
          final result = validateDescription(description);

          //Assert
          expect(result, invalidShortDescriptionMessage);
        }
      );

      test(
        'description valid',
        () {
          //Arrange
          const description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque ullamcorper imperdiet arcu, a posuere erat auctor ut. Maecenas vel ornare.';

          //Act
          final result = validateDescription(description);

          //Assert
          expect(result, null);
        }
      );
    }
  );

  group(
    'validateCity',
    () {
      test(
        'description invalid because length smaller than 3 (Te)',
        () {
          //Arrange
          const description = 'Te';

          //Act
          final result = validateCity(description);

          //Assert
          expect(result, invalidShortCityMessage);
        }
      );

      test(
        'description invalid because value is null',
        () {
          //Act
          final result = validateCity(null);

          //Assert
          expect(result, invalidShortCityMessage);
        }
      );

      test(
        'description valid',
        () {
          //Arrange
          const description = 'Florianopolis';

          //Act
          final result = validateCity(description);

          //Assert
          expect(result, null);
        }
      );
    }
  );
}
