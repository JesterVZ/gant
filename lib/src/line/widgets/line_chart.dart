part of 'package:gant/src/line/line.dart';

class LineChart extends LeafRenderObjectWidget {
  final List<LineData> data;
  final String xLabel;
  final String yLabel;

  const LineChart({
    super.key,
    required this.data,
    required this.xLabel,
    required this.yLabel,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return LineChartRenderBox(data: data, xLabel: xLabel, yLabel: yLabel);
  }

  @override
  void updateRenderObject(BuildContext context, covariant LineChartRenderBox renderObject) {
    renderObject
      ..data = data
      ..xLabel = xLabel
      ..yLabel = yLabel;
  }
}

class LineChartRenderBox extends RenderBox {
  List<LineData> _data;
  String _xLabel;
  String _yLabel;

  LineChartRenderBox({
    required List<LineData> data,
    required String xLabel,
    required String yLabel,
  })  : _data = data,
        _xLabel = xLabel,
        _yLabel = yLabel;

  List<LineData> get data => _data;

  set data(List<LineData> newData) {
    if (_data != newData) {
      _data = newData;
      markNeedsPaint();
    }
  }

  String get xLabel => _xLabel;

  set xLabel(String newXLabel) {
    if (_xLabel != newXLabel) {
      _xLabel = newXLabel;
      markNeedsPaint();
    }
  }

  String get yLabel => _yLabel;

  set yLabel(String newYLabel) {
    if (_yLabel != newYLabel) {
      _yLabel = newYLabel;
      markNeedsPaint();
    }
  }

  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    
    // Определяем границы графика
    const double margin = 40.0;
    final plotWidth = size.width - 2 * margin;
    final plotHeight = size.height - 2 * margin;

    // Рисуем сетку
    final gridPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    const int gridLines = 10;
    for (int i = 0; i <= gridLines; i++) {
      final dx = margin + i * (plotWidth / gridLines);
      final dy = margin + i * (plotHeight / gridLines);

      // Вертикальная линия
      canvas.drawLine(
        Offset(dx, margin),
        Offset(dx, size.height - margin),
        gridPaint,
      );

      // Горизонтальная линия
      canvas.drawLine(
        Offset(margin, size.height - dy),
        Offset(size.width - margin, size.height - dy),
        gridPaint,
      );
    }

    // Рисуем оси
    final axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;

    // Ось X
    canvas.drawLine(
      Offset(margin, size.height - margin),
      Offset(size.width - margin, size.height - margin),
      axisPaint,
    );

    // Ось Y
    canvas.drawLine(
      const Offset(margin, margin),
      Offset(margin, size.height - margin),
      axisPaint,
    );

    // Рисуем подписи
    final textPainterX = TextPainter(
      text: TextSpan(
        text: _xLabel,
        style: const TextStyle(color: Colors.black, fontSize: 14),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();

    final textPainterY = TextPainter(
      text: TextSpan(
        text: _yLabel,
        style: const TextStyle(color: Colors.black, fontSize: 14),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();

    // Подпись X
    textPainterX.paint(
      canvas,
      Offset(size.width / 2 - textPainterX.width / 2, size.height - margin + 10),
    );

    // Подпись Y
    textPainterY.paint(
      canvas,
      Offset(margin - textPainterY.width - 10, size.height / 2 - textPainterY.height / 2),
    );

    // Определяем максимальные значения по осям для масштабирования
    final maxX = _data.map((d) => d.x).reduce(max);
    final maxY = _data.map((d) => d.y).reduce(max);

    // Рисуем линии между точками
    final linePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (int i = 0; i < _data.length - 1; i++) {
      final point1 = _data[i];
      final point2 = _data[i + 1];

      final x1 = margin + (point1.x / maxX) * plotWidth;
      final y1 = size.height - margin - (point1.y / maxY) * plotHeight;

      final x2 = margin + (point2.x / maxX) * plotWidth;
      final y2 = size.height - margin - (point2.y / maxY) * plotHeight;

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), linePaint);
    }

    // Рисуем точки
    final pointPaint = Paint()..style = PaintingStyle.fill;
    for (final point in _data) {
      final xPos = margin + (point.x / maxX) * plotWidth;
      final yPos = size.height - margin - (point.y / maxY) * plotHeight;

      pointPaint.color = Colors.blue;
      canvas.drawCircle(Offset(xPos, yPos), 4.0, pointPaint);
    }
  }
}