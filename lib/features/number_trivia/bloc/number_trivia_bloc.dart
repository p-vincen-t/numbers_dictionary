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

import 'package:bloc/bloc.dart';
import 'package:clean_code/core/utils/input_converter.dart';
import 'package:clean_code/features/number_trivia/bloc/number_trivia_event.dart';
import 'package:clean_code/features/number_trivia/bloc/numbr_trivia_state.dart';
import 'package:clean_code_domain/core/usecase.dart';
import 'package:clean_code_domain/features/number_trivia/usecases/get_concrete_number_trivia.dart';
import 'package:clean_code_domain/features/number_trivia/usecases/get_list_of_number_trivia_use_case.dart';
import 'package:clean_code_domain/features/number_trivia/usecases/get_random_number_trivia.dart';
import 'package:clean_code_models/core/errors/failure.dart';
import 'package:clean_code_models/number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTriviaUseCase getConcreteNumberTriviaUseCase;
  final GetRandomNumberTriviaUseCase getRandomNumberTriviaUseCase;
  final GetListOfNumberTriviaUseCase getListOfNumberTriviaUseCase;
  final InputConverter inputConverter;

  NumberTriviaBloc(
      {@required GetConcreteNumberTriviaUseCase concreteUseCase,
      @required GetRandomNumberTriviaUseCase randomUseCase,
      @required GetListOfNumberTriviaUseCase listUseCase,
      @required this.inputConverter})
      : assert(concreteUseCase != null),
        assert(randomUseCase != null),
        assert(inputConverter != null),
        assert(listUseCase != null),
        getConcreteNumberTriviaUseCase = concreteUseCase,
        getRandomNumberTriviaUseCase = randomUseCase,
        getListOfNumberTriviaUseCase = listUseCase;

  void search(String input) {

  }

  @override
  NumberTriviaState get initialState => EmptyState();

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcreteNumberEvent) {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);
      yield* inputEither.fold((failure) async* {
        yield ErrorState(failure: failure);
      }, (integer) async* {
        yield LoadingState();
        final failureOrTrivia =
            await getConcreteNumberTriviaUseCase(NumberParam(number: integer));
        yield* _eitherLoadingOrErrorState(failureOrTrivia);
      });
    } else if (event is GetTriviaForRandomNumberEvent) {
      yield LoadingState();
      final failureOrTrivia =
          await getRandomNumberTriviaUseCase(NoNumberParam());
      yield* _eitherLoadingOrErrorState(failureOrTrivia);
    } else if ((event is GetManyRandomTriviaEvent)) {
      yield LoadingState();
      final failureOrList = await getListOfNumberTriviaUseCase(NoNumberParam());
      yield* failureOrList.fold((failure) async* {
        yield ErrorState(failure: failure);
      }, (list) async* {
        yield LoadedManyState(list);
      });
    }
  }

  Stream<NumberTriviaState> _eitherLoadingOrErrorState(
    Either<Failure, NumberTrivia> either,
  ) async* {
    yield either.fold(
      (failure) => ErrorState(failure: failure),
      (numberTrivia) => LoadedState(numberTrivia: numberTrivia),
    );
  }
}
