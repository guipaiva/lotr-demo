import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BattleScreen(),
  ));
}

class BattleScreen extends StatefulWidget {
  const BattleScreen({super.key});

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  int hp = 100;
  int xp = 0;
  int nivel = 1;
  String log = '';

  Color get hpColor {
    if (hp > 50) return Colors.green.shade700;
    if (hp > 25) return Colors.orange;
    return Colors.red;
  }

  void _atacar() {
    setState(() {
      hp = (hp - 20).clamp(0, 100);
      xp = xp + 15;
      if (xp >= 100) {
        nivel++;
        xp = 0;
        log = 'Aragorn subiu para o nível $nivel!';
      } else {
        log = hp == 0
            ? 'Aragorn caiu em batalha!'
            : 'Aragorn recebeu 20 de dano! (+15 XP)';
      }
    });
  }

  void _curar() {
    setState(() {
      hp = (hp + 30).clamp(0, 100);
      log = 'Aragorn recuperou 30 HP!';
    });
  }

  void _resetar() {
    setState(() {
      hp = 100;
      xp = 0;
      nivel = 1;
      log = 'Batalha reiniciada!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Batalha na Terra Média'),
        backgroundColor: Colors.brown.shade800,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetar,
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Avatar
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange.shade100,
                    ),
                    padding: EdgeInsets.all(16),
                    child: Icon(
                      Icons.shield,
                      size: 60,
                      color: Colors.deepOrange,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Nome e classe
                  Text(
                    'Aragorn',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.shield, size: 16, color: Colors.deepOrange),
                      SizedBox(width: 4),
                      Text(
                        'Guerreiro',
                        style: TextStyle(color: Colors.grey.shade900, fontSize: 16),
                      ),
                      SizedBox(width: 12),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Nível $nivel',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // HP Bar
                  _buildStatBar('HP', hp, 100, hpColor),
                  SizedBox(height: 8),
                  _buildStatBar('XP', xp, 100, Colors.blue.shade700),
                  SizedBox(height: 20),

                  // Botões de ação
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
                        onPressed: hp > 0 ? _atacar : null,
                      ),
                      SizedBox(width: 12),
                      ElevatedButton.icon(
                        icon: Icon(Icons.favorite),
                        label: Text('Curar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade700,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: hp < 100 ? _curar : null,
                      ),
                    ],
                  ),

                  // Status condicional
                  if (hp == 0) ...[
                    SizedBox(height: 16),
                    Text(
                      'Aragorn caiu em batalha!',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ] else if (hp <= 30) ...[
                    SizedBox(height: 16),
                    Text(
                      'HP crítico!',
                      style: TextStyle(
                        color: Colors.orange.shade800,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],

                  // Log de ação
                  if (log.isNotEmpty) ...[
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.brown.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.brown.shade300),
                      ),
                      child: Text(
                        log,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.brown.shade900,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatBar(String label, int value, int max, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 30,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black),
          ),
        ),
        SizedBox(width: 8),
        Container(
          width: 180,
          height: 18,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(9),
          ),
          alignment: Alignment.centerLeft,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: (value / max) * 180,
            height: 18,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(9),
            ),
          ),
        ),
        SizedBox(width: 8),
        SizedBox(
          width: 50,
          child: Text(
            '$value/$max',
            style: TextStyle(fontSize: 12, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
