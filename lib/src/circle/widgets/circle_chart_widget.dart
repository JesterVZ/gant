part of 'package:gant/src/circle.dart';

class CircleChartWidget extends LeafRenderObjectWidget {
  const CircleChartWidget({super.key, 
    required this.data,
  });
  final List<double> data;
  @override
  RenderObject createRenderObject(BuildContext context) {
    return CiecleRenderBox(data: data);
  }
}

class CiecleRenderBox extends RenderBox {
  List<double> _data;
  CiecleRenderBox({
    required List<double> data,
  }) : _data = data;

  @override
  void performLayout() {
    size = constraints.constrain(const Size(400, 400));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;

    final Paint backgroundPaint = Paint()..color = Colors.white;
    canvas.drawCircle(offset, 100, backgroundPaint);
  }
}
