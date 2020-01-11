// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'number_trivia_chopper_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$NumberTriviaChopperService extends NumberTriviaChopperService {
  _$NumberTriviaChopperService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = NumberTriviaChopperService;

  Future<Response<NumberTriviaModel>> getNumberTrivia(int id) {
    final $url = '/${id}?json';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<NumberTriviaModel, NumberTriviaModel>($request);
  }

  Future<Response<NumberTriviaModel>> getRandomTrivia() {
    final $url = '/random?json';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<NumberTriviaModel, NumberTriviaModel>($request);
  }
}
