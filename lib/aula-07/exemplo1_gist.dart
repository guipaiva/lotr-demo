// ignore_for_file: avoid_print
import 'dart:async';

// Simula buscar um herói da nuvem — leva 1 segundo para responder
Future<String> buscarHeroi() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Aragorn';
}

// EXERCÍCIO: O código abaixo não imprime o nome do herói corretamente.
// Adicione async e await nos lugares certos para corrigir.

void main() {
  final heroi = buscarHeroi(); // sem await — retorna um Future, não uma String
  print('Herói: $heroi');      // imprime "Instance of Future<String>"
}
