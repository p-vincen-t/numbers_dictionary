// GENERATED CODE - DO NOT MODIFY BY HAND

part of number_trivia_model;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<NumberTriviaModel> _$numberTriviaModelSerializer =
    new _$NumberTriviaModelSerializer();

class _$NumberTriviaModelSerializer
    implements StructuredSerializer<NumberTriviaModel> {
  @override
  final Iterable<Type> types = const [NumberTriviaModel, _$NumberTriviaModel];
  @override
  final String wireName = 'NumberTriviaModel';

  @override
  Iterable<Object> serialize(Serializers serializers, NumberTriviaModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'text',
      serializers.serialize(object.text, specifiedType: const FullType(String)),
      'number',
      serializers.serialize(object.number, specifiedType: const FullType(int)),
    ];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  NumberTriviaModel deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NumberTriviaModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'text':
          result.text = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'number':
          result.number = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$NumberTriviaModel extends NumberTriviaModel {
  @override
  final int id;
  @override
  final String text;
  @override
  final int number;

  factory _$NumberTriviaModel(
          [void Function(NumberTriviaModelBuilder) updates]) =>
      (new NumberTriviaModelBuilder()..update(updates)).build();

  _$NumberTriviaModel._({this.id, this.text, this.number}) : super._() {
    if (text == null) {
      throw new BuiltValueNullFieldError('NumberTriviaModel', 'text');
    }
    if (number == null) {
      throw new BuiltValueNullFieldError('NumberTriviaModel', 'number');
    }
  }

  @override
  NumberTriviaModel rebuild(void Function(NumberTriviaModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NumberTriviaModelBuilder toBuilder() =>
      new NumberTriviaModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NumberTriviaModel &&
        id == other.id &&
        text == other.text &&
        number == other.number;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, id.hashCode), text.hashCode), number.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('NumberTriviaModel')
          ..add('id', id)
          ..add('text', text)
          ..add('number', number))
        .toString();
  }
}

class NumberTriviaModelBuilder
    implements Builder<NumberTriviaModel, NumberTriviaModelBuilder> {
  _$NumberTriviaModel _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _text;
  String get text => _$this._text;
  set text(String text) => _$this._text = text;

  int _number;
  int get number => _$this._number;
  set number(int number) => _$this._number = number;

  NumberTriviaModelBuilder();

  NumberTriviaModelBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _text = _$v.text;
      _number = _$v.number;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NumberTriviaModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$NumberTriviaModel;
  }

  @override
  void update(void Function(NumberTriviaModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$NumberTriviaModel build() {
    final _$result =
        _$v ?? new _$NumberTriviaModel._(id: id, text: text, number: number);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
