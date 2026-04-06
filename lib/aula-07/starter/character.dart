import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Character {
  final String docId;
  final String name;
  final String role;
  final int hp;
  int level;

  Character({
    this.docId = '',
    required this.name,
    required this.role,
    required this.hp,
    this.level = 1,
  });

  // Helper pronto — converte um DocumentSnapshot do Firestore em Character
  factory Character.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Character(
      docId: doc.id,
      name: data['name'] ?? '',
      role: data['role'] ?? '',
      hp: data['hp'] ?? 100,
      level: data['level'] ?? 1,
    );
  }

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
