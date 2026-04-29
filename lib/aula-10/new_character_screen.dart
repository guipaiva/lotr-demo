import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'character.dart';
import 'character_service.dart';

class NewCharacterScreen extends StatefulWidget {
  const NewCharacterScreen({super.key});

  @override
  State<NewCharacterScreen> createState() => _NewCharacterScreenState();
}

class _NewCharacterScreenState extends State<NewCharacterScreen> {
  final _searchController = TextEditingController();

  Future<List<Character>>? _futureSearch;
  Character? _selected;
  String _selectedRole = 'Guerreiro';
  String? _imageUrl;
  bool _uploading = false;

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
      _imageUrl = null;
    });
  }

  Future<void> _pickAndUpload() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    setState(() => _uploading = true);
    try {
      final bytes = await picked.readAsBytes();
      final ref = FirebaseStorage.instance
          .ref('characters/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await ref.putData(bytes);
      final url = await ref.getDownloadURL();
      setState(() => _imageUrl = url);
    } finally {
      setState(() => _uploading = false);
    }
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
      if (_imageUrl != null) 'imageUrl': _imageUrl,
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
                        child: Text('Erro: ${snapshot.error}',
                            style: const TextStyle(color: Colors.red)),
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
                              child: Text(c.name.isNotEmpty ? c.name[0] : '?',
                                  style: TextStyle(color: Colors.brown.shade800)),
                            ),
                            title: Text(c.name),
                            subtitle: Text(c.race),
                            trailing: isSelected
                                ? Icon(Icons.check_circle, color: Colors.brown.shade700)
                                : null,
                            onTap: () => setState(() {
                              _selected = c;
                              _imageUrl = null;
                            }),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            if (_selected != null) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  if (_imageUrl != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(_imageUrl!,
                          width: 72, height: 72, fit: BoxFit.cover),
                    ),
                  const SizedBox(width: 12),
                  _uploading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : OutlinedButton.icon(
                          icon: const Icon(Icons.photo_camera),
                          label: Text(_imageUrl == null ? 'Adicionar foto' : 'Trocar foto'),
                          onPressed: _pickAndUpload,
                        ),
                ],
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
                label: const Text('Recrutar para a Sociedade',
                    style: TextStyle(fontSize: 16)),
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
