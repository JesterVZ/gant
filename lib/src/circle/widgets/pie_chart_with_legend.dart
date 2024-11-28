part of 'package:graphaello/src/circle/circle.dart';

class PieChartWithLegend extends StatefulWidget {
  final List<PieData> data;
  final double strokeWidth;
  final Color borderColor;

  const PieChartWithLegend({
    super.key,
    required this.data,
    this.strokeWidth = 2.0,
    this.borderColor = Colors.black,
  });

  @override
  State createState() => _PieChartWithLegendState();
}

class _PieChartWithLegendState extends State<PieChartWithLegend>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return PieChartRenderObjectWidget(
              data: widget.data,
              size: const Size(200, 200),
              strokeWidth: widget.strokeWidth,
              borderColor: widget.borderColor,
              animationValue: _animation.value,
            );
          },
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: widget.data
              .map((e) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        color: e.color,
                      ),
                      const SizedBox(width: 8),
                      Text(e.name),
                    ],
                  ))
              .toList(),
        ),
      ],
    );
  }
}