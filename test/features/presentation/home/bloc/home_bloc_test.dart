import 'package:app_amoc_ararangua/core/states/bloc_state.dart';
import 'package:app_amoc_ararangua/features/presentation/home/bloc/events/home_bloc_event.dart';
import 'package:app_amoc_ararangua/features/presentation/home/bloc/home_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('changePage', () {
    const tPage = 1;
    blocTest(
      'should return an SuccessBlocState<int>',
      build: () => HomeBloc(),
      act: (HomeBloc bloc) => bloc.add(const PageHomeBlocEvent(page: tPage)),
      expect: () => [BlocState.success(tPage)],
    );
  }
  );
}
