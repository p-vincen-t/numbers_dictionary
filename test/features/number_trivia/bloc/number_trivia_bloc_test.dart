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

import 'package:clean_code/core/utils/input_converter.dart';
import 'package:clean_code/features/number_trivia/bloc/bloc.dart';
import 'package:clean_code_domain/core/usecase.dart';
import 'package:clean_code_domain/features/number_trivia/usecases/get_concrete_number_trivia.dart';
import 'package:clean_code_domain/features/number_trivia/usecases/get_random_number_trivia.dart';
import 'package:clean_code_models/core/errors/failure.dart';
import 'package:clean_code_models/number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTriviaUseCase {}

class MockGetRandomNumberTrivia extends Mock
    implements GetRandomNumberTriviaUseCase {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaBloc bloc;
  GetConcreteNumberTriviaUseCase getConcreteNumberTriviaUseCase;
  GetRandomNumberTriviaUseCase getRandomNumberTriviaUseCase;
  InputConverter inputConverter;

  setUp(() {
    inputConverter = MockInputConverter();
    getRandomNumberTriviaUseCase = MockGetRandomNumberTrivia();
    getConcreteNumberTriviaUseCase = MockGetConcreteNumberTrivia();

    bloc = NumberTriviaBloc(
        inputConverter: inputConverter,
        concreteUseCase: getConcreteNumberTriviaUseCase,
        randomUseCase: getRandomNumberTriviaUseCase);
  });

  test('intial state should be empty', () {
    expect(bloc.initialState, equals(EmptyState()));
  });

  group('getTrivia for concrete number', () {
    final numberString = '1';
    final numberPassed = 1;
    final numberTrivia = NumberTrivia(text: 'test trivia', number: 1);

    void seTupInputConverterSuccess() {
      when(inputConverter.stringToUnsignedInteger(any))
          .thenReturn(Right(numberPassed));
    }

    test(
        'should call the input converter to validate and converet the string to an unsigned integer',
        () async {
      seTupInputConverterSuccess();
      bloc.dispatch(GetTriviaForConcreteNumberEvent(numberString));
      await untilCalled(inputConverter.stringToUnsignedInteger(any));
      verify(inputConverter.stringToUnsignedInteger(numberString));
    });

    test('should emit [Error] when input is invalid', () async {
      when(inputConverter.stringToUnsignedInteger(any))
          .thenReturn(Left(InvalidInputFailure()));

      /// register expectation before actual dispatch
      final expected = [
        EmptyState(),
        ErrorState(failure: InvalidInputFailure()),
      ];
      expectLater(bloc.state, emitsInOrder(expected));

      bloc.dispatch(GetTriviaForConcreteNumberEvent(numberString));
    });

    test('should get data from the concrete trivia use case', () async {
      seTupInputConverterSuccess();
      when(getConcreteNumberTriviaUseCase(any))
          .thenAnswer((_) async => Right(numberTrivia));

      bloc.dispatch(GetTriviaForConcreteNumberEvent(numberString));
      await untilCalled(getConcreteNumberTriviaUseCase(any));
      verify(getConcreteNumberTriviaUseCase(NumberParam(number: numberPassed)));
    });

    test(
        'should emit [Empty, Loading, Loaded] when  data is gotten successfully from get concrete use case',
        () async {
      seTupInputConverterSuccess();
      when(getConcreteNumberTriviaUseCase(any))
          .thenAnswer((_) async => Right(numberTrivia));

      /// register expectation before actual dispatch
      final expected = [
        EmptyState(),
        LoadingState(),
        LoadedState(numberTrivia: numberTrivia),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      bloc.dispatch(GetTriviaForConcreteNumberEvent(numberString));
    });

    test('should emit [Loading, Error] when getting data failes', () async {
      seTupInputConverterSuccess();
      when(getConcreteNumberTriviaUseCase(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      /// register expectation before actual dispatch
      final expected = [
        EmptyState(),
        LoadingState(),
        ErrorState(failure: ServerFailure()),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      bloc.dispatch(GetTriviaForConcreteNumberEvent(numberString));
    });

    test(
        'should emit [Loading, Error] with proper message when getting data failes',
        () async {
      seTupInputConverterSuccess();
      when(getConcreteNumberTriviaUseCase(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      /// register expectation before actual dispatch
      final expected = [
        EmptyState(),
        LoadingState(),
        ErrorState(failure: CacheFailure()),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      bloc.dispatch(GetTriviaForConcreteNumberEvent(numberString));
    });
  });

  group('getTrivia for random number', () {
    final numberTrivia = NumberTrivia(text: 'test trivia', number: 1);

    test('should get data from the random trivia use case', () async {
      when(getRandomNumberTriviaUseCase(any))
          .thenAnswer((_) async => Right(numberTrivia));

      bloc.dispatch(GetTriviaForRandomNumberEvent());
      await untilCalled(getRandomNumberTriviaUseCase(any));
      verify(getRandomNumberTriviaUseCase(NoNumberParam()));
    });

    test('should emit [Loading, Loaded] when getting data success', () async {
      when(getRandomNumberTriviaUseCase(any))
          .thenAnswer((_) async => Right(numberTrivia));

      /// register expectation before actual dispatch
      final expected = [
        EmptyState(),
        LoadingState(),
        LoadedState(numberTrivia: numberTrivia),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      bloc.dispatch(GetTriviaForRandomNumberEvent());
    });

    test('should emit [Loading, Error] when getting data failes', () async {
      when(getRandomNumberTriviaUseCase(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      /// register expectation before actual dispatch
      final expected = [
        EmptyState(),
        LoadingState(),
        ErrorState(failure: ServerFailure()),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      bloc.dispatch(GetTriviaForRandomNumberEvent());
    });
  });
}
