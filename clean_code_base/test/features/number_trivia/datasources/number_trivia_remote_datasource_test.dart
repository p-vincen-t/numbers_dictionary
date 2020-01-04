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

import 'dart:convert';

import 'package:clean_code_base/core/errors/exceptions.dart';
import 'package:clean_code_base/features/number_trivia/datasources/number_trivia_remote_data_source.dart';
import 'package:clean_code_base/features/number_trivia/models/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  NumberTriviaRemoteDataSource remoteDataSource;
  http.Client httpClient;

  setUp(() {
    httpClient = MockHttpClient();
    remoteDataSource = NumberTriviaRemoteDataSourceImpl(httpClient);
  });

  void seTupHttpClient200() {
    when(httpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void seTupHttpClient404() {
    when(httpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getConcreteNumberTrivia', () {
    final number = 1;
    final numberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    test('''should perform a GET request on a url with url
     with number being in the endpoint and application/json header''', () {
      seTupHttpClient200();
      remoteDataSource.getConcreteNumberTrivia(number);

      verify(httpClient.get('http://numbersapi.com/$number', headers: {
        'Content-Type': 'application/json',
      }));
    });

    test('should return number  trvia when response code is 200', () async {
      seTupHttpClient200();

      final result = await remoteDataSource.getConcreteNumberTrivia(number);

      expect(result, equals(numberTriviaModel));
    });

    test('should throw a server exception when code is not 200', () async {
      seTupHttpClient404();

      final call = remoteDataSource.getConcreteNumberTrivia;

      expect(() => call(number), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('getRandomNumberTrivia', () {
    final numberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    test('''should perform a GET request on a url with url
     with number being in the endpoint and application/json header''', () {
      seTupHttpClient200();
      remoteDataSource.getRandomNumberTrivia();

      verify(httpClient.get('http://numbersapi.com/random', headers: {
        'Content-Type': 'application/json',
      }));
    });

    test('should return number  trvia when response code is 200', () async {
      seTupHttpClient200();

      final result = await remoteDataSource.getRandomNumberTrivia();

      expect(result, equals(numberTriviaModel));
    });

    test('should throw a server exception when code is not 200', () async {
      seTupHttpClient404();

      final call = remoteDataSource.getRandomNumberTrivia;

      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
