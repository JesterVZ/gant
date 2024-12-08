import 'package:flutter/material.dart';
import 'package:graphaello/graphaello.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Charts demo'),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: GridView.count(
            crossAxisCount: 2,
            children: [
              const PieChartWithLegend(
                data: [
                  PieData(
                    name: 'Лягушки',
                    value: 10,
                    color: Colors.green,
                  ),
                  PieData(
                    name: 'Пчелы',
                    value: 5,
                    color: Color.fromARGB(255, 218, 202, 59),
                  ),
                  PieData(
                    name: 'Драконы',
                    value: 2,
                    color: Color.fromARGB(255, 207, 20, 20),
                  ),
                ],
              ),
              GanttChart(
                tasks: [
                  GanttTask(
                      name: 'Task 1',
                      start: DateTime(2023, 11, 1),
                      duration: const Duration(days: 5),
                      color: Colors.blue),
                  GanttTask(
                      name: 'Task 2',
                      start: DateTime(2023, 11, 4),
                      duration: Duration(days: 3),
                      color: Colors.red),
                  GanttTask(
                      name: 'Task 3',
                      start: DateTime(2023, 11, 8),
                      duration: Duration(days: 7),
                      color: Colors.green),
                ],
                startDate: DateTime(2023, 11, 1),
                endDate: DateTime(2023, 11, 15),
              ),
              ScatterPlot(
              data: [
                ScatterData(x: 10, y: 20, color: Colors.red),
                ScatterData(x: 30, y: 40, color: Colors.blue),
                ScatterData(x: 50, y: 25, color: Colors.green),
                ScatterData(x: 70, y: 80, color: Colors.orange),
                ScatterData(x: 90, y: 50, color: Colors.purple),
              ],  
              xLabel: 'X-Axis',
              yLabel: 'Y-Axis',
            ),
            LineChart(
            data: [
              LineData(x: 10, y: 100),
              LineData(x: 30, y: 40),
              LineData(x: 50, y: 25),
              LineData(x: 70, y: 80),
              LineData(x: 90, y: 50),
            ],
            xLabel: 'X-Axis',
            yLabel: 'Y-Axis',
          ),
            ],
          ),
        ),
      ),
    );
  }
}
