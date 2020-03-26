// Initialize the app and the app context 
// set the initial route
// Set the theme style for the entire app

import 'package:flutter/material.dart';
import 'package:my_spot/src/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey
      ),
      debugShowCheckedModeBanner: false,
      title: 'MySpot',
      initialRoute: '/',
      routes: getRoutes()
    );
  }
}

