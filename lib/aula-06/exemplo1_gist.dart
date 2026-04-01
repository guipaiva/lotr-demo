import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: FellowshipScreen()),
  );
}

class Character {
  final String name;
  final String role;
  final IconData icon;
  final int hp;

  Character({
    required this.name,
    required this.role,
    required this.icon,
    required this.hp,
  });
}

final aragorn = Character(
  name: 'Aragorn',
  role: 'Guerreiro',
  icon: Icons.shield,
  hp: 100,
);
final legolas = Character(
  name: 'Legolas',
  role: 'Arqueiro',
  icon: Icons.gps_fixed,
  hp: 90,
);
final gandalf = Character(
  name: 'Gandalf',
  role: 'Mago',
  icon: Icons.whatshot,
  hp: 80,
);

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
      body: ListView(
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.brown.shade100,
              child: Icon(Icons.shield, size: 28, color: Colors.deepOrange),
            ),
            title: Text(
              'Aragorn',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              'Guerreiro',
              style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
            ),
            trailing: Icon(Icons.chevron_right, color: Colors.brown.shade400),
            onTap: () {
              // TODO: navegar para CharacterScreen passando aragorn
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.brown.shade100,
              child: Icon(Icons.gps_fixed, size: 28, color: Colors.deepOrange),
            ),
            title: Text(
              'Legolas',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              'Arqueiro',
              style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
            ),
            trailing: Icon(Icons.chevron_right, color: Colors.brown.shade400),
            onTap: () {
              // TODO: navegar para CharacterScreen passando legolas
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.brown.shade100,
              child: Icon(Icons.whatshot, size: 28, color: Colors.deepOrange),
            ),
            title: Text(
              'Gandalf',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              'Mago',
              style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
            ),
            trailing: Icon(Icons.chevron_right, color: Colors.brown.shade400),
            onTap: () {
              // TODO: navegar para CharacterScreen passando gandalf
            },
          ),
        ],
      ),
    );
  }
}

class CharacterScreen extends StatelessWidget {
  final Character character;

  const CharacterScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
        backgroundColor: Colors.brown.shade800,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(character.icon, size: 80, color: Colors.deepOrange),
            SizedBox(height: 16),
            Text(
              character.name,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              character.role,
              style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
            ),
            SizedBox(height: 8),
            Text(
              'HP: ${character.hp}',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
