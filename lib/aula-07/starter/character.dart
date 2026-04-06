import 'package:flutter/material.dart';

class Character {
  final String name;
  final String role;
  final int hp;
  int level;

  Character({
    required this.name,
    required this.role,
    required this.hp,
    this.level = 1,
  });

  IconData get icon {
    switch (role) {
      case 'Arqueiro':
        return Icons.gps_fixed;
      case 'Mago':
        return Icons.whatshot;
      default:
        return Icons.shield;
    }
  }
}

final aragorn = Character(name: 'Aragorn', role: 'Guerreiro', hp: 100);
final legolas = Character(name: 'Legolas', role: 'Arqueiro', hp: 90);
final gandalf = Character(name: 'Gandalf', role: 'Mago', hp: 80);
