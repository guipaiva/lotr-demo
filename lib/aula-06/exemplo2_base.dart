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
  int level;

  Character({
    required this.name,
    required this.role,
    required this.icon,
    required this.hp,
    this.level = 1,
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

class FellowshipScreen extends StatefulWidget {
  const FellowshipScreen({super.key});

  @override
  State<FellowshipScreen> createState() => _FellowshipScreenState();
}

class _FellowshipScreenState extends State<FellowshipScreen> {
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
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.brown.shade100,
        child: Icon(character.icon, size: 28, color: Colors.deepOrange),
      ),
      title: Text(
        character.name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.black,
        ),
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
      onTap: () async {
        final result = await Navigator.push<int>(
          context,
          MaterialPageRoute(builder: (_) => BattleScreen(character: character)),
        );
        if (result != null) {
          setState(() {
            character.level = result;
          });
        }
      },
    );
  }
}

class BattleScreen extends StatefulWidget {
  final Character character;

  const BattleScreen({super.key, required this.character});

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  late int hp;
  int xp = 0;
  int level = 1;

  @override
  void initState() {
    super.initState();
    hp = widget.character.hp;
  }

  void _atacar() {
    setState(() {
      hp = (hp - 20).clamp(0, widget.character.hp);
      xp = xp + 15;
      if (xp >= 100) {
        level++;
        xp = 0;
      }
    });
  }

  void _curar() {
    setState(() {
      hp = (hp + 30).clamp(0, widget.character.hp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.character.name),
        backgroundColor: Colors.brown.shade800,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(widget.character.icon, size: 80, color: Colors.deepOrange),
            SizedBox(height: 16),
            Text(
              widget.character.name,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              widget.character.role,
              style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
            ),
            SizedBox(height: 8),
            Text(
              'HP: $hp/${widget.character.hp}  |  XP: $xp/100  |  Nível $level',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 24),
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
            SizedBox(height: 24),
            ElevatedButton.icon(
              icon: Icon(Icons.arrow_back),
              label: Text('Encerrar batalha', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown.shade700,
                foregroundColor: Colors.white,
                minimumSize: Size(240, 52),
              ),
              onPressed: () => Navigator.pop(context, level),
            ),
          ],
        ),
      ),
    );
  }
}
