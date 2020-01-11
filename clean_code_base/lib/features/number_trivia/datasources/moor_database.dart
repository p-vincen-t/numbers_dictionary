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

import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class NumberTriviaTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get triviaNumber => text().withLength(
        max: 10,
      )();

  TextColumn get triviaText => text()();

  DateTimeColumn get addedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id, triviaNumber};
}

@UseMoor(tables: [NumberTriviaTable], daos: [NumberTriviaDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(
          FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite',
            logStatements: true,
          ),
        );

  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [NumberTriviaTable])
class NumberTriviaDao extends DatabaseAccessor<AppDatabase>
    with _$NumberTriviaDaoMixin {
  final AppDatabase db;

  NumberTriviaDao(
    this.db,
  ) : super(db);

  Future<List<NumberTriviaTableData>> getAllNumberTrivia() => select(
        numberTriviaTable,
      ).get();

  Future<List<NumberTriviaTableData>> getAllNumberTriviaForLike(
    int number,
  ) =>
      (select(
        numberTriviaTable,
      )..where(
              (n) => n.triviaNumber.like(
                number.toString(),
              ),
            ))
          .get();

  Stream<List<NumberTriviaTableData>> watchAllNumberTriviaAsStream() => (select(
        numberTriviaTable,
      )..orderBy(
              [
                (t) => OrderingTerm(
                      expression: t.addedAt,
                      mode: OrderingMode.desc,
                    ),
                (t) => OrderingTerm(
                      expression: t.triviaNumber,
                    ),
              ],
            ))
          .watch();

  Future<int> insertNumberTrivia(
    NumberTriviaTableData data,
  ) =>
      into(
        numberTriviaTable,
      ).insert(
        data,
      );

  Future deleteNumberTrivia(
    NumberTriviaTableData data,
  ) =>
      delete(
        numberTriviaTable,
      ).delete(
        data,
      );

  Future clearNumberTrivia() => delete(
        numberTriviaTable,
      ).go();
}
