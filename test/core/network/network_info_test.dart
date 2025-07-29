import 'package:ecommerce_app/core/network/network_info.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'network_info_test.mocks.dart';

// This annotation tells Mockito to generate a mock for the class
@GenerateMocks([InternetConnectionChecker])
void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockChecker;

  setUp(() {
    mockChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(mockChecker);
  });

  test('should forward the call to InternetConnectionChecker.hasConnection',
      () async {
    when(mockChecker.hasConnection).thenAnswer((_) async => true);

    final result = await networkInfo.isConnected;

    verify(mockChecker.hasConnection);
    expect(result, true);
  });

  test(
  'should return false when there is no connection',
  () async {
    when(mockChecker.hasConnection).thenAnswer((_) async => false);

    final result = await networkInfo.isConnected;

    verify(mockChecker.hasConnection);
    expect(result, false);
  },
);
}