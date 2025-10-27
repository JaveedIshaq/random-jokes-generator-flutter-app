// {
//   "type": "general",
//   "setup": "Why did the scarecrow win an award?",
//   "punchline": "Because he was outstanding in his field.",
//   "id": 333
// }

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Joke {
  Joke({
    required this.type,
    required this.setup,
    required this.punchline,
    required this.id,
  });

  factory Joke.fromJson(Map<String, Object?> json) {
    return Joke(
      type: json['type']! as String,
      setup: json['setup']! as String,
      punchline: json['punchline']! as String,
      id: json['id']! as int,
    );
  }

  final String type;
  final String setup;
  final String punchline;
  final int id;
}

// Dio instance to make HTTP requests

final dio = Dio();

Future<Joke> fetchJoke() async {
  // Fetching a random joke from the Official Joke API
  final response = await dio.get<Map<String, Object?>>(
    'https://official-joke-api.appspot.com/random_joke',
  );

  // Notice we are using fromJson factory constructor to parse the response data
  // and We are not catching errors for us, this is due to purpose, Riverpod will handle it for us

  return Joke.fromJson(response.data!);
}

// creating a Provider for fetching the Data

final randomJokeProvider = FutureProvider<Joke>((ref) async {
  // using the fetchJoke function to get the Joke data
  return fetchJoke();
});
