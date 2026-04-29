import 'package:flutter/material.dart';
import 'character.dart'; // ignore: unused_import — necessário após TODO 3

class NewCharacterScreen extends StatefulWidget {
  const NewCharacterScreen({super.key});

  @override
  State<NewCharacterScreen> createState() => _NewCharacterScreenState();
}

class _NewCharacterScreenState extends State<NewCharacterScreen> {
  final _nameController = TextEditingController();
  final _hpController = TextEditingController();

  String _previewName = '';
  final _hpFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  String _selectedRole = 'Guerreiro';

  @override
  void dispose() {
    _nameController.dispose();
    _hpController.dispose();
    _hpFocusNode.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    // TODO 6 (valida): if (!_formKey.currentState!.validate()) return;

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
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nome do personagem',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) => setState(() => _previewName = v.trim()),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => _hpFocusNode.requestFocus(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "O nome não pode ser vazio.";
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
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'HP inicial',
                  prefixIcon: Icon(Icons.favorite),
                  border: OutlineInputBorder(),
                  helperText: 'Entre 1 e 200',
                ),
                validator: (value) {
                  final hpValue = int.tryParse(value ?? '');
                  if (hpValue == null) {
                    return "O HP não pode ser vazio.";
                  }
                  if (hpValue < 1 || hpValue > 200) {
                    return "O HP deve estar entre 1 e 200.";
                  }
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
