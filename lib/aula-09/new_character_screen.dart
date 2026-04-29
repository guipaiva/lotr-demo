import 'package:flutter/material.dart';
import 'character.dart';
import 'character_service.dart';

class NewCharacterScreen extends StatefulWidget {
  const NewCharacterScreen({super.key});

  @override
  State<NewCharacterScreen> createState() => _NewCharacterScreenState();
}

class _NewCharacterScreenState extends State<NewCharacterScreen> {
  final _searchController = TextEditingController();

  Future<List<Character>>? _futureSearch; // null = nenhuma busca ainda
  Character? _selected;
  String _selectedRole = 'Guerreiro';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _buscar() {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;
    setState(() {
      _futureSearch = searchCharacters(query);
      _selected = null;
    });
  }

  Future<void> _recrutar() async {
    final character = _selected;
    if (character == null) return;
    await fellowship.add({
      'name': character.name,
      'race': character.race,
      'role': _selectedRole,
      'hp': 100,
      'level': 1,
    });
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recrutar para a Sociedade'),
        backgroundColor: Colors.brown.shade800,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Buscar personagem',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _buscar(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _buscar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown.shade700,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(80, 56),
                  ),
                  child: const Text('Buscar'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_futureSearch != null)
              Expanded(
                child: FutureBuilder<List<Character>>(
                  future: _futureSearch,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Erro: ${snapshot.error}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final results = snapshot.data!;
                    if (results.isEmpty) {
                      return const Center(child: Text('Nenhum personagem encontrado.'));
                    }
                    return ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (context, i) {
                        final c = results[i];
                        final isSelected = _selected?.id == c.id;
                        return Card(
                          color: isSelected ? Colors.brown.shade50 : null,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.brown.shade100,
                              child: Text(
                                c.name.isNotEmpty ? c.name[0] : '?',
                                style: TextStyle(color: Colors.brown.shade800),
                              ),
                            ),
                            title: Text(c.name),
                            subtitle: Text(c.race),
                            trailing: isSelected
                                ? Icon(Icons.check_circle, color: Colors.brown.shade700)
                                : null,
                            onTap: () => setState(() => _selected = c),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            if (_selected != null) ...[
              const SizedBox(height: 12),
              Text(
                'Selecionado: ${_selected!.name} (${_selected!.race})',
                style: TextStyle(
                  color: Colors.brown.shade700,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _selectedRole,
                decoration: const InputDecoration(
                  labelText: 'Classe',
                  prefixIcon: Icon(Icons.shield),
                  border: OutlineInputBorder(),
                ),
                items: ['Guerreiro', 'Arqueiro', 'Mago']
                    .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedRole = v!),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                icon: const Icon(Icons.how_to_reg),
                label: const Text(
                  'Recrutar para a Sociedade',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown.shade700,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 52),
                ),
                onPressed: _recrutar,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
