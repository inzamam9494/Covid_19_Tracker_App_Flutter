import 'package:covid_19_tracker_app/Model/world_state_model.dart';
import 'package:covid_19_tracker_app/Services/Utilites/states_services.dart';
import 'package:covid_19_tracker_app/View/city_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff05be54),
    const Color(0xfff44242),
  ];

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              FutureBuilder(
                  future: stateServices.fetchWorldStateModel(),
                  builder: (context,AsyncSnapshot<WorldStatesModel>snapshot){
                    if(!snapshot.hasData){
                      return Expanded(
                        flex: 1,
                          child: SpinKitCircle(
                            controller: _controller,
                            color: Colors.white,
                            size: 50,
                          ));
                    }else{
                      return Column(
                        children: [
                          PieChart(
                            dataMap:  {
                              'Total': double.parse(snapshot.data!.data!.summary!.total.toString()),
                              'Recovered': double.parse(snapshot.data!.data!.summary!.discharged.toString()),
                              'Death': double.parse(snapshot.data!.data!.summary!.deaths.toString()),
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
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height * 0.05),
                            child: Card(
                              child: Column(
                                children: [
                                  ReusableRow(title: 'Total', value: snapshot.data!.data!.summary!.total.toString()),
                                  ReusableRow(title: 'India Case', value: snapshot.data!.data!.summary!.confirmedCasesIndian.toString()),
                                  ReusableRow(title: 'Recovered', value: snapshot.data!.data!.summary!.discharged.toString()),
                                  ReusableRow(title: 'Deaths', value: snapshot.data!.data!.summary!.deaths.toString()),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CityListScreen()));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: const Color(0xff05be54),
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Center(
                                child: Text(
                                  'Track  ',
                                  style: TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;

  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title), Text(value)],
      ),
    );
  }
}
