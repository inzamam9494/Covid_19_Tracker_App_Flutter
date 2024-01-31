import 'package:covid_19_tracker_app/View/world_states.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

final colorList = <Color>[
  const Color(0xff4285F4),
  const Color(0xff05be54),
  const Color(0xfff44242),
];

class DetailScreen extends StatefulWidget {
  String city;
  int total, recovered, death;

  DetailScreen({
    super.key,
    required this.city,
    required this.total,
    required this.recovered,
    required this.death,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.city),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Column(
                    children: [
                      ReusableRow(title: 'Total Cases', value: widget.total.toString()),
                      SizedBox(height: MediaQuery.of(context).size.height * .02),
                      ReusableRow(title: 'Recovered Cases', value: widget.recovered.toString()),
                      SizedBox(height: MediaQuery.of(context).size.height * .02),
                      ReusableRow(title: 'Death Cases', value: widget.death.toString()),

                      SizedBox(height: MediaQuery.of(context).size.height * .05),

                      PieChart(dataMap: {
                        'Total': widget.total.toDouble(),
                        'Recovered' : widget.recovered.toDouble(),
                        'Death': widget.death.toDouble()
                      },
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValuesInPercentage: true
                      ),
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        legendOptions:
                        const LegendOptions(legendPosition: LegendPosition.left),
                        animationDuration: const Duration(seconds: 3),
                        chartType: ChartType.ring,
                        colorList: colorList,
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}


