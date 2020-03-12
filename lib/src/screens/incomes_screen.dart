import 'package:flutter/material.dart';
import 'package:meAccounting/src/blocs/incomes_bloc.dart';
import 'package:meAccounting/src/models/income_model.dart';
import 'package:meAccounting/src/screens/add_incomes_screen.dart';

class IncomesScreen extends StatelessWidget {
  /*
   * class to create incomes screen and hold all elements of screen
   */

  // create an instance of incomes bloc in order to access to streams
  final bloc = IncomesBloc();

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
  
  FloatingActionButton addNewIncomeFloatingButton() {
    /*
     * helper method to create add income floating action button
     * 
     * @return FloatingActionButton
     */
    return FloatingActionButton(
      // TODO: navigate to new income screen
      onPressed: () => print("pressed"),
      child: Icon(Icons.add),
    );
  }

  // TODO: Implement all incomes list view with data comes database (here it means a stream placed in bloc)
  StreamBuilder incomesListView() {}
}
