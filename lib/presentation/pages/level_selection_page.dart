import 'package:flutter/material.dart';
import '../../l10n/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:tower_defense_game/core/constants/app_theme.dart';
import 'package:tower_defense_game/domain/repositories/game_repository.dart';
import 'package:tower_defense_game/presentation/routes/app_router.dart';
import 'package:tower_defense_game/presentation/widgets/level_card.dart';

class LevelSelectionPage extends StatefulWidget {
  const LevelSelectionPage({Key? key}) : super(key: key);

  @override
  State<LevelSelectionPage> createState() => _LevelSelectionPageState();
}

class _LevelSelectionPageState extends State<LevelSelectionPage> {
  final gameRepository = GetIt.instance<GameRepository>();
  List<bool> completedLevels = List.filled(15, false);  // Korrigiert auf 15 Level
  int highestUnlockedLevel = 1;  // Startet mit Level 1 freigeschaltet

  @override
  void initState() {
    super.initState();
    _loadLevelStatus();
  }

  Future<void> _loadLevelStatus() async {
    final List<bool> completed = [];
    for (int i = 1; i <= 15; i++) {
      completed.add(await gameRepository.isLevelCompleted(i));
    }
    final highest = await gameRepository.getHighestUnlockedLevel();

    setState(() {
      completedLevels = completed;
      highestUnlockedLevel = highest;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          loc.selectLevelTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 40,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.primaryColor.withOpacity(0.8),
              AppTheme.darkColor.withOpacity(0.9),
            ],
          ),
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                        child: Text(
                          loc.selectLevelCampaign,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(4),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            childAspectRatio: 1.2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: 15,
                          itemBuilder: (context, index) {
                            final levelNumber = index + 1;
                            final isLocked = levelNumber > highestUnlockedLevel;
                            final isCompleted = completedLevels[index];

                            return LevelCard(
                              levelNumber: levelNumber,
                              isLocked: isLocked,
                              isCompleted: isCompleted,
                              onTap: isLocked
                                  ? null
                                  : () {
                                      Navigator.of(context)
                                          .pushNamed(
                                            AppRouter.gameRoute,
                                            arguments: {'levelId': '$levelNumber'},
                                          )
                                          .then((_) => _loadLevelStatus());
                                    },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                        child: Text(
                          loc.selectLevelSpecial,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              AppRouter.gameRoute,
                              arguments: {'levelId': 'endless'},
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFFF6B6B),
                                  Color(0xFFFF8E53),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white24,
                                  ),
                                  child: const Icon(
                                    Icons.all_inclusive,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  loc.selectLevelEndlessTitle,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Text(
                                  loc.selectLevelEndlessSubtitle,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
