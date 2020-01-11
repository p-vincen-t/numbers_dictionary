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

import 'dart:async';

import 'package:clean_code_base/core/errors/exceptions.dart';
import 'package:clean_code_base/features/number_trivia/datasources/moor_database.dart';
import 'package:clean_code_models/number_trivia.dart';

abstract class NumberTriviaLocalDataSource {
  Stream<List<NumberTrivia>> getAllSavedNumberTriviaAsStream();

  Future<int> saveNumberTrivia(NumberTrivia numberTriviaModel);

  Future<List<NumberTrivia>> getAllNumberTriviaContainingNumber(int number);

  Future<bool> deleteAllNumberTrivia();

  Future<bool> deleteNumberTrivia(NumberTrivia numberTrivia);
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final NumberTriviaDao appDatabase;

  NumberTriviaLocalDataSourceImpl(
    this.appDatabase,
  );

  @override
  Future<int> saveNumberTrivia(NumberTrivia numberTriviaModel) =>
      appDatabase.insertNumberTrivia(
        NumberTriviaTableData(
          id: numberTriviaModel.id,
          triviaText: numberTriviaModel.text,
          triviaNumber: numberTriviaModel.number as String,
          addedAt: DateTime.now(),
        ),
      );

  @override
  Stream<List<NumberTrivia>> getAllSavedNumberTriviaAsStream() =>
      appDatabase.watchAllNumberTriviaAsStream().map(
            (list) => _extractTrivia(list),
          );

  List<NumberTrivia> _extractTrivia(List<NumberTriviaTableData> list) =>
      list.map(
        (data) => NumberTrivia((b) => b
          ..text = data.triviaText
          ..id = data.id
          ..number = data.triviaNumber as int),
      );

  @override
  Future<List<NumberTrivia>> getAllNumberTriviaContainingNumber(
      int number) async {
    final variableName = _extractTrivia(
      await appDatabase.getAllNumberTriviaForLike(
        number,
      ),
    );
    if (variableName.isEmpty) {
      throw CacheException();
    }
    return Future.value(
      variableName,
    );
  }

  @override
  Future<bool> deleteAllNumberTrivia() => appDatabase.clearNumberTrivia();

  @override
  Future<bool> deleteNumberTrivia(NumberTrivia numberTrivia) =>
      appDatabase.deleteNumberTrivia(NumberTriviaTableData(
          id: numberTrivia.id,
          triviaNumber: numberTrivia.number as String,
          triviaText: numberTrivia.text));
}
