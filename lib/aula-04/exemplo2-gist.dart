import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CharacterScreen(),
  ));
}

class CharacterScreen extends StatelessWidget {
  const CharacterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Player Card'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      // TODO: Replace the Center below with a Column containing:
      //   1. A Text with the character name
      //        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)
      //   2. SizedBox(height: 8)
      //   3. A Row (mainAxisAlignment: MainAxisAlignment.center) with a class icon + class name:
      //        Icon(Icons.shield, color: Colors.deepOrange, size: 18)
      //        SizedBox(width: 6)
      //        Text('Guerreiro', style: TextStyle(color: Colors.grey.shade900, fontSize: 16))
      //
      // Hint: use mainAxisAlignment: MainAxisAlignment.center on the Column
      body: Center(
        child: Text(
          'Bem-vindo ao Player Card!',
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
      ),
    );
  }
}
