import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final fellowship = FirebaseFirestore.instance.collection('fellowship');

class Character {
  final String id;
  final String name;
  final String race;
  final String role; // vazio para resultados da API; preenchido no Firestore
  final int hp;
  final int level;

  Character({
    required this.id,
    required this.name,
    required this.race,
    this.role = '',
    this.hp = 100,
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

  // Aula 8: Character.fromDoc(DocumentSnapshot) — lê do Firestore
  // Aula 9: Character.fromJson(Map<String, dynamic>) — lê da API REST
  // Mesmo padrão de Map → Object; a diferença é só a origem do Map
  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['_id'] as String,
      name: json['name'] as String,
      race: json['race'] as String? ?? '',
    );
  }

  factory Character.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Character(
      id: doc.id,
      name: data['name'] as String? ?? '',
      race: data['race'] as String? ?? '',
      role: data['role'] as String? ?? '',
      hp: data['hp'] as int? ?? 100,
      level: data['level'] as int? ?? 1,
    );
  }
}
