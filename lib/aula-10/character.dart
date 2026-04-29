import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final fellowship = FirebaseFirestore.instance.collection('fellowship');

class Character {
  final String id;
  final String name;
  final String race;
  final String role;
  final int hp;
  final int level;
  final String? imageUrl;

  Character({
    required this.id,
    required this.name,
    required this.race,
    this.role = '',
    this.hp = 100,
    this.level = 1,
    this.imageUrl,
  });

  String get raceAsset {
    switch (race.toLowerCase()) {
      case 'elf':
        return 'assets/races/elf.png';
      case 'hobbit':
        return 'assets/races/hobbit.png';
      case 'dwarf':
        return 'assets/races/dwarf.png';
      case 'maiar':
        return 'assets/races/wizard.png';
      default:
        return 'assets/races/human.png';
    }
  }

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json['_id'] as String,
        name: json['name'] as String,
        race: json['race'] as String? ?? '',
      );

  factory Character.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Character(
      id: doc.id,
      name: data['name'] as String? ?? '',
      race: data['race'] as String? ?? '',
      role: data['role'] as String? ?? '',
      hp: data['hp'] as int? ?? 100,
      level: data['level'] as int? ?? 1,
      imageUrl: data['imageUrl'] as String?,
    );
  }
}
