import 'package:app_amoc_ararangua/core/errors/failures.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'ServerFailure',
    () {
      final tServerFailure = ServerFailure();

      test(
        'props should be a empty list',
        () async {
          final result = tServerFailure.props;

          expect(result, []);
        }
      );

      test(
        'should be a Failure',
        () async {
          expect(tServerFailure, isA<Failure>());
        }
      );
    }
  );

  group(
    'NetworkFailure',
    () {
      final tNetworkFailure = NetworkFailure();

      test(
        'props should be a empty list',
        () async {
          final result = tNetworkFailure.props;

          expect(result, []);
        }
      );

      test(
        'should be a Failure',
        () async {
          expect(tNetworkFailure, isA<Failure>());
        }
      );
    }
  );
}