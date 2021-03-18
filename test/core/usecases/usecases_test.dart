import 'package:app_amoc_ararangua/core/usecases/usecase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'NoParams',
    () {
      final tNoParams = NoParams();

      test(
        'props should be a empty list',
        () async {
          final result = tNoParams.props;

          expect(result, []);
        }
      );
    }
  );

}