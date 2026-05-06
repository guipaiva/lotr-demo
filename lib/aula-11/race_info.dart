import 'dart:convert';
import 'package:flutter/services.dart';

class RaceInfo {
  final String name;
  final String image;
  final String description;

  RaceInfo({required this.name, required this.image, required this.description});

  factory RaceInfo.fromJson(Map<String, dynamic> json) => RaceInfo(
        name: json['name'] as String,
        image: json['image'] as String,
        description: json['description'] as String,
      );

  static Future<List<RaceInfo>> loadAll() async {
    final raw = await rootBundle.loadString('assets/races.json');
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => RaceInfo.fromJson(e as Map<String, dynamic>)).toList();
  }
}
