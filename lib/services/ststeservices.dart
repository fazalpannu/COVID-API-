import 'dart:convert';
import 'package:covid_tracker/services/utilities/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:covid_tracker/model/worldstatemodel.dart';

class StateServices {
  Future<worldstatemodel> fetchdataofword() async {
    final response = await http.get(Uri.parse(appurl.worlbaseapi));
    var data = json.decode(response.body.toString());
    if (response.statusCode == 200) {
      return worldstatemodel.fromJson(data);
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> fetchdataofcountries() async {
    final response = await http.get(Uri.parse(appurl.countrieslist));
    var data = json.decode(response.body.toString());
    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception('error');
    }
  }
}
