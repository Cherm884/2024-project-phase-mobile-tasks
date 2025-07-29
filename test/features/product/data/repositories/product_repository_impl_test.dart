import 'dart:ffi';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/core/platform/network_info.dart';
import 'package:ecommerce_app/features/product/data/datasources/product_local_data_source.dart';
import 'package:ecommerce_app/features/product/data/datasources/product_remote_data_source.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/features/product/domain/entites/product.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockRemoteDataSource extends Mock implements ProductRemoteDataSource {}

class MocklocalDataSource extends Mock implements ProductLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  ProductRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MocklocalDataSource mocklocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mocklocalDataSource = MocklocalDataSource();

    repository = ProductRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mocklocalDataSource,
      networkInfo: mockNetworkInfo,
    );

    void runTestOnline(Function body) {
      group('device is online', () {
        setUp(() {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        });

        body();
      });
    }

     void runTestOffline(Function body) {
      group('device is offline', () {
        setUp(() {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        });

        body();
      });
    }

    group('getAllProducts', () {
      final tProductModel = ProductModel(
        id: '2',
        name: 'Prod2',
        description: 'Desc2',
        price: 30,
        imageUrl: 'url2.png',
      );

      final List<ProductModel> tProductModelList = [tProductModel];
      final List<Product> tProductList = tProductModelList;

      test('should check if the device is online', () async {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        repository.getAllProducts();
        verify(mockNetworkInfo.isConnected);
      });

      runTestOnline( () {
        

        test(
          'should return remote data when the call to remote data source is successful',
          () async {
            // arrange
            when(
              mockRemoteDataSource.getAllProducts(),
            ).thenAnswer((_) async => tProductModelList);

            // act
            final result = await repository.getAllProducts();

            // assert
            verify(mockRemoteDataSource.getAllProducts());
            expect(result, Right(tProductList));
          },
        );

        test(
          'should cache the data locally when the call to remote data source is successful',
          () async {
            // arrange
            when(
              mockRemoteDataSource.getAllProducts(),
            ).thenAnswer((_) async => tProductModelList);

            // act
            await repository.getAllProducts();

            // assert
            verify(mockRemoteDataSource.getAllProducts());
            verify(mocklocalDataSource.cacheProduct(tProductModel));
            test(
              'should return server failure when the call to remote data source is unsuccessful',
              () async {
                // arrange
                when(
                  mockRemoteDataSource.getAllProducts(),
                ).thenThrow(ServerException(e.toString()));

                // act
                final result = await repository.getAllProducts();

                // assert
                verify(mockRemoteDataSource.getAllProducts());
                verifyZeroInteractions(mocklocalDataSource);
                expect(result, Left(CacheException()));
              },
            );
          },
        );

        runTestOffline( () {
          
          test(
            'should return last locally cached date when the cached data is present',
            () async {
              when(
                mocklocalDataSource.getLastProduct(),
              ).thenAnswer((_) async => tProductModel);

              final result = await repository.getAllProducts();
              verifyZeroInteractions(mockRemoteDataSource);
              verify(mocklocalDataSource.getLastProduct());
              expect(result, equals(right(tProductList)));
            },
          );

          test(
            'should return CacheFailure when there is no cached data present',
            () async {
              when(
                mocklocalDataSource.getLastProduct(),
              ).thenThrow(CacheException());

              final result = await repository.getAllProducts();

              verifyZeroInteractions(mockRemoteDataSource);
              verify(mocklocalDataSource.getLastProduct());
              expect(result, equals(Left(tProductList)));
            },
          );
        });
      });
    });
  });
}
