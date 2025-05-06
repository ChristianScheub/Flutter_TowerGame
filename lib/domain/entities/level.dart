import 'package:equatable/equatable.dart';

class Level extends Equatable {
  final String id;
  final String name;
  final String description;
  final int difficulty;
  final bool isEndless;
  final String mapAsset;
  final int? waves;
  final int initialResources;
  final int maxLives;
  
  const Level({
    required this.id,
    required this.name,
    required this.description,
    required this.difficulty,
    required this.isEndless,
    required this.mapAsset,
    this.waves,
    required this.initialResources,
    required this.maxLives,
  });
  
  @override
  List<Object?> get props => [
    id, 
    name, 
    description, 
    difficulty, 
    isEndless, 
    mapAsset, 
    waves, 
    initialResources, 
    maxLives
  ];
  
  Level copyWith({
    String? id,
    String? name,
    String? description,
    int? difficulty,
    bool? isEndless,
    String? mapAsset,
    int? waves,
    int? initialResources,
    int? maxLives,
  }) {
    return Level(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      difficulty: difficulty ?? this.difficulty,
      isEndless: isEndless ?? this.isEndless,
      mapAsset: mapAsset ?? this.mapAsset,
      waves: waves ?? this.waves,
      initialResources: initialResources ?? this.initialResources,
      maxLives: maxLives ?? this.maxLives,
    );
  }
}