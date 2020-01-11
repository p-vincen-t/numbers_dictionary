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

import 'package:clean_code_base/core/network/network_info.dart';
import 'package:clean_code_base/features/number_trivia/datasources/moor_database.dart';
import 'package:clean_code_base/features/number_trivia/datasources/number_trivia_local_data_source.dart';
import 'package:clean_code_base/features/number_trivia/datasources/number_trivia_remote_data_source.dart';
import 'package:clean_code_models/repositories/number_trivia_repository.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'features/number_trivia/repositories/number_trivia_repository_Impl.dart';

final baseSL = GetIt.instance;

void initBaseSL()  {
  baseSL.registerLazySingleton<NumberTriviaRepository>(() =>
      NumberTriviaRepositoryImpl(
          localDataSource: baseSL(),
          remoteDataSource: baseSL(),
          networkInfo: baseSL()));
  baseSL.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(baseSL()));
  baseSL.registerLazySingleton(() => http.Client());
  baseSL.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(baseSL()));
  baseSL.registerLazySingleton(() => DataConnectionChecker());
  baseSL.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(baseSL()));
  baseSL.registerLazySingleton(() => AppDatabase().numberTriviaDao);
}
