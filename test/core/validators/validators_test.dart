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
          final name = 'Jo';

          //Act
          final result = validateName(name);

          //Assert
          expect(result, INVALID_SHORT_NAME_MESSAGE);
        }
      );

      test(
        'name valid (João)',
        () {
          //Arrange
          final name = 'João';

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
          final document = '000.000.000-00';

          //Act
          final result = validateDocument(document);

          //Assert
          expect(result, INVALID_DOCUMENT_MESSAGE);
        }
      );

      test(
        'CPF valid (091.748.650-13)',
        () {
          //Arrange
          final document = '091.748.650-13';

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
          final document = '00.000.000/0000-00';

          //Act
          final result = validateDocument(document);

          //Assert
          expect(result, INVALID_DOCUMENT_MESSAGE);
        }
      );

      test(
        'CNPJ valid (21.629.800/0001-46)',
        () {
          //Arrange
          final document = '21.629.800/0001-46';

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
          final phone = '(99)9999';

          //Act
          final result = validatePhone(phone);

          //Assert
          expect(result, INVALID_PHONE_MESSAGE);
        }
      );

      test(
        'phone valid with parentheses with dash ((99) 99999-9999)',
        () {
          //Arrange
          final phone = '(99) 99999-9999';

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
          final phone = '(99) 999999999';

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
          final phone = '99999999999';

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
          final zip = '88.';

          //Act
          final result = validateZip(zip);

          //Assert
          expect(result, INVALID_ZIP_CODE_MESSAGE);
        }
      );

      test(
        'zip code valid (88.906-664)',
        () {
          //Arrange
          final zip = '88.906-664';

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
          final address = 'Rua';

          //Act
          final result = validateAddress(address);

          //Assert
          expect(result, INVALID_SHORT_ADDRESS_MESSAGE);
        }
      );

      test(
        'address valid (João)',
        () {
          //Arrange
          final address = 'Rua Teste Novembro';

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
          final address = 'Col';

          //Act
          final result = validateNeighborhood(address);

          //Assert
          expect(result, INVALID_SHORT_NEIGHBORHOOD_MESSAGE);
        }
      );

      test(
        'address valid (Coloninha)',
        () {
          //Arrange
          final address = 'Coloninha';

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
          final email = 'teste@';

          //Act
          final result = validateEmail(email);

          //Assert
          expect(result, INVALID_EMAIL_MESSAGE);
        }
      );

      test(
        'e-mail valid (teste@teste.com)',
        () {
          //Arrange
          final email = 'teste@teste.com';

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
          final password = '123';

          //Act
          final result = validatePassword(password);

          //Assert
          expect(result, INVALID_SHORT_PASSWORD_MESSAGE);
        }
      );

      test(
        'password valid (123456)',
        () {
          //Arrange
          final password = '123456';

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
          final description = 'Teste';

          //Act
          final result = validateDescription(description);

          //Assert
          expect(result, INVALID_SHORT_DESCRIPTION_MESSAGE);
        }
      );

      test(
        'description valid',
        () {
          //Arrange
          final description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque ullamcorper imperdiet arcu, a posuere erat auctor ut. Maecenas vel ornare.';

          //Act
          final result = validateDescription(description);

          //Assert
          expect(result, null);
        }
      );
    }
  );
}