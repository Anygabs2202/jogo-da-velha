import 'package:flutter/material.dart';
import 'package:myapp/componentes/jogo_da_velha.dart';
import 'jogo_da_velha.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo da Velha',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      debugShowCheckedModeBanner: false,  // Remover o banner de depuração
      home: const JogoDaVelha(),
    );
  }
}