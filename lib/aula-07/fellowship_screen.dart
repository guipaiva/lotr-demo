import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'character.dart';
import 'battle_screen.dart';

class FellowshipScreen extends StatelessWidget {
  const FellowshipScreen({super.key});

  void _addBoromir() {
    fellowship.add({
      'name': 'Boromir',
      'role': 'Guerreiro',
      'hp': 95,
      'level': 1,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sociedade do Anel'),
        backgroundColor: Colors.brown.shade800,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: fellowship.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final characters = snapshot.data!.docs
              .map((doc) => Character.fromDoc(doc))
              .toList();
          return ListView.builder(
            itemCount: characters.length,
            itemBuilder: (context, i) => _buildTile(context, characters[i]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown.shade700,
        foregroundColor: Colors.white,
        onPressed: _addBoromir,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTile(BuildContext context, Character character) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.brown.shade100,
        child: Icon(character.icon, size: 28, color: Colors.deepOrange),
      ),
      title: Text(
        character.name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      subtitle: Text(
        character.role,
        style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
      ),
      trailing: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.amber.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'Nível ${character.level}',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.amber.shade900,
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BattleScreen(character: character),
          ),
        );
      },
    );
  }
}
