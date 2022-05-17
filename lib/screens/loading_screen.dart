import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wather/services/location.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
   double? latitude;
   double? langitude;
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude=location.latitute;
    langitude=location.longitude;
    getData();
  }

  void getData() async {
    http.Response response = await http.get(Uri.parse(
  'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$langitude&appid=5b02e3682a9a245fdb045deb0c6d1e33'));
    if (response.statusCode == 200) {
      String data = response.body;
      // print(data);
      var decodeData = jsonDecode(data);
      var condition = decodeData['weather'][0]['id'];
      var temperature = decodeData['main']['temp'];
      var cityName = decodeData['name'];
      print(cityName);
      print(temperature);
      print(condition);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold();
  }
}
