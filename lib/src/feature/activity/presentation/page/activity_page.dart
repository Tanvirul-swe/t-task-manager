import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:t_task_manager/src/constant/app_colors.dart';
import 'package:t_task_manager/src/constant/common_content.dart';
import 'package:t_task_manager/src/constant/text_style.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(DateTime(2010), 35, 0.32),
      ChartData(DateTime(2011), 38, 0.21),
      ChartData(DateTime(2012), 34, 0.38),
      ChartData(DateTime(2013), 52, 0.29),
      ChartData(DateTime(2014), 40, 0.34)
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Activity',
          style: appBarTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(scaffoldDefaultPadding),
        child: Column(
          children: [
            SfCartesianChart(
                backgroundColor: AppColors.primaryGray,
                title: ChartTitle(
                    alignment: ChartAlignment.near,
                    text: 'Tasks Perday',
                    textStyle: style14RegularBlack),
                primaryXAxis: const DateTimeAxis(),
                series: <CartesianSeries>[
                  // Renders bubble chart
                  BubbleSeries<ChartData, DateTime>(
                      dataLabelSettings: DataLabelSettings(
                          isVisible: true, textStyle: style14RegularBlack),
                      dataSource: chartData,
                      sizeValueMapper: (ChartData data, _) => data.size,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y)
                ]),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.size);
  final DateTime x;
  final double y;
  final double size;
}
