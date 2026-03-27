import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CharacterScreen(),
  ));
}

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  int hp = 100;
  int xp = 0;

  Color get hpColor {
    if (hp > 50) return Colors.green.shade700;
    if (hp > 25) return Colors.orange;
    return Colors.red;
  }

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
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.shield, size: 16, color: Colors.deepOrange),
                    SizedBox(width: 4),
                    Text('Guerreiro', style: TextStyle(color: Colors.grey.shade900)),
                  ],
                ),
                SizedBox(height: 16),
                // Barra de HP
                Container(
                  width: 200,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: hp * 2.0,
                    height: 20,
                    decoration: BoxDecoration(
                      color: hpColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'HP: $hp / 100',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(height: 8),
                // Barra de XP
                Container(
                  width: 200,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: xp * 2.0,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade700,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'XP: $xp / 100',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(Icons.flash_on),
                      label: Text('Atacar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade700,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: hp > 0
                          ? () {
                              setState(() {
                                hp = (hp - 20).clamp(0, 100);
                                xp = (xp + 15).clamp(0, 100);
                              });
                            }
                          : null,
                    ),
                    SizedBox(width: 12),
                    ElevatedButton.icon(
                      icon: Icon(Icons.favorite),
                      label: Text('Curar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          hp = (hp + 30).clamp(0, 100);
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12),
                if (hp == 0)
                  Text(
                    'Aragorn caiu em batalha!',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                else if (hp <= 30)
                  Text(
                    'HP crítico!',
                    style: TextStyle(
                      color: Colors.orange.shade800,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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
