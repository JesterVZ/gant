part of 'package:gant/src/circle.dart';

class PieChartRenderObjectWidget extends LeafRenderObjectWidget {
  final List<PieData> data;
  final Size size;
  final double strokeWidth;
  final Color borderColor;
  final double animationValue;

  const PieChartRenderObjectWidget({
    super.key,
    required this.data,
    required this.size,
    this.strokeWidth = 2.0,
    this.borderColor = Colors.black,
    this.animationValue = 1.0,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return PieChartRenderObject(
      data,
      size,
      strokeWidth,
      borderColor,
      animationValue,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant PieChartRenderObject renderObject) {
    renderObject
      ..data = data
      ..size = size
      ..strokeWidth = strokeWidth
      ..borderColor = borderColor
      ..animationValue = animationValue;
  }
}

class PieChartRenderObject extends RenderBox {
  List<PieData> _data;
  Size _size;
  double _strokeWidth;
  Color _borderColor;
  double _animationValue;

  PieChartRenderObject(
    this._data,
    this._size,
    this._strokeWidth,
    this._borderColor,
    this._animationValue,
  );

  List<PieData> get data => _data;

  set data(List<PieData> newData) {
    if (_data != newData) {
      _data = newData;
      markNeedsPaint();
    }
  }

  @override
  Size get size => _size;

  @override
  set size(Size newSize) {
    if (_size != newSize) {
      _size = newSize;
      markNeedsLayout();
    }
  }

  double get strokeWidth => _strokeWidth;

  set strokeWidth(double newStrokeWidth) {
    if (_strokeWidth != newStrokeWidth) {
      _strokeWidth = newStrokeWidth;
      markNeedsPaint();
    }
  }

  Color get borderColor => _borderColor;

  set borderColor(Color newBorderColor) {
    if (_borderColor != newBorderColor) {
      _borderColor = newBorderColor;
      markNeedsPaint();
    }
  }

  double get animationValue => _animationValue;

  set animationValue(double newAnimationValue) {
    if (_animationValue != newAnimationValue) {
      _animationValue = newAnimationValue;
      markNeedsPaint();
    }
  }

  @override
  void performLayout() {
    size = constraints.constrain(_size);
  }

@override
void paint(PaintingContext context, Offset offset) {
  final canvas = context.canvas;
  final total = data.fold<double>(0.0, (sum, item) => sum + item.value);
  final radius = min(size.width, size.height) / 2;
  final center = offset + Offset(size.width / 2, size.height / 2);

  double startAngle = -pi / 2; // Начальный угол

  for (final segment in data) {
    final segmentSweep = (segment.value / total) * 2 * pi;
    final sweepAngle = segmentSweep * animationValue;

    // Ограничиваем рисование текущего сегмента
    if (sweepAngle > 0) {
      // Рисуем сегмент
      final segmentPaint = Paint()
        ..color = segment.color
        ..style = PaintingStyle.fill;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        segmentPaint,
      );

      // Рисуем обводку сегмента, если указана
      if (strokeWidth > 0) {
        final borderPaint = Paint()
          ..color = borderColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth;
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          startAngle,
          sweepAngle,
          true,
          borderPaint,
        );
      }
    }

    // Обновляем начальный угол
    startAngle += segmentSweep;
  }

  // Рисуем внешнюю обводку всего круга, если указана
  if (strokeWidth > 0) {
    final outerBorderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, outerBorderPaint);
  }
}
}