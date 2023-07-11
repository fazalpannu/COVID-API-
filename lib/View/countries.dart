import 'package:covid_tracker/View/details_screen.dart';
import 'package:covid_tracker/services/ststeservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList>
    with TickerProviderStateMixin {
  TextEditingController searchcountries = TextEditingController();
  // late final AnimationController _controller =
  //     AnimationController(duration: const Duration(seconds: 3), vsync: this)
  //       ..repeat();
  StateServices stateServices = StateServices();
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
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchcountries,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  hintText: 'Search with Country Name',
                  contentPadding: EdgeInsets.only(left: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0))),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: stateServices.fetchdataofcountries(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade100,
                        child: ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            color: Colors.white,
                          ),
                          title: Container(
                            height: 10,
                            width: 89,
                            color: Colors.white,
                          ),
                          subtitle: Container(
                            height: 10,
                            width: 89,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String mainString =
                          snapshot.data![index]['country'].toString();
                      if (searchcountries.text.toString().isEmpty) {
                        return InkWell(
                          onTap: () {
                            setState(() {});
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => detailscreen(
                                  active: snapshot.data![index]['active'],
                                  critical: snapshot.data![index]['critical'],
                                  name: snapshot.data![index]['country'],
                                  img: snapshot.data![index]['countryInfo']
                                      ['flag'],
                                  totalcases: snapshot.data![index]['cases'],
                                  totaldeath: snapshot.data![index]['deaths'],
                                  todayrecover: snapshot.data![index]
                                      ['todayRecovered'],
                                  test: snapshot.data![index]['tests'],
                                  totalrecoversd: snapshot.data![index]
                                      ['recovered'],
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            leading: Image(
                                height: 50,
                                width: 50,
                                image: NetworkImage(snapshot.data![index]
                                    ['countryInfo']['flag'])),
                            title: Text(snapshot.data![index]['country']),
                            subtitle:
                                Text(snapshot.data![index]['cases'].toString()),
                          ),
                        );
                      } else if (mainString.toLowerCase().contains(
                          searchcountries.text.toString().toLowerCase())) {
                        return InkWell(
                          onTap: () {
                            setState(() {});

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => detailscreen(
                                  active: snapshot.data![index]['active'],
                                  critical: snapshot.data![index]['critical'],
                                  name: snapshot.data![index]['country'],
                                  img: snapshot.data![index]['countryInfo']
                                      ['flag'],
                                  totalcases: snapshot.data![index]['cases'],
                                  totaldeath: snapshot.data![index]['deaths'],
                                  todayrecover: snapshot.data![index]
                                      ['todayRecovered'],
                                  test: snapshot.data![index]['tests'],
                                  totalrecoversd: snapshot.data![index]
                                      ['recovered'],
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            leading: Image(
                                height: 50,
                                width: 50,
                                image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag']
                                    .toString())),
                            title: Text(
                                snapshot.data![index]['country'].toString()),
                            subtitle:
                                Text(snapshot.data![index]['cases'].toString()),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
