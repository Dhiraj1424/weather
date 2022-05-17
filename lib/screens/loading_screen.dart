import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wather/screens/location_screen.dart';
import 'package:wather/services/location.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:wather/services/networking.dart';

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
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude=location.latitute;
    langitude=location.longitude;

    var networkHelper=NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$langitude&appid=5b02e3682a9a245fdb045deb0c6d1e33');
 
 var weatherData= await networkHelper.getData();

 Navigator.push(context, MaterialPageRoute(builder: (context){
 return LocationScreen(locationWeather: weatherData);}
 ));




  }

  // void getData() async {
  //   http.Response response = await http.get(Uri.parse(
  // ''));
   
  //     var decodeData = jsonDecode(data);
      
     
  // }

  @override
  Widget build(BuildContext context) {
    // getData();
    return Scaffold(
      body: SpinKitSquareCircle(
  color: Colors.white,
  size: 50.0,
      ),
    );
  }
}


 