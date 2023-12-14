import 'package:flutter/material.dart';
import 'package:job_search/pages/location_city.dart';
import 'package:job_search/pages/register.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'register',
    routes: {
      'register' : (context) => RegisterPage(),
      'city' : (context) => JobCityPage(),

    },
  ));
}

