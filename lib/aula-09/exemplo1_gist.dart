import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// AULA 9 — Exercício: HTTP + FutureBuilder (Flutter)
// Execute em: https://dartpad.dev
//
// Usamos a PokéAPI (pública, sem autenticação) como laboratório.
// Na aula, trocaremos pela The One API — o padrão é idêntico:
//   PokéAPI       → GET /pokemon?limit=10  → { results: [{ name, url }] }
//   The One API   → GET /character?...     → { docs:    [{ _id, name, race }] }

// TODO 1: Crie a classe Pokemon com os campos:
//   String name, String url
//
// TODO 2: Adicione o factory Pokemon.fromJson(Map<String, dynamic> json)
//   Dica: json['name'], json['url']
//
//   Este é o mesmo padrão do Character.fromDoc() da Aula 8:
//     fromDoc  → Map vem do Firestore (DocumentSnapshot.data())
//     fromJson → Map vem de jsonDecode(response.body)

// TODO 3: Implemente fetchPokemons()
//   URL: https://pokeapi.co/api/v2/pokemon?limit=10
//   Passos:
//     1. http.get(Uri.parse(url))
//     2. Se statusCode != 200 → throw Exception('Erro ${response.statusCode}')
//     3. jsonDecode(response.body) as Map<String, dynamic>
//     4. data['results'] as List<dynamic>
//     5. .map((p) => Pokemon.fromJson(p as Map<String, dynamic>)).toList()
Future<List<Pokemon>> fetchPokemons() async {
  throw UnimplementedError('TODO 3');
}

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PokemonListScreen(),
    ));

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});

  @override
  State<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  // Future armazenado no State — NÃO criar no build() para evitar re-fetch a cada rebuild
  late final Future<List<Pokemon>> _futurePokemons;

  @override
  void initState() {
    super.initState();
    _futurePokemons = fetchPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex'),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Pokemon>>(
        future: _futurePokemons,
        builder: (context, snapshot) {
          // TODO 4: Tratar os 3 estados do snapshot:
          //   snapshot.hasError  → Center > Text('Erro: ${snapshot.error}')
          //   !snapshot.hasData  → Center > CircularProgressIndicator()
          //   snapshot.hasData   → ListView.builder com os pokémons
          //
          // No ListView.builder, mostre cada pokémon como ListTile:
          //   title: Text(pokemon.name)

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
