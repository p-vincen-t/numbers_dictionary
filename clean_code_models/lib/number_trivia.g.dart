// GENERATED CODE - DO NOT MODIFY BY HAND

part of number_trivia;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NumberTrivia extends NumberTrivia {
  @override
  final int id;
  @override
  final String text;
  @override
  final int number;

  factory _$NumberTrivia([void Function(NumberTriviaBuilder) updates]) =>
      (new NumberTriviaBuilder()..update(updates)).build();

  _$NumberTrivia._({this.id, this.text, this.number}) : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('NumberTrivia', 'id');
    }
    if (text == null) {
      throw new BuiltValueNullFieldError('NumberTrivia', 'text');
    }
    if (number == null) {
      throw new BuiltValueNullFieldError('NumberTrivia', 'number');
    }
  }

  @override
  NumberTrivia rebuild(void Function(NumberTriviaBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NumberTriviaBuilder toBuilder() => new NumberTriviaBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NumberTrivia &&
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
    return (newBuiltValueToStringHelper('NumberTrivia')
          ..add('id', id)
          ..add('text', text)
          ..add('number', number))
        .toString();
  }
}

class NumberTriviaBuilder
    implements Builder<NumberTrivia, NumberTriviaBuilder> {
  _$NumberTrivia _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _text;
  String get text => _$this._text;
  set text(String text) => _$this._text = text;

  int _number;
  int get number => _$this._number;
  set number(int number) => _$this._number = number;

  NumberTriviaBuilder();

  NumberTriviaBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _text = _$v.text;
      _number = _$v.number;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NumberTrivia other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$NumberTrivia;
  }

  @override
  void update(void Function(NumberTriviaBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$NumberTrivia build() {
    final _$result =
        _$v ?? new _$NumberTrivia._(id: id, text: text, number: number);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
