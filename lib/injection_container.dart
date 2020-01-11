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
import 'package:clean_code/features/number_trivia/bloc/number_trivia_bloc.dart';
import 'package:clean_code_domain/doman_injection_container.dart';
import 'package:get_it/get_it.dart';

final sL = GetIt.instance;

void init() {
  //! register number trivia features
  //! Bloc register
  initDomainSL();

  sL.registerFactory(() => NumberTriviaBloc(
        concreteUseCase: domainSL(),
        randomUseCase: domainSL(),
        inputConverter: sL(),
      ));
  //! register core stuff
  sL.registerLazySingleton(() => InputConverter());
  //! External
}
