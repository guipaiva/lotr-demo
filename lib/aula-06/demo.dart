import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FellowshipScreen(),
  ));
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

final aragorn = Character(name: 'Aragorn', role: 'Guerreiro', icon: Icons.shield, hp: 100);
final legolas = Character(name: 'Legolas', role: 'Arqueiro', icon: Icons.gps_fixed, hp: 90);
final gandalf = Character(name: 'Gandalf', role: 'Mago', icon: Icons.whatshot, hp: 80);

// ── Tela de Lista (StatefulWidget — guarda os níveis retornados) ─────────────

class FellowshipScreen extends StatefulWidget {
  @override
  State<FellowshipScreen> createState() => _FellowshipScreenState();
}

class _FellowshipScreenState extends State<FellowshipScreen> {
  Map<String, int> niveis = {};

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
          _buildTile(context, aragorn),
          _buildTile(context, legolas),
          _buildTile(context, gandalf),
        ],
      ),
    );
  }
  Widget _buildTile(BuildContext context, Character character) {
    final nivel = niveis[character.name] ?? 1;
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.brown.shade100,
        child: Icon(character.icon, size: 28, color: Colors.deepOrange),
      ),
      title: Text(
        character.name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
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
          'Nível $nivel',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.amber.shade900,
          ),
        ),
      ),
      onTap: () async {
        final result = await Navigator.push<int>(
          context,
          MaterialPageRoute(
            builder: (_) => BattleScreen(character: character),
          ),
        );
        if (result != null) {
          setState(() {
            niveis[character.name] = result;
          });
        }
      },
    );
  }
}

// ── Tela de Batalha (StatefulWidget — estado interno de hp/xp/nível) ─────────

class BattleScreen extends StatefulWidget {
  final Character character;

  BattleScreen({required this.character});

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  late int hp;
  int xp = 0;
  int nivel = 1;
  String log = '';

  @override
  void initState() {
    super.initState();
    hp = widget.character.hp;
  }

  Color get hpColor {
    if (hp > 50) return Colors.green.shade700;
    if (hp > 25) return Colors.orange;
    return Colors.red;
  }

  void _atacar() {
    setState(() {
      hp = (hp - 20).clamp(0, widget.character.hp);
      xp = xp + 15;
      if (xp >= 100) {
        nivel++;
        xp = 0;
        log = '${widget.character.name} subiu para o nível $nivel!';
      } else {
        log = hp == 0
            ? '${widget.character.name} caiu em batalha!'
            : '${widget.character.name} recebeu 20 de dano! (+15 XP)';
      }
    });
  }

  void _curar() {
    setState(() {
      hp = (hp + 30).clamp(0, widget.character.hp);
      log = '${widget.character.name} recuperou 30 HP!';
    });
  }

  void _resetar() {
    setState(() {
      hp = widget.character.hp;
      xp = 0;
      nivel = 1;
      log = 'Batalha reiniciada!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.character.name),
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
                    padding: EdgeInsets.all(20),
                    child: Icon(
                      widget.character.icon,
                      size: 72,
                      color: Colors.deepOrange,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Nome e classe
                  Text(
                    widget.character.name,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(widget.character.icon, size: 20, color: Colors.deepOrange),
                      SizedBox(width: 6),
                      Text(
                        widget.character.role,
                        style: TextStyle(color: Colors.grey.shade900, fontSize: 18),
                      ),
                      SizedBox(width: 14),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Nível $nivel',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),

                  // Barras de status
                  _buildStatBar('HP', hp, widget.character.hp, hpColor),
                  SizedBox(height: 10),
                  _buildStatBar('XP', xp, 100, Colors.blue.shade700),
                  SizedBox(height: 24),

                  // Botões de ação
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(Icons.flash_on),
                        label: Text('Atacar', style: TextStyle(fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade700,
                          foregroundColor: Colors.white,
                          minimumSize: Size(140, 48),
                        ),
                        onPressed: hp > 0 ? _atacar : null,
                      ),
                      SizedBox(width: 16),
                      ElevatedButton.icon(
                        icon: Icon(Icons.favorite),
                        label: Text('Curar', style: TextStyle(fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade700,
                          foregroundColor: Colors.white,
                          minimumSize: Size(140, 48),
                        ),
                        onPressed: hp < widget.character.hp ? _curar : null,
                      ),
                    ],
                  ),

                  // Status condicional
                  if (hp == 0) ...[
                    SizedBox(height: 20),
                    Text(
                      '${widget.character.name} caiu em batalha!',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ] else if (hp <= 30) ...[
                    SizedBox(height: 20),
                    Text(
                      'HP crítico!',
                      style: TextStyle(
                        color: Colors.orange.shade800,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],

                  // Log de ação
                  if (log.isNotEmpty) ...[
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(14),
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
                          fontSize: 16,
                          color: Colors.brown.shade900,
                        ),
                      ),
                    ),
                  ],

                  // Botão de encerrar
                  SizedBox(height: 24),
                  ElevatedButton.icon(
                    icon: Icon(Icons.arrow_back),
                    label: Text('Encerrar batalha', style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown.shade700,
                      foregroundColor: Colors.white,
                      minimumSize: Size(240, 52),
                    ),
                    onPressed: () => Navigator.pop(context, nivel),
                  ),
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
          width: 36,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
          ),
        ),
        SizedBox(width: 10),
        Container(
          width: 220,
          height: 22,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(11),
          ),
          alignment: Alignment.centerLeft,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: (value / max) * 220,
            height: 22,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(11),
            ),
          ),
        ),
        SizedBox(width: 10),
        SizedBox(
          width: 60,
          child: Text(
            '$value/$max',
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
