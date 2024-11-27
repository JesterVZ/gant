part of 'package:gant/src/scatter/scatter.dart';

class ScatterPlot extends LeafRenderObjectWidget {
  final List<ScatterData> data;
  final String xLabel;
  final String yLabel;

  const ScatterPlot({
    super.key,
    required this.data,
    required this.xLabel,
    required this.yLabel,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return ScatterPlotRenderBox(data: data, xLabel: xLabel, yLabel: yLabel);
  }

  @override
  void updateRenderObject(BuildContext context, covariant ScatterPlotRenderBox renderObject) {
    renderObject
      ..data = data
      ..xLabel = xLabel
      ..yLabel = yLabel;
  }
}


class ScatterPlotRenderBox extends RenderBox {
  List<ScatterData> _data;
  String _xLabel;
  String _yLabel;

  ScatterPlotRenderBox({
    required List<ScatterData> data,
    required String xLabel,
    required String yLabel,
  })  : _data = data,
        _xLabel = xLabel,
        _yLabel = yLabel;

  List<ScatterData> get data => _data;

  set data(List<ScatterData> newData) {
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
      Offset(margin, margin),
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

    // Рисуем точки
    final pointPaint = Paint()..style = PaintingStyle.fill;
    for (final point in _data) {
      final xPos = margin + (point.x / maxX) * plotWidth;
      final yPos = size.height - margin - (point.y / maxY) * plotHeight;

      pointPaint.color = point.color;
      canvas.drawCircle(Offset(xPos, yPos), 5.0, pointPaint);
    }
  }
}