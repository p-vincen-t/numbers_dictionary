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

library number_trivia_model;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:clean_code_models/number_trivia.dart';

part 'number_trivia.g.dart';

abstract class NumberTriviaModel
    implements Built<NumberTriviaModel, NumberTriviaModelBuilder> {
  // fields go here
  @nullable
  int get id;

  String get text;

  int get number;

  NumberTriviaModel._();

  factory NumberTriviaModel([updates(NumberTriviaModelBuilder b)]) =
      _$NumberTriviaModel;

  NumberTrivia toNumberTrivia() => NumberTrivia((n) => n
    ..number = this.number
    ..text = this.text
    ..id = this.id);

  static Serializer<NumberTriviaModel> get serializer =>
      _$numberTriviaModelSerializer;
}
