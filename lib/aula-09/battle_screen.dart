import 'package:flutter/material.dart';
import 'character.dart';

class BattleScreen extends StatefulWidget {
  final Character character;

  const BattleScreen({super.key, required this.character});

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  late int hp;
  int xp = 0;
  late int level;
  String log = '';

  @override
  void initState() {
    super.initState();
    hp = widget.character.hp;
    level = widget.character.level;
  }

  Color get hpColor {
    if (hp > 50) return Colors.green.shade700;
    if (hp > 25) return Colors.orange;
    return Colors.red;
  }

  void _atacar() {
    setState(() {
      hp = (hp - 20).clamp(0, widget.character.hp);
      xp += 15;
      if (xp >= 100) {
        level++;
        xp = 0;
        log = '${widget.character.name} subiu para o nível $level!';
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
      level = widget.character.level;
      log = 'Batalha reiniciada!';
    });
  }

  Future<void> _encerrar() async {
    await fellowship.doc(widget.character.id).update({'level': level});
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.character.name),
        backgroundColor: Colors.brown.shade800,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _resetar),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange.shade100,
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Icon(
                      widget.character.icon,
                      size: 72,
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.character.name,
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(widget.character.icon,
                          size: 20, color: Colors.deepOrange),
                      const SizedBox(width: 6),
                      Text(widget.character.role,
                          style: TextStyle(
                              fontSize: 18, color: Colors.grey.shade900)),
                      const SizedBox(width: 14),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Nível $level',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildStatBar('HP', hp, widget.character.hp, hpColor),
                  const SizedBox(height: 10),
                  _buildStatBar('XP', xp, 100, Colors.blue.shade700),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.flash_on),
                        label: const Text('Atacar',
                            style: TextStyle(fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade700,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(140, 48),
                        ),
                        onPressed: hp > 0 ? _atacar : null,
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.favorite),
                        label: const Text('Curar',
                            style: TextStyle(fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade700,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(140, 48),
                        ),
                        onPressed:
                            hp < widget.character.hp ? _curar : null,
                      ),
                    ],
                  ),
                  if (hp == 0) ...[
                    const SizedBox(height: 20),
                    Text(
                      '${widget.character.name} caiu em batalha!',
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ] else if (hp <= 30) ...[
                    const SizedBox(height: 20),
                    Text(
                      'HP crítico!',
                      style: TextStyle(
                          color: Colors.orange.shade800,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                  if (log.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
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
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Encerrar batalha',
                        style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown.shade700,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(240, 52),
                    ),
                    onPressed: _encerrar,
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
          child: Text(label,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        const SizedBox(width: 10),
        Container(
          width: 220,
          height: 22,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(11),
          ),
          alignment: Alignment.centerLeft,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: (value / max) * 220,
            height: 22,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(11),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 60,
          child: Text('$value/$max', style: const TextStyle(fontSize: 15)),
        ),
      ],
    );
  }
}
