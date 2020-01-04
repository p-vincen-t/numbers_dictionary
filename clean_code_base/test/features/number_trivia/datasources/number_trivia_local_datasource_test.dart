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
import 'package:clean_code_base/features/number_trivia/datasources/number_trivia_local_data_source.dart';
import 'package:clean_code_base/features/number_trivia/models/number_trivia.dart';
import 'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../fixtures/fixture_reader.dart';

class MockSharePreferences extends Mock implements SharedPreferences {}

void main() {
  NumberTriviaLocalDataSource dataSource;
  SharedPreferences sharePreferences;
  setUp(() {
    sharePreferences = MockSharePreferences();
    dataSource =
        NumberTriviaLocalDataSourceImpl(sharedPreferences: sharePreferences);
  });

  group('getLastNumberTrivia', () {
    final numberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));
    test(
        'should return number trivia model from shared preferences when there is one in the cache',
        () async {
      when(sharePreferences.getString(any)).thenReturn(fixture('trivia_cached.json'));
      final result = await dataSource.getLastNumberTrivia();
      verify(sharePreferences.getString(CACHED_TRIVIA));
      expect(result, equals(numberTriviaModel));
    });

    test(
        'should return cached exception from shared preferences when there is none in the cache',
            () async {
          when(sharePreferences.getString(any)).thenReturn(null);
          final call = dataSource.getLastNumberTrivia;
          expect(() => call(), throwsA(TypeMatcher<CacheException>()));
        });
  });

  group('cacheNUmberTrivia', () {
    final numberTriviaModel =
    NumberTriviaModel(text: 'test', number: 1);
    test('should call shared preferences to cache the data', () async {
      dataSource.cacheNumberTrivia(numberTriviaModel);
      final expedtedJsonString = json.encode(numberTriviaModel.toJson());
      verify(sharePreferences.setString(CACHED_TRIVIA, expedtedJsonString));
    });
  });
}
