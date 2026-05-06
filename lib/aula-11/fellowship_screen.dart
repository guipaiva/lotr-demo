import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'character.dart';
import 'battle_screen.dart';
import 'new_character_screen.dart';
import 'races_screen.dart';

class FellowshipScreen extends StatelessWidget {
  const FellowshipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Sociedade do Anel'),
            if (user != null)
              Text(
                user.email ?? '',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
              ),
          ],
        ),
        backgroundColor: Colors.brown.shade800,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_book),
            tooltip: 'Raças',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RacesScreen()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: fellowship.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final characters = snapshot.data!.docs
              .map((doc) => Character.fromDoc(doc))
              .toList();
          if (characters.isEmpty) {
            return const Center(child: Text('Nenhum personagem na Sociedade ainda.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: characters.length,
            itemBuilder: (context, i) => _buildCard(context, characters[i]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown.shade700,
        foregroundColor: Colors.white,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const NewCharacterScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCard(BuildContext context, Character character) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.brown.shade100,
          backgroundImage: character.imageUrl != null
              ? NetworkImage(character.imageUrl!) as ImageProvider
              : AssetImage(character.raceAsset),
        ),
        title: Text(character.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${character.race} · ${character.role} · Nível ${character.level}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => BattleScreen(character: character)),
        ),
      ),
    );
  }
}
