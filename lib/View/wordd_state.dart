// ignore: unused_import
// import 'dart:ffi';
// import 'dart:js_util';

import 'dart:ffi';

import 'package:covid_tracker/View/countries.dart';
import 'package:covid_tracker/model/worldstatemodel.dart';
import 'package:covid_tracker/services/ststeservices.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/ststeservices.dart';
import '../services/ststeservices.dart';

class wordstatescreen extends StatefulWidget {
  const wordstatescreen({Key? key}) : super(key: key);

  @override
  State<wordstatescreen> createState() => _wordstatescreenState();
}

class _wordstatescreenState extends State<wordstatescreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  final colorlist = <Color>{
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  };

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();

    return SafeArea(
      child: Scaffold(
          body: SafeArea(
              child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .08),
            FutureBuilder(
              future: stateServices.fetchdataofword(),
              builder: (context, AsyncSnapshot<worldstatemodel> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: _controller,
                      ));
                } else {
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          "Total":
                              double.parse(snapshot.data!.cases.toString()),
                          "Recovers ":
                              double.parse(snapshot.data!.recovered.toString()),
                          "Deaths":
                              double.parse(snapshot.data!.deaths.toString()),
                        },
                        chartValuesOptions: ChartValuesOptions(
                          showChartValuesInPercentage: true,
                        ),
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        animationDuration: Duration(milliseconds: 1200),
                        chartType: ChartType.ring,
                        legendOptions:
                            LegendOptions(legendPosition: LegendPosition.left),
                        colorList: [
                          const Color(0xff4285F4),
                          const Color(0xff1aa260),
                          const Color(0xffde5246),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Card(
                          child: Column(children: [
                            reuseablerow(
                                title: 'Total',
                                value: snapshot.data!.cases.toString()),
                            reuseablerow(
                                title: 'Recover',
                                value: snapshot.data!.recovered.toString()),
                            reuseablerow(
                                title: 'Active',
                                value: snapshot.data!.active.toString()),
                            reuseablerow(
                                title: 'Today recovered',
                                value:
                                    snapshot.data!.todayRecovered.toString()),
                            reuseablerow(
                                title: 'Today Death',
                                value: snapshot.data!.todayDeaths.toString()),
                            reuseablerow(
                                title: 'Critical',
                                value: snapshot.data!.critical.toString()),
                          ]),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .04,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CountriesList(),
                              ));
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Text('Track Countries'),
                          ),
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ))),
    );
  }
}

// ignore: camel_case_types
class reuseablerow extends StatelessWidget {
  String value, title;
  reuseablerow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .01,
          ),
          Divider(),
        ],
      ),
    );
  }
}
