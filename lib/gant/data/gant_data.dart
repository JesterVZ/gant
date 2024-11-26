import 'package:flutter/material.dart';

/// Задача диаграммы Ганта
class GanttTask {
  final String name;
  final DateTime start;
  final Duration duration;
  final Color color;

  GanttTask(this.name, this.start, this.duration, this.color);
}

