import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meAccounting/src/blocs/incomes_bloc.dart';
import 'package:meAccounting/src/models/income_model.dart';

class AddIncomeScreen extends StatelessWidget {
  /*
   * Class to hold add incomes screen elements
   * 
   */

  // create an instance of incomes bloc in order to access to streams
  final bloc = IncomesBloc();

  // create a text editing controller for each text field
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _accountIdController = TextEditingController();
  final TextEditingController _descriptionsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /*
     * method to build whole screen's elements
     * 
     * @params BuildContext
     * @return Widget
     */

    return Scaffold(
      appBar: appBar(context),
      body: buildScaffoldBody(),
    );
  }

  AppBar appBar(BuildContext context) {
    /*
     * helper method to create app bar of screen
     * 
     * @params BuildContext
     * @return AppBar
     */

    return AppBar(
      title: Text("Add New Income"),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.done),
            onPressed: () async {
              /*
               * method to get text fields value and make an income model 
               * and submit it to database.
               */
              
              await bloc.addNewIncome(IncomeModel(
                title: _titleController.text,
                amount: int.parse(_amountController.text),
                account_id: int.parse(_accountIdController.text),
                created_at: DateTime.now().toString(),
                descriptions: _descriptionsController.text,
              ));
              
              // back to previous screen after new income submitted
              Navigator.of(context).pop();
            }),
      ],
    );
  }

