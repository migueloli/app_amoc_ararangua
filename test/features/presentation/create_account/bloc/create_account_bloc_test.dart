import 'package:app_amoc_ararangua/core/states/bloc_state.dart';
import 'package:app_amoc_ararangua/features/presentation/create_account/bloc/create_account_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CreateAccountBloc bloc;

  setUp((){
    bloc = CreateAccountBloc();
  });

  test(
    'should be EmptyBlocState as initial state',
    () {
      expect(bloc.state, isA<EmptyBlocState>());
    }
  );

  group(
    'change step',
    () {
      test(
        'should emit [SuccessBlocState]',
        () {
          final event = ChangeStepEvent(step: 1);

          //Arrange
          final expected = [
            SuccessBlocState(value: event.step),
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