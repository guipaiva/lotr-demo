import 'package:flutter/material.dart';
import 'race_info.dart';

class RacesScreen extends StatelessWidget {
  const RacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Raças da Terra Média'),
        backgroundColor: Colors.brown.shade800,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<RaceInfo>>(
        future: RaceInfo.loadAll(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final races = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: races.length,
            itemBuilder: (context, i) {
              final race = races[i];
              return Card(
                child: ListTile(
                  leading: Image.asset(
                    race.image,
                    width: 48,
                    height: 48,
                    fit: BoxFit.contain,
                  ),
                  title: Text(race.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(race.description),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
