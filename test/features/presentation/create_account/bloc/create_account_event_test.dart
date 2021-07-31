import 'package:app_amoc_ararangua/features/presentation/profile/bloc/profile_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'ChangeStepEvent',
    () {
      final step = 1;
      var event = ChangeStepEvent(step: step);

      test(
        'test ChangeStepEvent is an extension of CreateAccountEvent',
        () {
          //Assert
          expect(event, isA<ProfileEvent>());
        }
      );

      test(
        'test page of ChangeStepEvent as one(1)',
        () {
          //Assert
          expect(event.step, step);
        }
      );

      test(
        'test props of ChangeStepEvent as a list with step',
        () {
          //Assert
          expect(event.props, [step]);
        }
      );
    }
  );
}