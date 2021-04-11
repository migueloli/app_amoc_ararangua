import 'package:app_amoc_ararangua/core/states/bloc_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'EmptyBlocState',
    () {
      var emptyState = BlocState.empty();
      test(
        'test if EmptyBlocState is an extension of BlocState',
        () {
          //Assert
          expect(emptyState, isA<BlocState>());
          expect(emptyState, isA<EmptyBlocState>());
        }
      );

      test(
        'test props of EmptyBlocState as an empty list',
        () {
          //Assert
          expect(emptyState.props, []);
        }
      );
    }
  );

  group(
    'LoadingBlocState',
    () {
      var loadingState = BlocState.loading();
      test(
        'test if LoadingBlocState is an extension of BlocState',
        () {
          //Assert
          expect(loadingState, isA<BlocState>());
          expect(loadingState, isA<LoadingBlocState>());
        }
      );

      test(
        'test props of LoadingBlocState as an empty list',
        () {
          //Assert
          expect(loadingState.props, []);
        }
      );
    }
  );

  group(
    'SuccessBlocState',
    () {
      var successState = BlocState.success(1);
      test(
        'test if SuccessBlocState is an extension of BlocState',
        () {
          //Assert
          expect(successState, isA<BlocState>());
          expect(successState, isA<SuccessBlocState>());
        }
      );

      test(
        'test props of SuccessBlocState is correct',
        () {
          //Assert
          expect(successState.props, [(successState as SuccessBlocState).value]);
        }
      );
    }
  );

  group(
    'ErrorBlocState',
    () {
      var errorState = BlocState.error("");
      test(
        'test if ErrorBlocState is an extension of BlocState',
        () {
          //Assert
          expect(errorState, isA<BlocState>());
          expect(errorState, isA<ErrorBlocState>());
        }
      );

      test(
        'test props of ErrorBlocState is correct',
        () {
          //Assert
          expect(errorState.props, [(errorState as ErrorBlocState).message]);
        }
      );
    }
  );

}