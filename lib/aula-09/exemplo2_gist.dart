import 'dart:convert';
import 'package:http/http.dart' as http;

// Substitua pela sua chave antes de rodar
const _apiKey = 'YOUR_API_KEY_HERE';

void main() async {
  final url = Uri.parse(
    'https://the-one-api.dev/v2/character?name=/aragorn/i&limit=5',
  );

  final response = await http.get(url, headers: {
    'Authorization': 'Bearer $_apiKey',
  });

  print('Status: ${response.statusCode}');

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final docs = data['docs'] as List<dynamic>;
    print('Total encontrado: ${data['total']}');
    print('---');
    for (final doc in docs) {
      print('${doc['name']} — ${doc['race']}');
    }
  } else {
    print('Erro: ${response.body}');
  }
}
