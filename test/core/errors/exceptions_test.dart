import 'package:app_amoc_ararangua/core/errors/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'ServerException',
    () {
      final tServerException = ServerException();

      test(
        'props should be a empty list',
        () async {
          final result = tServerException.props;

          expect(result, []);
        }
      );

      test(
        'should be an Exception',
        () async {
          expect(tServerException, isA<Exception>());
        }
      );
    }
  );

}