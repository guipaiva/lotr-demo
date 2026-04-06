import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FellowshipScreen(),
  ));
}

final _fellowship = FirebaseFirestore.instance.collection('fellowship');

IconData _iconForRole(String role) {
  switch (role) {
    case 'Arqueiro':
      return Icons.gps_fixed;
    case 'Mago':
      return Icons.whatshot;
    default:
      return Icons.shield;
  }
}

// ── Tela de Lista ─────────────────────────────────────────────────────────────

class FellowshipScreen extends StatelessWidget {
  const FellowshipScreen({super.key});

  void _addCharacter(BuildContext context) {
    _fellowship.add({
      'name': 'Boromir',
      'role': 'Guerreiro',
      'hp': 95,
      'level': 1,
    });
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
        stream: _fellowship.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, i) {
              final data = docs[i].data() as Map<String, dynamic>;
              final docId = docs[i].id;
              return _buildTile(context, docId, data);
            },
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

  Widget _buildTile(BuildContext context, String docId, Map<String, dynamic> data) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.brown.shade100,
        child: Icon(_iconForRole(data['role'] ?? ''), size: 28, color: Colors.deepOrange),
      ),
      title: Text(
        data['name'] ?? '',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      subtitle: Text(
        data['role'] ?? '',
        style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
      ),
      trailing: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.amber.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'Nível ${data['level'] ?? 1}',
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
          MaterialPageRoute(
            builder: (_) => BattleScreen(docId: docId, data: data),
          ),
        );
      },
    );
  }
}

// ── Tela de Batalha ───────────────────────────────────────────────────────────

class BattleScreen extends StatefulWidget {
  final String docId;
  final Map<String, dynamic> data;

  const BattleScreen({super.key, required this.docId, required this.data});

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  late int hp;
  late int maxHp;
  int xp = 0;
  late int level;
  String log = '';

  @override
  void initState() {
    super.initState();
    maxHp = widget.data['hp'] ?? 100;
    hp = maxHp;
    level = widget.data['level'] ?? 1;
  }

  Color get hpColor {
    if (hp > 50) return Colors.green.shade700;
    if (hp > 25) return Colors.orange;
    return Colors.red;
  }

  void _atacar() {
    setState(() {
      hp = (hp - 20).clamp(0, maxHp);
      xp += 15;
      if (xp >= 100) {
        level++;
        xp = 0;
        log = '${widget.data['name']} subiu para o nível $level!';
      } else {
        log = hp == 0
            ? '${widget.data['name']} caiu em batalha!'
            : '${widget.data['name']} recebeu 20 de dano! (+15 XP)';
      }
    });
  }

  void _curar() {
    setState(() {
      hp = (hp + 30).clamp(0, maxHp);
      log = '${widget.data['name']} recuperou 30 HP!';
    });
  }

  void _resetar() {
    setState(() {
      hp = maxHp;
      xp = 0;
      level = widget.data['level'] ?? 1;
      log = 'Batalha reiniciada!';
    });
  }

  Future<void> _encerrar() async {
    await _fellowship.doc(widget.docId).update({'level': level});
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.data['name'] ?? '';
    final role = widget.data['role'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.brown.shade800,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: _resetar),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.orange.shade100),
                    padding: EdgeInsets.all(20),
                    child: Icon(_iconForRole(role), size: 72, color: Colors.deepOrange),
                  ),
                  SizedBox(height: 20),
                  Text(name, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(_iconForRole(role), size: 20, color: Colors.deepOrange),
                      SizedBox(width: 6),
                      Text(role, style: TextStyle(fontSize: 18, color: Colors.grey.shade900)),
                      SizedBox(width: 14),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Nível $level',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.amber.shade900),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  _buildStatBar('HP', hp, maxHp, hpColor),
                  SizedBox(height: 10),
                  _buildStatBar('XP', xp, 100, Colors.blue.shade700),
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
                        onPressed: hp < maxHp ? _curar : null,
                      ),
                    ],
                  ),
                  if (hp == 0) ...[
                    SizedBox(height: 20),
                    Text('$name caiu em batalha!',
                        style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold)),
                  ] else if (hp <= 30) ...[
                    SizedBox(height: 20),
                    Text('HP crítico!',
                        style: TextStyle(color: Colors.orange.shade800, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
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
                      child: Text(log,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16, color: Colors.brown.shade900)),
                    ),
                  ],
                  SizedBox(height: 24),
                  ElevatedButton.icon(
                    icon: Icon(Icons.arrow_back),
                    label: Text('Encerrar batalha', style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown.shade700,
                      foregroundColor: Colors.white,
                      minimumSize: Size(240, 52),
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
        SizedBox(width: 36, child: Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
        SizedBox(width: 10),
        Container(
          width: 220,
          height: 22,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(11),
          ),
          alignment: Alignment.centerLeft,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: (value / max) * 220,
            height: 22,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(11)),
          ),
        ),
        SizedBox(width: 10),
        SizedBox(width: 60, child: Text('$value/$max', style: TextStyle(fontSize: 15))),
      ],
    );
  }
}
