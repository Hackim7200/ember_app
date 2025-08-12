import 'dart:convert';
import 'dart:developer'; // For log()
import 'package:http/http.dart' as http;

class JokeService {
  static const String _baseUrl =
      'https://v2.jokeapi.dev/joke/Any?blacklistFlags=religious,sexist,explicit';

  static Future<String?> fetchJoke() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['type'] == 'single') {
        return data['joke'];
      } else if (data['type'] == 'twopart') {
        return '${data['setup']} ${data['delivery']}';
      }
    } else {
      log('Failed to load joke: ${response.statusCode}');
    }

    return null;
  }
}
