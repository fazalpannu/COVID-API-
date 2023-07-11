import 'package:covid_tracker/View/wordd_state.dart';
import 'package:flutter/material.dart';

class detailscreen extends StatefulWidget {
  String name, img;
  int totalcases,
      totaldeath,
      totalrecoversd,
      active,
      critical,
      todayrecover,
      test;
  detailscreen(
      {Key? key,
      required this.active,
      required this.critical,
      required this.name,
      required this.img,
      required this.totalcases,
      required this.totaldeath,
      required this.todayrecover,
      required this.test,
      required this.totalrecoversd})
      : super(key: key);

  @override
  State<detailscreen> createState() => _detailscreenState();
}

class _detailscreenState extends State<detailscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     // Handle back button press here
        //     Navigator.pop(context);
        //   },
        // ),
        // elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .063,
                      ),
                      reuseablerow(
                          title: 'Cases', value: widget.totalcases.toString()),
                      reuseablerow(
                          title: 'Death', value: widget.totaldeath.toString()),
                      reuseablerow(
                          title: 'Recovered',
                          value: widget.totalrecoversd.toString()),
                      reuseablerow(
                          title: 'TodayRecover',
                          value: widget.todayrecover.toString()),
                      reuseablerow(
                          title: 'Tests', value: widget.test.toString()),
                      reuseablerow(
                          title: 'Active', value: widget.active.toString()),
                      reuseablerow(
                          title: 'Critical', value: widget.critical.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.img),
              )
            ],
          )
        ],
      ),
    );
  }
}
