import 'dart:ui';

class MapConfig {
  final int width;
  final int height;
  final double tileSize;
  final List<MapPoint> startPoints;
  final List<MapPoint> endPoints;
  final List<List<MapPoint>> paths;
  final List<MapPoint> buildableTiles;
  final Color backgroundColor;
  final Color pathColor;
  final Color borderColor;

  const MapConfig({
    required this.width,
    required this.height,
    required this.tileSize,
    required this.startPoints,
    required this.endPoints,
    required this.paths,
    required this.buildableTiles,
    required this.backgroundColor,
    required this.pathColor,
    required this.borderColor,
  });
}

class MapPoint {
  final int x;
  final int y;

  const MapPoint(this.x, this.y);
}

class MapConfigs {
  static const defaultTileSize = 32.0;
  static const defaultWidth = 20;
  static const defaultHeight = 12;
  
  static const backgroundColor = Color(0xFF34495E);
  static const pathColor = Color(0xFF7F8C8D);
  static const borderColor = Color(0xFF2C3E50);
}