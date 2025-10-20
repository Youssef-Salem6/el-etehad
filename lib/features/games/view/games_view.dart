import 'package:el_etehad/features/games/view/games/tic_tac_toe_game.dart';
import 'package:el_etehad/features/games/view/widgets/game_card.dart';
import 'package:flutter/material.dart';

class GamesView extends StatefulWidget {
  const GamesView({super.key});

  @override
  State<GamesView> createState() => _GamesViewState();
}

class _GamesViewState extends State<GamesView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header Section
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors:
                      isDark
                          ? [const Color(0xFF271C2E), const Color(0xFF000014)]
                          : [const Color(0xFF0d0316), const Color(0xFF0f0319)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    '🎮 الألعاب',
                    style: theme.textTheme.displaySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'استمتع بمجموعة من الألعاب الممتعة',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Games Grid
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildListDelegate([
                GameCard(
                  title: 'إكس أو',
                  subtitle: 'Tic Tac Toe',
                  icon: "assets/images/icons/strategic-plan.png",
                  gradient: const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color.fromARGB(255, 66, 49, 77),
                      Color.fromARGB(255, 40, 21, 52),
                    ],
                  ),
                  gameView: TicTacToeGame(),
                ),
                GameCard(
                  title: 'الذاكرة',
                  subtitle: 'Memory Game',
                  icon: "assets/images/icons/card-games.png",
                  gradient: const LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      Color.fromARGB(255, 66, 49, 77),
                      Color.fromARGB(255, 40, 21, 52),
                    ],
                  ),
                  gameView: TicTacToeGame(),
                ),
                GameCard(
                  title: 'تخمين الرقم',
                  subtitle: 'Number Guess',
                  icon: "assets/images/icons/gambling-chips.png",
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 66, 49, 77),
                      Color.fromARGB(255, 40, 21, 52),
                    ],
                  ),
                  gameView: TicTacToeGame(),
                  // onTap: () => _showComingSoon(context, 'تخمين الرقم'),
                ),
                // _GameCard(
                //   title: 'لعبة السرعة',
                //   subtitle: 'Speed Game',
                //   icon: Icons.speed,
                //   gradient: const LinearGradient(
                //     begin: Alignment.topRight,
                //     end: Alignment.bottomLeft,
                //     colors: [
                //       Color.fromARGB(255, 66, 49, 77),
                //       Color.fromARGB(255, 40, 21, 52),
                //     ],
                //   ),
                //   onTap: () => _showComingSoon(context, 'لعبة السرعة'),
                // ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
