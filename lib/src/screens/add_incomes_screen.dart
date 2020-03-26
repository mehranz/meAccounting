import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meAccounting/src/blocs/incomes_bloc.dart';
import 'package:meAccounting/src/widgets/bank_account_dropdown.dart';
import 'package:meAccounting/src/widgets/custom_text_field.dart';

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
        _submitButton(context),
      ],
    );
  }

  Widget _submitButton(BuildContext context) {
    return StreamBuilder(
      stream: bloc.validateSubmit,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return IconButton(
          icon: Icon(
            Icons.done,
            color: snapshot.hasData ? Colors.white : Colors.white54,
          ),
          onPressed: snapshot.hasData ? () {
            bloc.submitToDB();
            Navigator.of(context).pop();
          } : null,
        );
      },
    );
  }

  Widget buildScaffoldBody() {
    /*
     * method to build scaffold body and get all elements of screen together
     * 
     * @return Widget
     */

    return Container(
        margin: EdgeInsets.all(20),
        child: Column(children: <Widget>[
          titleField(),
          amountField(),
          descriptionsField(),
          accountIdField(),
        ]));
  }

  Widget titleField() {
    /*
     * method to create title field and get user's input
     * and push it to stream.
     * 
     * @return Widget
     */

    return StreamBuilder(
        stream: bloc.title,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return CustomTextField(
            "Title",
            "Enter Your Title Here",
            errorText: snapshot.hasError ? snapshot.error : null,
            controller: _titleController,
            onChanged: (value) => bloc.addTitle(value),
          );
        });
  }

  Widget amountField() {
    /*
     * method to create amount field and get user's input
     * and push it to stream.
     * 
     * @return Widget
     */

    return StreamBuilder(
        stream: bloc.amount,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return CustomTextField(
            "Amount",
            "Enter Amount Here",
            errorText: snapshot.hasError ? snapshot.error : null,
            controller: _amountController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ],
            onChanged: (value) => bloc.addAmount(int.parse(value)),
          );
        });
  }

  Widget accountIdField() {
    return Card(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Color(0XFF406B96),
      child:
          BankAccountDropdown((value) => bloc.addAccountId(int.parse(value))),
    );
  }

  Widget descriptionsField() {
    /*
     * method to create descriptions field and get user's input 
     * and push it to stream.
     * 
     * @return Widget
     */

    return StreamBuilder(
      stream: bloc.descriptions,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return CustomTextField(
          "Descriptions",
          "Enter Descriptions of Income",
          errorText: snapshot.hasError ? snapshot.error : null,
          controller: _descriptionsController,
          onChanged: (value) => bloc.addDescriptions(value),
        );
      },
    );
  }
}
