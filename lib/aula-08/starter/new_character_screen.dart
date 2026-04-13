import 'package:flutter/material.dart';
import 'character.dart'; // ignore: unused_import — necessário após TODO 3

class NewCharacterScreen extends StatefulWidget {
  const NewCharacterScreen({super.key});

  @override
  State<NewCharacterScreen> createState() => _NewCharacterScreenState();
}

class _NewCharacterScreenState extends State<NewCharacterScreen> {
  // TODO 1: Declare os controllers — um para nome, outro para HP — e chame .dispose() em cada um
  //   final _nameController = TextEditingController();
  //   final _hpController = TextEditingController();

  // TODO 4: Declare a variável de preview e o FocusNode do campo HP
  //   String _previewName = '';
  //   final _hpFocusNode = FocusNode();

  // TODO 6: Declare a chave do formulário
  //   final _formKey = GlobalKey<FormState>();

  String _selectedRole = 'Guerreiro';

  @override
  void dispose() {
    // TODO 1 (dispose): _nameController.dispose(); _hpController.dispose();
    // TODO 4 (dispose): _hpFocusNode.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    // TODO 6 (valida): if (!_formKey.currentState!.validate()) return;

    // TODO 3: Substitua por fellowship.add({...}) com os valores dos controllers
    //   await fellowship.add({
    //     'name': _nameController.text.trim(),
    //     'role': _selectedRole,
    //     'hp': int.parse(_hpController.text.trim()),
    //     'level': 1,
    //   });

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
        // TODO 6 (form): Envolva a Column em um Form
        //   Form(
        //     key: _formKey,
        //     autovalidateMode: AutovalidateMode.onUserInteraction,
        //     child: Column(...),
        //   )
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // TODO 4 (preview): Mostre o nome em tempo real se _previewName não estiver vazio
            //   if (_previewName.isNotEmpty)
            //     Padding(
            //       padding: const EdgeInsets.only(bottom: 16),
            //       child: Text(
            //         'Recrutando: $_previewName…',
            //         style: TextStyle(color: Colors.brown.shade700, fontStyle: FontStyle.italic),
            //       ),
            //     ),

            // TODO 7: Substitua por TextFormField com validator (nome não pode ser vazio)
            TextField(
              // TODO 2: controller: _nameController,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Nome do personagem',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              // TODO 4 (onChanged): onChanged: (v) => setState(() => _previewName = v.trim()),
              // TODO 5: textInputAction: TextInputAction.next,
              //         onSubmitted: (_) => _hpFocusNode.requestFocus(),
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
            // TODO 7 (HP): Substitua por TextFormField com validator (número entre 1 e 200)
            TextField(
              // TODO 2: controller: _hpController,
              // TODO 5: focusNode: _hpFocusNode,
              //         textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'HP inicial',
                prefixIcon: Icon(Icons.favorite),
                border: OutlineInputBorder(),
                helperText: 'Entre 1 e 200',
              ),
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
    );
  }
}
