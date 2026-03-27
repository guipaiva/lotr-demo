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
      // TODO: Add backgroundColor
      //   backgroundColor: Colors.white,
      appBar: AppBar(
        // TODO: Change "Hello" to "Player Card"
        title: Text('Hello'),
        // TODO: Change the AppBar color
        //   Try: Colors.purple, Colors.teal, Colors.indigo
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'Bem-vindo ao Flutter!',
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
      ),
    );
  }
}
