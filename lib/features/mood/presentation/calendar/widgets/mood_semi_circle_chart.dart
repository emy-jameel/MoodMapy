// ويدجت الأنيميشن
import 'package:flutter/material.dart';
import 'package:mood_map/core/widgets/mood_semi_circle_painter.dart';

class MoodSemiCircleChart extends StatefulWidget {
  final List<Color> colors;
  final List<double> values;
  final int total;

  const MoodSemiCircleChart({super.key, required this.colors, required this.values, required this.total});

  @override
  State<MoodSemiCircleChart> createState() => _MoodSemiCircleChartState();
}

class _MoodSemiCircleChartState extends State<MoodSemiCircleChart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progress;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _progress = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant MoodSemiCircleChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.values != oldWidget.values || widget.colors != oldWidget.colors) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _progress,
      builder: (context, child) {
        return SizedBox(
          height: 110,
          width: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: const Size(200, 100),
                painter: MoodSemiCirclePainter(colors: widget.colors, values: widget.values, thickness: 26, progress: _progress.value),
              ),
              Positioned(
                bottom: 20,
                child: Text(
                  '${widget.total}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 38, color: Color.fromARGB(255, 186, 9, 9)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
