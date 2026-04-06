import 'package:flutter/material.dart';
import 'fellowship_screen.dart';

// TODO 1: Importe firebase_core e firebase_options.dart
// TODO 2: Torne o main() assíncrono (async)
// TODO 3: Chame WidgetsFlutterBinding.ensureInitialized()
// TODO 4: Inicialize o Firebase com Firebase.initializeApp(...)

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FellowshipScreen(),
  ));
}
