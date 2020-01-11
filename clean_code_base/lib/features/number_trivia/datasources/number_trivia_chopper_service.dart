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

import 'package:chopper/chopper.dart';
import 'number_trivia.dart';

import 'built_value_converter.dart';

part 'number_trivia_chopper_service.chopper.dart';

@ChopperApi(baseUrl: '/')
abstract class NumberTriviaChopperService extends ChopperService {
  @Get(path: '{id}?json')
  Future<Response<NumberTriviaModel>> getNumberTrivia(@Path('id') int id);

  @Get(path: 'random?json')
  Future<Response<NumberTriviaModel>> getRandomTrivia();

  static NumberTriviaChopperService create() {
    final ChopperClient chopperClient = ChopperClient(
      baseUrl: 'http://numbersapi.com',
      services: [
        _$NumberTriviaChopperService(),
      ],
      converter: BuiltValueConverter()
    );
    return _$NumberTriviaChopperService(chopperClient);
  }
}
