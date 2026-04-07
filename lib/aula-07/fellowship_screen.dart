import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'character.dart';
import 'battle_screen.dart';

class FellowshipScreen extends StatelessWidget {
  const FellowshipScreen({super.key});

  void _addCharacter(BuildContext context) {
    final nameController = TextEditingController();
    final hpController = TextEditingController();
    String selectedRole = 'Guerreiro';

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text('Novo personagem'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nome'),
                textCapitalization: TextCapitalization.words,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedRole,
                decoration: InputDecoration(labelText: 'Classe'),
                items: ['Guerreiro', 'Arqueiro', 'Mago']
                    .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                    .toList(),
                onChanged: (value) => setState(() => selectedRole = value!),
              ),
              SizedBox(height: 12),
              TextField(
                controller: hpController,
                decoration: InputDecoration(labelText: 'HP'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text.trim();
                final hp = int.tryParse(hpController.text.trim()) ?? 100;
                if (name.isNotEmpty) {
                  fellowship.add({
                    'name': name,
                    'role': selectedRole,
                    'hp': hp,
                    'level': 1,
                  });
                }
                Navigator.pop(context);
              },
              child: Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
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
          return GridView.builder(
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              childAspectRatio: 0.8,
            ),
            itemCount: characters.length,
            itemBuilder: (context, i) => _buildCard(context, characters[i]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown.shade700,
        foregroundColor: Colors.white,
        onPressed: () => _addCharacter(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildCard(BuildContext context, Character character) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BattleScreen(character: character),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.all(6),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.brown.shade100,
            child: Icon(character.icon, size: 16, color: Colors.deepOrange),
          ),
          SizedBox(height: 4),
          Text(
            character.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.amber.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Nível ${character.level}',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
