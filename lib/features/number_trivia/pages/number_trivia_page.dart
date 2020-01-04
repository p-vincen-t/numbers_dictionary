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

import 'package:clean_code/features/number_trivia/bloc/bloc.dart';
import 'package:clean_code/features/number_trivia/bloc/number_trivia_bloc.dart';
import 'package:clean_code/features/number_trivia/widgets/widget.dart';
import 'package:clean_code/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberTriviaPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Number Trivia'),
        ),
        body: BlocProvider<NumberTriviaBloc>(
          builder: (_) => sL<NumberTriviaBloc>(),
          child: buildPage(context),
        ),
      );

  Widget buildPage(BuildContext context) => Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Expanded(child: buildBlocSection()),
          SizedBox(
            height: 20,
          ),
          ControlsWidget()
        ],
      );

  Widget buildBlocSection() => BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
        builder: (context, state) {
          if (state is EmptyState) {
            return MessageWidget();
          } else if (state is LoadingState) {
            return LoadingWidget();
          } else if (state is LoadedState) {
            return SuccessWidget(
              numberTrivia: state.numberTrivia,
            );
          } else if (state is ErrorState) {
            return ErrorNumberTriviaWidget(
              failure: state.failure,
            );
          }
          return Text('not loaded yet');
        },
      );
}
