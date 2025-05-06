# Tower Defense Game

A fully documented and modular Tower Defense game built with Flutter and the Flame engine for web.

## Project Overview

This Tower Defense game implements a clean architecture pattern with clear separation between different layers:

1. **Core Layer**: Basic game mechanics and logic
2. **Data Layer**: Data models and sources
3. **Domain Layer**: Business logic and use cases
4. **Presentation Layer**: User interface and interaction

The game features 5 progressive levels with increasing difficulty and an endless mode with unlimited tower types. There are 10 unique tower types with individual properties in the standard levels, and unlimited tower types in the endless mode, each becoming progressively more powerful and expensive.

## Architecture

### Clean Architecture

The project follows Clean Architecture principles with clear separation of concerns:

```
lib/
├── core/         # Core game mechanics and shared utilities
├── data/         # Data models and sources
├── domain/       # Business logic and use cases
└── presentation/ # UI components and screens
```

### State Management

The application uses the BLoC (Business Logic Component) pattern for state management, providing a clean separation between UI and business logic.

## Game Features

- 5 progressive levels with increasing difficulty
- Endless mode with unlimited tower upgrades
- 10 unique tower types with upgrade capabilities
- 10 different enemy types with varying abilities
- Realistic projectile animations
- Visual tower range indicators
- In-game economy for purchasing and upgrading towers

## UML Diagrams

### Game Architecture
```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  Presentation   │     │     Domain      │     │      Data       │
│     Layer       │◄────┤     Layer       │◄────┤     Layer       │
└─────────────────┘     └─────────────────┘     └─────────────────┘
         ▲                      ▲                       ▲
         │                      │                       │
         └──────────────────────┼───────────────────────┘
                               │
                      ┌─────────────────┐
                      │      Core       │
                      │     Layer       │
                      └─────────────────┘
```

### Game Flow
```
┌──────────┐     ┌──────────┐     ┌──────────┐     ┌──────────┐
│  Start   │────►│ Select   │────►│  Play    │────►│ Game     │
│  Game    │     │  Level   │     │  Level   │     │ Over     │
└──────────┘     └──────────┘     └──────────┘     └──────────┘
                                      │  ▲
                                      │  │
                                      ▼  │
                                  ┌──────────┐
                                  │ Pause    │
                                  │ Game     │
                                  └──────────┘
```

### Tower-Enemy Interaction
```
┌──────────┐     ┌──────────┐     ┌──────────┐
│  Tower   │────►│ Detect   │────►│ Fire     │
│          │     │ Enemy    │     │ Projectile│
└──────────┘     └──────────┘     └──────────┘
                                      │
                                      ▼
┌──────────┐     ┌──────────┐     ┌──────────┐
│  Enemy   │◄────┤ Apply    │◄────┤ Hit      │
│  Damaged │     │ Effects  │     │ Detection│
└──────────┘     └──────────┘     └──────────┘
```

## Getting Started

1. Ensure you have Flutter installed and set up for web development
2. Clone the repository
3. Run `flutter pub get` to install dependencies
4. Run `flutter run -d chrome` to start the game in a browser

## Legal

The game includes:
- An imprint with sample data
- A comprehensive privacy policy compliant with GDPR and CCPA

All game data is stored locally without any backend services.

____
```mermaid
sequenceDiagram
    participant MainMenuPage.dart
    participant LevelSelectionPage.dart
    participant GamePage.dart
    participant TowerDefenseGame.dart
    participant GameMap.dart
    participant Tower.dart
    participant Enemy.dart
    participant Projectile.dart
    participant GameRepository.dart
    participant LocalStorage.dart
    participant VictoryEffect.dart
    participant GameOverEffect.dart

    MainMenuPage.dart->>LevelSelectionPage.dart: Navigator.pushNamed('/levels')
    LevelSelectionPage.dart->>GameRepository.dart: getHighestUnlockedLevel()
    GameRepository.dart->>LocalStorage.dart: getInt('highest_unlocked_level')
    LocalStorage.dart-->>GameRepository.dart: Return level number
    
    LevelSelectionPage.dart->>GameRepository.dart: isLevelCompleted(levelId)
    GameRepository.dart->>LocalStorage.dart: getBool('level_${levelId}_completed')
    LocalStorage.dart-->>GameRepository.dart: Return completion status
    
    LevelSelectionPage.dart->>GamePage.dart: Navigator.pushNamed('/game', levelId)
    GamePage.dart->>TowerDefenseGame.dart: Create(level)
    TowerDefenseGame.dart->>GameMap.dart: Create(level)
    GameMap.dart->>GameMap.dart: onLoad()
    GameMap.dart->>GameMap.dart: _loadMapData()
    GameMap.dart->>GameMap.dart: _drawTerrain()
    GameMap.dart->>GameMap.dart: _drawPaths()
    GameMap.dart->>GameMap.dart: _drawGrid()
    
    loop Game Loop
        TowerDefenseGame.dart->>TowerDefenseGame.dart: update(dt)
        
        alt Wave Timer > 0
            TowerDefenseGame.dart->>TowerDefenseGame.dart: waveTimer -= dt
        else Enemies to Spawn
            TowerDefenseGame.dart->>Enemy.dart: create(type, position, path)
            Enemy.dart->>Enemy.dart: onLoad()
            Enemy.dart-->>TowerDefenseGame.dart: Enemy added
        end
        
        alt Tower Placement
            GamePage.dart->>TowerDefenseGame.dart: selectTower(towerId)
            GamePage.dart->>TowerDefenseGame.dart: onTapDown(position)
            TowerDefenseGame.dart->>GameMap.dart: canBuildAt(position)
            GameMap.dart-->>TowerDefenseGame.dart: Return buildable
            TowerDefenseGame.dart->>Tower.dart: create(type, position)
            Tower.dart->>Tower.dart: onLoad()
            Tower.dart-->>TowerDefenseGame.dart: Tower added
        end
        
        loop Combat System
            Tower.dart->>Tower.dart: findTarget(enemies)
            Tower.dart->>Tower.dart: _isInRange(enemy)
            Tower.dart->>Projectile.dart: _fireAt(target)
            Projectile.dart->>Projectile.dart: onLoad()
            Projectile.dart->>Projectile.dart: update(dt)
            Projectile.dart->>Enemy.dart: checkHit(enemies)
            
            alt Enemy Hit
                Enemy.dart->>Enemy.dart: takeDamage(amount)
                alt Enemy Defeated
                    Enemy.dart-->>TowerDefenseGame.dart: Remove enemy
                    TowerDefenseGame.dart->>TowerDefenseGame.dart: resources += reward
                end
            end
            
            alt Enemy Reaches End
                Enemy.dart-->>TowerDefenseGame.dart: reachedEnd = true
                TowerDefenseGame.dart->>TowerDefenseGame.dart: lives -= damage
                alt Game Over
                    TowerDefenseGame.dart->>GameOverEffect.dart: Create()
                    GameOverEffect.dart->>GameOverEffect.dart: onLoad()
                    TowerDefenseGame.dart->>GamePage.dart: Show game over overlay
                end
            end
        end
        
        alt Level Complete
            TowerDefenseGame.dart->>VictoryEffect.dart: Create()
            VictoryEffect.dart->>VictoryEffect.dart: onLoad()
            TowerDefenseGame.dart->>GameRepository.dart: saveGameProgress(levelId, score, stars)
            GameRepository.dart->>LocalStorage.dart: saveBool('level_${levelId}_completed', true)
            GameRepository.dart->>LocalStorage.dart: saveInt('level_${levelId}_score', score)
            TowerDefenseGame.dart->>GamePage.dart: Show victory overlay
        end
    end
```



____
# Tower Defense Game

A fully documented and modular Tower Defense game built with Flutter and the Flame engine for web.

## Technical Architecture

### Core Architecture

The game implements a clean architecture pattern with four distinct layers:

1. **Core Layer**
   - Handles fundamental utilities and services
   - Manages dependency injection via GetIt
   - Provides local storage abstraction
   - Contains app-wide constants and themes

2. **Data Layer**
   - Implements repository interfaces
   - Handles data persistence and validation
   - Manages game state storage
   - Provides concrete data source implementations

3. **Domain Layer**
   - Defines business entities and rules
   - Contains repository interfaces
   - Implements core game logic
   - Manages game state transitions

4. **Presentation Layer**
   - Handles UI rendering and user input
   - Manages game rendering via Flame engine
   - Implements game components and effects
   - Provides screen navigation and menus

### Component Architecture

The game uses a component-based architecture for game objects:

```mermaid
classDiagram
    class Component {
        +position: Vector2
        +size: Vector2
        +update(dt: double)
        +render(canvas: Canvas)
    }
    class Tower {
        +type: String
        +level: int
        +range: double
        +damage: double
        +fireRate: double
        +findTarget()
        +upgrade()
    }
    class Enemy {
        +type: String
        +health: double
        +speed: double
        +path: List~Vector2~
        +takeDamage(amount: double)
        +move()
    }
    class Projectile {
        +type: String
        +damage: double
        +target: Enemy
        +move()
        +checkHit()
    }
    Component <|-- Tower
    Component <|-- Enemy
    Component <|-- Projectile
```

### Game Flow Architecture

```mermaid
stateDiagram-v2
    [*] --> MainMenu
    MainMenu --> LevelSelection
    LevelSelection --> GameInitialization
    GameInitialization --> WavePreparation
    WavePreparation --> WaveInProgress
    WaveInProgress --> WaveComplete
    WaveComplete --> WavePreparation: More waves
    WaveComplete --> Victory: All waves complete
    WaveInProgress --> GameOver: Lives = 0
    Victory --> LevelSelection
    GameOver --> LevelSelection
```

### Tower Interaction System

```mermaid
sequenceDiagram
    participant Player
    participant Tower
    participant Enemy
    participant Projectile
    
    Player->>Tower: Place Tower
    loop Every Frame
        Tower->>Enemy: Detect Enemies
        alt Enemy in Range
            Tower->>Projectile: Create Projectile
            Projectile->>Enemy: Move to Target
            Projectile->>Enemy: Apply Damage
            alt Enemy Health <= 0
                Enemy->>Player: Give Resources
            end
        end
    end
```

### Repository Pattern Implementation

```mermaid
classDiagram
    class GameRepository {
        <<interface>>
        +saveGameProgress()
        +getHighScore()
        +getTotalStars()
        +isLevelCompleted()
    }
    class LevelRepository {
        <<interface>>
        +getAllLevels()
        +getLevelById()
        +getLevelWaves()
        +getLevelMap()
    }
    class GameRepositoryImpl {
        -localStorage: LocalStorage
        +saveGameProgress()
        +getHighScore()
    }
    class LevelRepositoryImpl {
        -levels: List~Level~
        +getAllLevels()
        +getLevelById()
    }
    
    GameRepository <|.. GameRepositoryImpl
    LevelRepository <|.. LevelRepositoryImpl
```

### Enemy Behavior System

```mermaid
stateDiagram-v2
    [*] --> Spawned
    Spawned --> Moving
    Moving --> TakingDamage
    TakingDamage --> Moving
    Moving --> ReachedEnd
    TakingDamage --> Defeated
    Defeated --> [*]
    ReachedEnd --> [*]
```

### Tower Upgrade System

```mermaid
classDiagram
    class Tower {
        +level: int
        +damage: double
        +range: double
        +fireRate: double
        +upgrade()
    }
    class UpgradeSystem {
        +calculateCost()
        +applyUpgrade()
        +validateResources()
    }
    class TowerStats {
        +baseDamage: double
        +baseRange: double
        +baseFireRate: double
        +calculateUpgradedStats()
    }
    
    Tower --> UpgradeSystem
    Tower --> TowerStats
```

### Wave Management System

```mermaid
stateDiagram-v2
    [*] --> WavePreparation
    WavePreparation --> SpawningEnemies
    SpawningEnemies --> WaveInProgress
    WaveInProgress --> AllEnemiesDefeated
    AllEnemiesDefeated --> WaveComplete
    WaveComplete --> [*]
```

### Resource Management System

```mermaid
classDiagram
    class ResourceManager {
        +currentResources: int
        +addResources()
        +spendResources()
        +canAfford()
    }
    class TowerCosts {
        +basicCost: int
        +sniperCost: int
        +calculateUpgradeCost()
    }
    class RewardSystem {
        +calculateEnemyReward()
        +calculateWaveBonus()
    }
    
    ResourceManager --> TowerCosts
    ResourceManager --> RewardSystem
```

### UI Component Hierarchy

```mermaid
classDiagram
    class GameWidget {
        +game: TowerDefenseGame
        +build()
    }
    class GameHUD {
        +lives: int
        +resources: int
        +wave: int
        +build()
    }
    class TowerPanel {
        +selectedTower: String
        +onTowerSelected()
        +build()
    }
    class GameMap {
        +tiles: List~Tile~
        +render()
    }
    
    GameWidget --> GameHUD
    GameWidget --> TowerPanel
    GameWidget --> GameMap
```

### Effect System Architecture

```mermaid
classDiagram
    class Effect {
        +duration: double
        +intensity: double
        +apply()
        +update()
    }
    class FrostEffect {
        +slowAmount: double
        +apply()
    }
    class PoisonEffect {
        +damagePerSecond: double
        +apply()
    }
    class BurningEffect {
        +burnDamage: double
        +apply()
    }
    
    Effect <|-- FrostEffect
    Effect <|-- PoisonEffect
    Effect <|-- BurningEffect
```

### Audio System Design

```mermaid
classDiagram
    class AudioManager {
        +playSound()
        +playMusic()
        +stopMusic()
        +setVolume()
    }
    class SoundEffect {
        +name: String
        +file: String
        +volume: double
        +play()
    }
    class BackgroundMusic {
        +track: String
        +volume: double
        +loop: bool
        +play()
    }
    
    AudioManager --> SoundEffect
    AudioManager --> BackgroundMusic
```

### Save System Architecture

```mermaid
classDiagram
    class SaveManager {
        +saveGame()
        +loadGame()
        +deleteSave()
    }
    class GameProgress {
        +completedLevels: List
        +highScores: Map
        +totalStars: int
    }
    class PlayerStats {
        +resources: int
        +unlockedTowers: List
        +achievements: List
    }
    
    SaveManager --> GameProgress
    SaveManager --> PlayerStats
```

### Level Generation System

```mermaid
classDiagram
    class LevelGenerator {
        +generateLevel()
        +createPaths()
        +placeBuildingSpots()
    }
    class PathGenerator {
        +generatePath()
        +validatePath()
        +optimizePath()
    }
    class WaveGenerator {
        +generateWave()
        +calculateDifficulty()
        +selectEnemyTypes()
    }
    
    LevelGenerator --> PathGenerator
    LevelGenerator --> WaveGenerator
```

### Particle System Architecture

```mermaid
classDiagram
    class ParticleSystem {
        +particles: List
        +emit()
        +update()
    }
    class Particle {
        +position: Vector2
        +velocity: Vector2
        +lifetime: double
        +update()
    }
    class ParticleEmitter {
        +rate: double
        +direction: Vector2
        +emit()
    }
    
    ParticleSystem --> Particle
    ParticleSystem --> ParticleEmitter
```

## Technical Implementation Details

### State Management
- Uses GetIt for dependency injection
- Implements repository pattern for data access
- Uses BLoC pattern for UI state management
- Maintains clean separation of concerns

### Game Engine Integration
- Built on Flame game engine
- Uses component-based architecture
- Implements efficient collision detection
- Manages game loop and timing

### Performance Optimizations
- Implements object pooling for projectiles
- Uses quadtree for spatial partitioning
- Optimizes render cycles
- Implements efficient path finding

### Data Persistence
- Uses SharedPreferences for local storage
- Implements repository pattern
- Handles data validation and migration
- Provides async data access

## Architecture Decisions

1. **Clean Architecture**
   - Separates concerns into distinct layers
   - Makes the codebase maintainable and testable
   - Allows for easy feature additions
   - Facilitates testing and debugging

2. **Component-Based Design**
   - Promotes code reuse
   - Simplifies entity management
   - Enables easy feature extension
   - Improves maintainability

3. **Repository Pattern**
   - Abstracts data access
   - Enables easy testing
   - Provides clean data access API
   - Facilitates future backend integration

4. **Dependency Injection**
   - Reduces coupling
   - Improves testability
   - Simplifies dependency management
   - Enables feature toggling

## Performance Considerations

1. **Rendering Optimization**
   - Uses sprite batching
   - Implements view culling
   - Optimizes particle systems
   - Manages texture atlases

2. **Memory Management**
   - Implements object pooling
   - Manages asset loading
   - Controls particle system limits
   - Optimizes texture usage

3. **State Management**
   - Efficient state updates
   - Minimizes rebuilds
   - Optimizes data flow
   - Implements caching

## Future Enhancements

1. **Technical Improvements**
   - Add multiplayer support
   - Implement cloud saves
   - Add advanced pathfinding
   - Enhance particle systems

2. **Architecture Enhancements**
   - Add event system
   - Implement command pattern
   - Add replay system
   - Enhance save system

3. **Performance Optimizations**
   - Implement GPU acceleration
   - Add level streaming
   - Optimize memory usage
   - Enhance rendering pipeline