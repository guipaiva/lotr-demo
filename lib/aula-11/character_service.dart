import 'dart:convert';
import 'package:http/http.dart' as http;
import 'character.dart';

const _baseUrl = 'https://the-one-api.dev/v2';
const _apiKey = String.fromEnvironment('LOTR_API_KEY');

Future<List<Character>> searchCharacters(String query) async {
  final url = '$_baseUrl/character?name=/$query/i&limit=10';
  final response = await http.get(
    Uri.parse(url),
    headers: {'Authorization': 'Bearer $_apiKey'},
  );
  if (response.statusCode != 200) {
    throw Exception('Erro ${response.statusCode}: ${response.body}');
  }
  final data = jsonDecode(response.body) as Map<String, dynamic>;
  final docs = data['docs'] as List<dynamic>;
  return docs.map((c) => Character.fromJson(c as Map<String, dynamic>)).toList();
}
