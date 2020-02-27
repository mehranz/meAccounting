import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  /*
   * Home Screen Widget to build HomeScreen of app!
   */

  @override
  Widget build(BuildContext context) {
    /*
    * scaffold of home screen in order to hold home screen elements
    * @params BuildContext
    * @return Widget
    */
    return Scaffold(
      appBar: AppBar(
        title: Text("MeAccounting!"),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
