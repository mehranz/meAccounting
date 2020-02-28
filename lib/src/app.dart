import 'package:flutter/material.dart';
import 'package:meaccountingfinal/src/screens/home_screen.dart';

class App extends StatelessWidget {
  /*
   * App Class To provide main widget of app 
   */

  @override
  Widget build(BuildContext context) {
    /**
     * build method of app widget to get together whole app
     */
    return MaterialApp(
      title: "MeAccouting",
      theme: ThemeData(primaryColor: Colors.greenAccent),
      
      home: HomeScreen(),
    );
  }
}