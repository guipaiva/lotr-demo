import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final fellowship = FirebaseFirestore.instance.collection('fellowship');

class Character {
  final String docId;
  final String name;
  final String role;
  final int hp;
  final int level;

  Character({
    required this.docId,
    required this.name,
    required this.role,
    required this.hp,
    required this.level,
  });

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
