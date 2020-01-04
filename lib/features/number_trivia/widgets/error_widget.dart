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
import 'package:clean_code_models/core/errors/failure.dart';
import 'package:flutter/material.dart';

class ErrorNumberTriviaWidget extends StatelessWidget {
  final Failure failure;
  const ErrorNumberTriviaWidget({
    Key key,
    @required this.failure
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        failure is ServerFailure ? 'Server error' :
        failure is InvalidInputFailure ? 'Invalid input detected':  'Cache exception',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}