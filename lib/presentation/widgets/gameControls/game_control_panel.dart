import 'package:flutter/material.dart';

class GameControlPanel extends StatefulWidget {
  final Function(String towerId) onTowerSelected;
  final String? selectedTowerId;
  final int availableResources;

  const GameControlPanel({
    Key? key,
    required this.onTowerSelected,
    required this.selectedTowerId,
    required this.availableResources,
  }) : super(key: key);

  @override
  State<GameControlPanel> createState() => _GameControlPanelState();
}

class _GameControlPanelState extends State<GameControlPanel> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isExpanded = true;

  final _towerTypes = [
    ('basic', Colors.blue, 100),
    ('cannon', Colors.red, 150),
    ('sniper', Colors.green, 200),
    ('frost', Colors.lightBlue, 175),
    ('poison', Colors.purple, 225),
    ('laser', Colors.amber, 300),
    ('tesla', Colors.cyan, 350),
    ('missile', Colors.deepOrange, 400),
    ('magic', Colors.indigo, 450),
    ('ultimate', Colors.pink, 500),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePanel() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _handleTowerSelection(String towerId, int cost) {
      widget.onTowerSelected(towerId);
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: _isExpanded ? 160 : 40,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            _isExpanded ? Icons.expand_more : null,
                            color: Colors.white,
                          ),
                          onPressed: _togglePanel,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 80,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _towerTypes.map((towerType) {
                            final (type, color, cost) = towerType;
                            return _TowerOption(
                              name: type[0].toUpperCase() + type.substring(1),
                              cost: cost,
                              color: color,
                              onTap: () => _handleTowerSelection(type, cost),
                              isSelected: widget.selectedTowerId == type,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        // Expand Button Always Touchable
        Positioned(
          left: 16,
          bottom: _isExpanded ? 160 : 16, // Verringert den Abstand, um den Overflow zu verhindern
          child: IgnorePointer(
            ignoring: false,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _togglePanel,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: !_isExpanded
                    ? FloatingActionButton.small(
                        key: const ValueKey('expand_button'),
                        onPressed: _togglePanel,
                        backgroundColor: Colors.deepPurple,
                        elevation: 4,
                        child: const Icon(Icons.expand_less, color: Colors.white),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TowerOption extends StatelessWidget {
  final String name;
  final int cost;
  final Color color;
  final VoidCallback onTap;
  final bool isSelected;

  const _TowerOption({
    Key? key,
    required this.name,
    required this.cost,
    required this.color,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.3) : Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.white : color.withOpacity(0.7),
            width: isSelected ? 3 : 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Text(
              '$cost',
              style: const TextStyle(
                color: Colors.amber,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
