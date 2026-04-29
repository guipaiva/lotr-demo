import 'package:flutter/material.dart';
import 'character.dart';
import 'battle_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final fellowship = FirebaseFirestore.instance.collection('fellowship');

class FellowshipScreen extends StatelessWidget {
  const FellowshipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sociedade do Anel'),
        backgroundColor: Colors.brown.shade800,
        foregroundColor: Colors.white,
      ),
      // TODO 7: Substitua o ListView por um StreamBuilder<QuerySnapshot>
      //   stream: fellowship.snapshots()
      //   builder: verificar snapshot.hasData, mapear docs para Character
      body: ListView(
        children: [
          _buildTile(context, aragorn),
          _buildTile(context, legolas),
          _buildTile(context, gandalf),
        ],
      ),
      // TODO 8: Adicione um FloatingActionButton que chama fellowship.add({...})
      //   para adicionar Boromir
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
          MaterialPageRoute(builder: (_) => BattleScreen(character: character)),
        );
      },
    );
  }
}
