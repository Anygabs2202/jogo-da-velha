import 'dart:math'; // Para utilizar a função aleatória
import 'package:flutter/material.dart';

class JogoDaVelha extends StatefulWidget {
  const JogoDaVelha({super.key});

  @override
  State<JogoDaVelha> createState() => _JogoDaVelhaState();
}

class _JogoDaVelhaState extends State<JogoDaVelha> {
  List<String> board = ['', '', '', '', '', '', '', '', ''];
  String currentPlayer = 'X';
  String winner = '';
  bool isAIGame = true;

  void playMove(int index) {
    if (board[index] == '' && winner == '') {
      setState(() {
        board[index] = currentPlayer;
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      });
      checkWinner();

      if (isAIGame && currentPlayer == 'O' && winner == '') {
        Future.delayed(const Duration(milliseconds: 500), aiMove);
      }
    }
  }

  void checkWinner() {
    List<List<int>> winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (var combo in winningCombinations) {
      if (board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]] && board[combo[0]] != '') {
        setState(() {
          winner = board[combo[0]];
        });
        return;
      }
    }

    if (!board.contains('') && winner == '') {
      setState(() {
        winner = 'Empate';
      });
    }
  }

  void aiMove() {
    if (winner != '') return;

    List<int> emptyCells = [];
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        emptyCells.add(i);
      }
    }

    int move = emptyCells[Random().nextInt(emptyCells.length)];

    setState(() {
      board[move] = 'O';
      currentPlayer = 'X';
    });

    checkWinner();
  }

  void resetGame() {
    setState(() {
      board = ['', '', '', '', '', '', '', '', ''];
      winner = '';
      currentPlayer = 'X';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jogo da Velha'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              winner == ''
                  ? 'Vez do Jogador: $currentPlayer'
                  : winner == 'Empate'
                      ? 'Empate!'
                      : 'Jogador $winner venceu!',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              shrinkWrap: true,
              itemCount: 9,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => playMove(index),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        board[index],
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: resetGame,
              child: const Text('Reiniciar Jogo'),
            ),
          ],
        ),
      ),
    );
  }
}