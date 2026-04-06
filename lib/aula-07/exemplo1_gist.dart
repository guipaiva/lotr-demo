// ignore_for_file: avoid_print
import 'dart:async';

// Simula buscar um herói da nuvem — leva 1 segundo para responder
Future<String> buscarHeroi() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Aragorn';
}

// EXERCÍCIO: O código abaixo imprime na ordem errada.
// Adicione async/await nos lugares certos para imprimir:
// 1. Buscando herói...
// 2. Herói encontrado: Aragorn
// 3. Missão cumprida!

void main() {
  print('Buscando herói...');
  buscarHeroi().then((heroi) => print('Herói encontrado: $heroi'));
  print('Missão cumprida!');
}
