import 'package:flutter/material.dart';

class IncomesScreen extends StatelessWidget {
  /*
   * class to create incomes screen and hold all elements of screen
   */

  @override
  Widget build(BuildContext context) {
    /*
     * method to build whole elments of incomes screen
     * 
     * @params BuildContext
     * @return Widget
     */

    // visual scaffold with body includes all incomes listview
    return Scaffold(
      appBar: appBar(),
      floatingActionButton: addNewIncomeFloatingButton(),
      body: incomesListView(),
    );
  }

  AppBar appBar() {
    /*
     * helper method to create material design App Bar for screen
     * 
     * @return AppBar
     */

    return AppBar(
      title: Text("Incomes"),
      centerTitle: true,
    );
  }
  
  // TODO: Implement a floating action button to navigate user to add new income screen
  FloatingActionButton addNewIncomeFloatingButton() {}

  // TODO: Implement all incomes list view with data comes database (here it means a stream placed in bloc)
  StreamBuilder incomesListView() {}
}
