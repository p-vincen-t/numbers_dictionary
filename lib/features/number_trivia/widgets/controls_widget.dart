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

import 'package:clean_code/features/number_trivia/bloc/number_trivia_bloc.dart';
import 'package:clean_code/features/number_trivia/bloc/number_trivia_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ControlsWidget extends StatefulWidget {
  const ControlsWidget({
    Key key,
  }) : super(key: key);

  @override
  _ControlsWidgetState createState() => _ControlsWidgetState();
}

class _ControlsWidgetState extends State<ControlsWidget> {
  void dispatchConcrete() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .dispatch(GetTriviaForConcreteNumberEvent(inputStr));
  }

  void dispatchRandom() {
    BlocProvider.of<NumberTriviaBloc>(context)
        .dispatch(GetTriviaForRandomNumberEvent());
  }

  final controller = TextEditingController();
  String inputStr;

  @override
  Widget build(BuildContext context) => Card(
        margin: EdgeInsets.all(0),
        elevation: 16.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    inputStr = value;
                  },
                  onSubmitted: (_) {
                    dispatchConcrete();
                  },
                  decoration: InputDecoration(
                      hintStyle: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      border: OutlineInputBorder(),
                      labelText: 'Trivia number to search',
                      labelStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        onPressed: dispatchConcrete,
                        color: Theme.of(context).primaryColor,
                        textTheme: ButtonTextTheme.primary,
                        child: Text('Get Concrete Trivia'),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        onPressed: dispatchRandom,
                        color: Colors.white54,
                        textTheme: ButtonTextTheme.normal,
                        child: Text('Get Random Trivia'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
