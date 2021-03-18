import 'package:app_amoc_ararangua/core/usecases/usecase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tNoParams = NoParams();

  test(
    'should be a subclass of AccountEntity',
    () async {
      final result = tNoParams.props;
      expect(result, []);
    }
  );

}