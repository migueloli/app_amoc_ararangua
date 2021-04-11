import 'package:app_amoc_ararangua/features/presentation/home/bloc/home_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'GetAccountsEvent',
    () {
      var event = GetAccountsEvent();

      test(
        'test GetAccountsEvent is an extension of HomeEvent',
        () {
          //Assert
          expect(event, isA<HomeEvent>());
        }
      );

      test(
        'test props of GetAccountsEvent as an empty list',
        () {
          //Assert
          expect(event.props, []);
        }
      );
    }
  );
}