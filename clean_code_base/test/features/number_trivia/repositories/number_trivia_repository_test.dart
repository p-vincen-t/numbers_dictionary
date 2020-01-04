/*
 * Copyright 2020 Peter Vincent
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:clean_code_base/core/errors/exceptions.dart';
import 'package:clean_code_base/core/network/network_info.dart';
import 'package:clean_code_base/features/number_trivia/datasources/number_trivia_local_data_source.dart';
import 'package:clean_code_base/features/number_trivia/datasources/number_trivia_remote_data_source.dart';
import 'package:clean_code_base/features/number_trivia/models/number_trivia.dart';
import 'package:clean_code_base/features/number_trivia/repositories/number_trivia_repository_Impl.dart';
import 'package:clean_code_models/core/errors/failure.dart';
import 'package:clean_code_models/number_trivia.dart';
import 'package:clean_code_models/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NumberTriviaRepository repository;
  MockRemoteDataSource remoteDataSource;
  MockLocalDataSource localDataSource;
  MockNetworkInfo networkInfo;

  setUp(() {
    remoteDataSource = MockRemoteDataSource();
    localDataSource = MockLocalDataSource();
    networkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
        networkInfo: networkInfo,
        remoteDataSource: remoteDataSource,
        localDataSource: localDataSource);
  });

  void runTestOnline(void body()) => group('device is online', () {
        setUp(() {
          when(networkInfo.isConnected).thenAnswer((_) async => true);
        });
        body();
      });

  void runTestOffline(void body()) => group('device is offline', () {
        setUp(() {
          when(networkInfo.isConnected).thenAnswer((_) async => false);
        });
        body();
      });

  group('getConcreteNumberTrivia', () {
    final number = 1;
    final numberTriviaModel =
        NumberTriviaModel(text: 'test Trivia', number: number);
    final NumberTrivia numberTrivia = numberTriviaModel;

    runTestOnline(() {
      test(
          'should return remote data when the call to remote data source is successfull',
          () async {
        when(remoteDataSource.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => numberTriviaModel);
        final result = await repository.getConcreteNumberTrivia(number);
        verify(remoteDataSource.getConcreteNumberTrivia(number));
        expect(result, equals(Right(numberTrivia)));
      });

      test(
          'should cache  data locally when the call to remote data source is successfull',
          () async {
        when(remoteDataSource.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => numberTriviaModel);
        await repository.getConcreteNumberTrivia(number);
        verify(remoteDataSource.getConcreteNumberTrivia(number));
        verify(localDataSource.cacheNumberTrivia(numberTriviaModel));
      });

      test(
          'should return server failure when the call to remote data source is unSuccessfull',
          () async {
        when(remoteDataSource.getConcreteNumberTrivia(any))
            .thenThrow(ServerException());

        final result = await repository.getConcreteNumberTrivia(number);
        verify(remoteDataSource.getConcreteNumberTrivia(number));
        verifyZeroInteractions(localDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestOffline(() {
      test(
          'should return last locally catched data when catched data is present',
          () async {
        when(localDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => numberTriviaModel);
        final result = await repository.getConcreteNumberTrivia(number);
        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.getLastNumberTrivia());
        expect(result, equals(Right(numberTrivia)));
      });

      test('should return CacheFailure data when catched data is not present',
          () async {
        when(localDataSource.getLastNumberTrivia()).thenThrow(CacheException());
        final result = await repository.getConcreteNumberTrivia(number);
        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.getLastNumberTrivia());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel(text: 'test Trivia', number: 29);
    final NumberTrivia tNumberTrivia = tNumberTriviaModel;

    runTestOnline(() {
      test(
          'should return remote data when the call to remote data source is successfull',
          () async {
        when(remoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        final result = await repository.getRandomNumberTrivia();
        verify(remoteDataSource.getRandomNumberTrivia());
        expect(result, Right(tNumberTriviaModel));
      });

      test(
          'should cache  data locally when the call to remote data source is successfull',
          () async {
        when(remoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        await repository.getRandomNumberTrivia();
        verify(remoteDataSource.getRandomNumberTrivia());
        verify(localDataSource.cacheNumberTrivia(tNumberTriviaModel));
      });

      test(
          'should return server failure when the call to remote data source is unSuccessfull',
          () async {
        when(remoteDataSource.getRandomNumberTrivia())
            .thenThrow(ServerException());

        final result = await repository.getRandomNumberTrivia();
        verify(remoteDataSource.getRandomNumberTrivia());
        verifyZeroInteractions(localDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestOffline(() {
      test(
          'should return last loclly catched data when catched data is present',
          () async {
        when(localDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        final result = await repository.getRandomNumberTrivia();
        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.getLastNumberTrivia());
        expect(result, equals(Right(tNumberTrivia)));
      });

      test('should return CacheFailure data when catched data is not present',
          () async {
        when(localDataSource.getLastNumberTrivia()).thenThrow(CacheException());
        final result = await repository.getRandomNumberTrivia();
        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.getLastNumberTrivia());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
