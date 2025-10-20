import 'dart:ui';

import 'package:flutter/material.dart';

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  State<TicTacToeGame> createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<String> board = List.filled(9, '');
  bool isXTurn = true;
  String winner = '';
  List<int> winningLine = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('إكس أو'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _resetGame),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:
                isDark
                    ? [const Color(0xFF000014), const Color(0xFF271C2E)]
                    : [const Color(0xFFFAFAFA), const Color(0xFFF5F5F5)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Score Display
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _PlayerIndicator(
                      symbol: 'X',
                      color: const Color(0xFF8b3db3),
                      isActive: isXTurn && winner.isEmpty,
                    ),
                    Text(
                      winner.isEmpty
                          ? 'الدور الحالي'
                          : winner == 'Draw'
                          ? 'تعادل!'
                          : 'الفائز!',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _PlayerIndicator(
                      symbol: 'O',
                      color: const Color(0xFFd084ff),
                      isActive: !isXTurn && winner.isEmpty,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Game Board
              Container(
                margin: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      final isWinningCell = winningLine.contains(index);
                      return _GameCell(
                        value: board[index],
                        onTap: winner.isEmpty ? () => _makeMove(index) : null,
                        isWinning: isWinningCell,
                      );
                    },
                  ),
                ),
              ),
              const Spacer(),
              // Reset Button
              if (winner.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton.icon(
                    onPressed: _resetGame,
                    icon: const Icon(Icons.refresh),
                    label: const Text('لعبة جديدة'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _makeMove(int index) {
    if (board[index].isEmpty && winner.isEmpty) {
      setState(() {
        board[index] = isXTurn ? 'X' : 'O';
        isXTurn = !isXTurn;
        _checkWinner();
      });
    }
  }

  void _checkWinner() {
    const winPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6], // Diagonals
    ];

    for (var pattern in winPatterns) {
      final a = board[pattern[0]];
      final b = board[pattern[1]];
      final c = board[pattern[2]];

      if (a.isNotEmpty && a == b && b == c) {
        setState(() {
          winner = a;
          winningLine = pattern;
        });
        return;
      }
    }

    if (board.every((cell) => cell.isNotEmpty)) {
      setState(() {
        winner = 'Draw';
      });
    }
  }

  void _resetGame() {
    setState(() {
      board = List.filled(9, '');
      isXTurn = true;
      winner = '';
      winningLine = [];
    });
  }
}

class _PlayerIndicator extends StatelessWidget {
  final String symbol;
  final Color color;
  final bool isActive;

  const _PlayerIndicator({
    required this.symbol,
    required this.color,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isActive ? color.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive ? color : Colors.transparent,
          width: 2,
        ),
      ),
      child: Text(
        symbol,
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: isActive ? color : Colors.grey,
        ),
      ),
    );
  }
}

class _GameCell extends StatelessWidget {
  final String value;
  final VoidCallback? onTap;
  final bool isWinning;

  const _GameCell({required this.value, this.onTap, this.isWinning = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color:
                isWinning
                    ? const Color(0xFF8b3db3).withOpacity(0.3)
                    : isDark
                    ? const Color(0xFF271C2E)
                    : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color:
                  isWinning
                      ? const Color(0xFF8b3db3)
                      : isDark
                      ? const Color(0xFF3d124f).withOpacity(0.3)
                      : const Color(0xFF0d0316).withOpacity(0.1),
              width: 2,
            ),
            boxShadow: [
              if (isWinning)
                BoxShadow(
                  color: const Color(0xFF8b3db3).withOpacity(0.5),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
            ],
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color:
                    value == 'X'
                        ? const Color(0xFF8b3db3)
                        : const Color(0xFFd084ff),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
