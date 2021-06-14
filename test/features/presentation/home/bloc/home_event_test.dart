import 'package:app_amoc_ararangua/features/presentation/home/bloc/home_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'PageControllerEvent',
    () {
      final page = 1;
      var event = PageControllerEvent(page: page);

      test(
        'test PageControllerEvent is an extension of HomeEvent',
        () {
          //Assert
          expect(event, isA<HomeEvent>());
        }
      );

      test(
        'test page of PageControllerEvent as one(1)',
        () {
          //Assert
          expect(event.page, page);
        }
      );

      test(
        'test props of PageControllerEvent as a list with page',
        () {
          //Assert
          expect(event.props, [page]);
        }
      );
    }
  );
}