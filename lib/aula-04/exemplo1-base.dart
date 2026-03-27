import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: CharacterScreen()),
  );
}

//
// TODO 4: No Text de HP, troque o 100 fixo pela variável hp
//         Na barra de HP, troque a largura fixa 200 por: hp * 2.0

class _CharacterState extends State<CharacterScreen> {
  int hp = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOTR Battle'),
        backgroundColor: Colors.brown.shade800,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(24),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.orange.shade100,
                  child: Icon(Icons.shield, size: 40, color: Colors.deepOrange),
                ),
                SizedBox(height: 12),
                Text(
                  'Aragorn',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.shield, size: 16, color: Colors.deepOrange),
                    SizedBox(width: 4),
                    Text(
                      'Guerreiro',
                      style: TextStyle(color: Colors.grey.shade900),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  width: 200,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 2.0 * hp,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.green.shade700,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'HP: $hp / 100',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  State<CharacterScreen> createState() => _CharacterState();
}
