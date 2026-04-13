import 'package:flutter/material.dart';
import 'character.dart';

class NewCharacterScreen extends StatefulWidget {
  const NewCharacterScreen({super.key});

  @override
  State<NewCharacterScreen> createState() => _NewCharacterScreenState();
}

class _NewCharacterScreenState extends State<NewCharacterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _hpController = TextEditingController();
  final _hpFocusNode = FocusNode();
  String _selectedRole = 'Guerreiro';
  String _previewName = '';

  @override
  void dispose() {
    _nameController.dispose();
    _hpController.dispose();
    _hpFocusNode.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;
    await fellowship.add({
      'name': _nameController.text.trim(),
      'role': _selectedRole,
      'hp': int.parse(_hpController.text.trim()),
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
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_previewName.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    'Recrutando: $_previewName…',
                    style: TextStyle(
                      color: Colors.brown.shade700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              TextFormField(
                controller: _nameController,
                autofocus: true,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nome do personagem',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => setState(() => _previewName = value.trim()),
                onFieldSubmitted: (_) => _hpFocusNode.requestFocus(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'O nome não pode estar vazio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
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
                onChanged: (value) => setState(() => _selectedRole = value!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _hpController,
                focusNode: _hpFocusNode,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'HP inicial',
                  prefixIcon: Icon(Icons.favorite),
                  border: OutlineInputBorder(),
                  helperText: 'Entre 1 e 200',
                ),
                validator: (value) {
                  final hp = int.tryParse(value ?? '');
                  if (hp == null) return 'Digite um número';
                  if (hp < 1 || hp > 200) return 'HP deve ser entre 1 e 200';
                  return null;
                },
              ),
              const SizedBox(height: 32),
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
                onPressed: _salvar,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
