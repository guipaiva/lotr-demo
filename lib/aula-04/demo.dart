import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: CharacterScreen()),
  );
}

class CharacterScreen extends StatelessWidget {
  const CharacterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Player Card'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            PlayerCard(
              name: 'Aragorn',
              playerClass: 'Guerreiro',
              level: 5,
              icon: Icons.shield,
              iconColor: Colors.deepOrange,
            ),
            SizedBox(height: 16),
            PlayerCard(
              name: 'Legolas',
              playerClass: 'Arqueiro',
              level: 3,
              icon: Icons.gps_fixed,
              iconColor: Colors.green.shade700,
            ),
            SizedBox(height: 16),
            PlayerCard(
              name: 'Gandalf',
              playerClass: 'Mago',
              level: 10,
              icon: Icons.whatshot,
              iconColor: Colors.deepPurple,
            ),
          ],
        ),
      ),
    );
  }
}

class PlayerCard extends StatelessWidget {
  final String name;
  final String playerClass;
  final int level;
  final IconData icon;
  final Color iconColor;

  const PlayerCard({
    super.key,
    required this.name,
    required this.playerClass,
    required this.level,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.indigo.shade100,
              child: Icon(Icons.person, size: 30, color: Colors.indigo),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    Icon(icon, color: iconColor, size: 18),
                    SizedBox(width: 4),
                    Text(
                      playerClass,
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Nível $level',
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
