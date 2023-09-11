import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_gen/story_gen.dart';
import 'package:http/http.dart' as http;

const url = 'https://7f6b-185-10-158-5.ngrok.io';

Future<void> login(String username, String password) async {
  var response = await http.post(
    Uri.parse('$url/login'),
    body: jsonEncode({
      'username': username,
      'password': password,
    }),
  );
  if (response.statusCode != 200) {
    throw Exception();
  }
  var result = jsonDecode(response.body);
  await saveToken(result['token']);
}

Future<List<Character>> getCharacters([http.Client? client]) async {
  var httpClient = client ?? http.Client();
  var response = await httpClient.get(Uri.parse('$url/characters'), headers: {
    'X-API-Key': await getToken(),
  });

  if (response.statusCode != 200) {
    return [];
  }
  var jsonBody = jsonDecode(response.body);
  return [
    for (var jsonCharacter in jsonBody['characters'])
      Character.fromJson(jsonCharacter),
  ];
}

Future<void> saveToken(String token) async {
  var preferences = await SharedPreferences.getInstance();
  await preferences.setString('token', token);
}

Future<String> getToken() async {
  var preferences = await SharedPreferences.getInstance();
  return preferences.getString('token') ?? '';
}
