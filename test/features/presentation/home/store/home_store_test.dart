import 'package:app_amoc_ararangua/features/presentation/home/store/home_store.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late HomeStore store;

  setUp(() {
    store = HomeStore();
  });

  test('should be an empty list of accounts as initial state', () {
    expect(store.state, 0);
  });

  group('changePage', () {
    test('should return an int', () {
      //Arrange
      var tPage = 1;
      //Act
      store.changePage(tPage);
      //Assert
      store.observer(
        onState: (state) {
          expect(state, tPage);
        }
      );
    });
  });
}