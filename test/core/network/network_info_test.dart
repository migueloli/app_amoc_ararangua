import 'package:app_amoc_ararangua/core/network/network_info_implementation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';

class MockInternetConnectionChecker extends Mock implements InternetConnectionChecker {}

void main() {
  late NetworkInfoImplementation networkInfo;
  late InternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImplementation(mockInternetConnectionChecker);
  });

  group(
    'isConnected',
    ()  {
      test(
        'should forward the call to InternetConnectionChecker.hasConnection',
        () async {
          //Arrange
          final tHasConnectionFuture = Future.value(true);
          when(() => mockInternetConnectionChecker.hasConnection).thenAnswer((_) => tHasConnectionFuture);

          //Act
          final result = networkInfo.isConnected;

          //Assert
          expect(result, tHasConnectionFuture);
          verify(() => mockInternetConnectionChecker.hasConnection).called(1);
        }
      );
    }
  );
}
