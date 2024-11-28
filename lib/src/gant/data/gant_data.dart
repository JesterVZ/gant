part of 'package:graphaello/src/gant/gant.dart';

/// Задача диаграммы Ганта
class GanttTask {
  final String name;
  final DateTime start;
  final Duration duration;
  final Color color;

  GanttTask({
    required this.name,
    required this.start,
    required this.duration,
    required this.color,
  });
}
