import 'package:app_amoc_ararangua/core/states/bloc_state.dart';
import 'package:app_amoc_ararangua/features/presentation/home/bloc/home_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late HomeBloc bloc;

  setUp((){
    bloc = HomeBloc();
  });

  test(
    'should be EmptyBlocState as initial state',
    () {
      expect(bloc.state, isA<EmptyBlocState>());
    }
  );

  group(
    'change page',
    () {
      test(
        'should emit [SuccessBlocState]',
        () {
          final event = PageControllerEvent(page: 1);

          //Arrange
          final expected = [
            SuccessBlocState(value: event.page),
          ];

          //Assert Later
          expectLater(bloc.stream, emitsInOrder(expected));

          //Act
          bloc.add(event);
        }
      );
    }
  );
}