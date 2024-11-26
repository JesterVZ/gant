part of 'package:gant/src/gant.dart';
/// Задача диаграммы Ганта
class GanttTask {
  final String name;
  final DateTime start;
  final Duration duration;
  final Color color;

  GanttTask(this.name, this.start, this.duration, this.color);
}

