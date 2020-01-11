// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps
class NumberTriviaTableData extends DataClass
    implements Insertable<NumberTriviaTableData> {
  final int id;
  final String triviaNumber;
  final String triviaText;
  final DateTime addedAt;
  NumberTriviaTableData(
      {@required this.id,
      @required this.triviaNumber,
      @required this.triviaText,
      this.addedAt});
  factory NumberTriviaTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return NumberTriviaTableData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      triviaNumber: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}trivia_number']),
      triviaText: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}trivia_text']),
      addedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}added_at']),
    );
  }
  factory NumberTriviaTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return NumberTriviaTableData(
      id: serializer.fromJson<int>(json['id']),
      triviaNumber: serializer.fromJson<String>(json['triviaNumber']),
      triviaText: serializer.fromJson<String>(json['triviaText']),
      addedAt: serializer.fromJson<DateTime>(json['addedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'triviaNumber': serializer.toJson<String>(triviaNumber),
      'triviaText': serializer.toJson<String>(triviaText),
      'addedAt': serializer.toJson<DateTime>(addedAt),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<NumberTriviaTableData>>(
      bool nullToAbsent) {
    return NumberTriviaTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      triviaNumber: triviaNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(triviaNumber),
      triviaText: triviaText == null && nullToAbsent
          ? const Value.absent()
          : Value(triviaText),
      addedAt: addedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(addedAt),
    ) as T;
  }

  NumberTriviaTableData copyWith(
          {int id, String triviaNumber, String triviaText, DateTime addedAt}) =>
      NumberTriviaTableData(
        id: id ?? this.id,
        triviaNumber: triviaNumber ?? this.triviaNumber,
        triviaText: triviaText ?? this.triviaText,
        addedAt: addedAt ?? this.addedAt,
      );
  @override
  String toString() {
    return (StringBuffer('NumberTriviaTableData(')
          ..write('id: $id, ')
          ..write('triviaNumber: $triviaNumber, ')
          ..write('triviaText: $triviaText, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(triviaNumber.hashCode,
          $mrjc(triviaText.hashCode, addedAt.hashCode))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is NumberTriviaTableData &&
          other.id == id &&
          other.triviaNumber == triviaNumber &&
          other.triviaText == triviaText &&
          other.addedAt == addedAt);
}

class NumberTriviaTableCompanion
    extends UpdateCompanion<NumberTriviaTableData> {
  final Value<int> id;
  final Value<String> triviaNumber;
  final Value<String> triviaText;
  final Value<DateTime> addedAt;
  const NumberTriviaTableCompanion({
    this.id = const Value.absent(),
    this.triviaNumber = const Value.absent(),
    this.triviaText = const Value.absent(),
    this.addedAt = const Value.absent(),
  });
  NumberTriviaTableCompanion copyWith(
      {Value<int> id,
      Value<String> triviaNumber,
      Value<String> triviaText,
      Value<DateTime> addedAt}) {
    return NumberTriviaTableCompanion(
      id: id ?? this.id,
      triviaNumber: triviaNumber ?? this.triviaNumber,
      triviaText: triviaText ?? this.triviaText,
      addedAt: addedAt ?? this.addedAt,
    );
  }
}

class $NumberTriviaTableTable extends NumberTriviaTable
    with TableInfo<$NumberTriviaTableTable, NumberTriviaTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $NumberTriviaTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _triviaNumberMeta =
      const VerificationMeta('triviaNumber');
  GeneratedTextColumn _triviaNumber;
  @override
  GeneratedTextColumn get triviaNumber =>
      _triviaNumber ??= _constructTriviaNumber();
  GeneratedTextColumn _constructTriviaNumber() {
    return GeneratedTextColumn('trivia_number', $tableName, false,
        maxTextLength: 10);
  }

  final VerificationMeta _triviaTextMeta = const VerificationMeta('triviaText');
  GeneratedTextColumn _triviaText;
  @override
  GeneratedTextColumn get triviaText => _triviaText ??= _constructTriviaText();
  GeneratedTextColumn _constructTriviaText() {
    return GeneratedTextColumn(
      'trivia_text',
      $tableName,
      false,
    );
  }

  final VerificationMeta _addedAtMeta = const VerificationMeta('addedAt');
  GeneratedDateTimeColumn _addedAt;
  @override
  GeneratedDateTimeColumn get addedAt => _addedAt ??= _constructAddedAt();
  GeneratedDateTimeColumn _constructAddedAt() {
    return GeneratedDateTimeColumn(
      'added_at',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, triviaNumber, triviaText, addedAt];
  @override
  $NumberTriviaTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'number_trivia_table';
  @override
  final String actualTableName = 'number_trivia_table';
  @override
  VerificationContext validateIntegrity(NumberTriviaTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.triviaNumber.present) {
      context.handle(
          _triviaNumberMeta,
          triviaNumber.isAcceptableValue(
              d.triviaNumber.value, _triviaNumberMeta));
    } else if (triviaNumber.isRequired && isInserting) {
      context.missing(_triviaNumberMeta);
    }
    if (d.triviaText.present) {
      context.handle(_triviaTextMeta,
          triviaText.isAcceptableValue(d.triviaText.value, _triviaTextMeta));
    } else if (triviaText.isRequired && isInserting) {
      context.missing(_triviaTextMeta);
    }
    if (d.addedAt.present) {
      context.handle(_addedAtMeta,
          addedAt.isAcceptableValue(d.addedAt.value, _addedAtMeta));
    } else if (addedAt.isRequired && isInserting) {
      context.missing(_addedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, triviaNumber};
  @override
  NumberTriviaTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return NumberTriviaTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(NumberTriviaTableCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.triviaNumber.present) {
      map['trivia_number'] = Variable<String, StringType>(d.triviaNumber.value);
    }
    if (d.triviaText.present) {
      map['trivia_text'] = Variable<String, StringType>(d.triviaText.value);
    }
    if (d.addedAt.present) {
      map['added_at'] = Variable<DateTime, DateTimeType>(d.addedAt.value);
    }
    return map;
  }

  @override
  $NumberTriviaTableTable createAlias(String alias) {
    return $NumberTriviaTableTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(const SqlTypeSystem.withDefaults(), e);
  $NumberTriviaTableTable _numberTriviaTable;
  $NumberTriviaTableTable get numberTriviaTable =>
      _numberTriviaTable ??= $NumberTriviaTableTable(this);
  NumberTriviaDao _numberTriviaDao;
  NumberTriviaDao get numberTriviaDao =>
      _numberTriviaDao ??= NumberTriviaDao(this as AppDatabase);
  @override
  List<TableInfo> get allTables => [numberTriviaTable];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$NumberTriviaDaoMixin on DatabaseAccessor<AppDatabase> {
  $NumberTriviaTableTable get numberTriviaTable => db.numberTriviaTable;
}
