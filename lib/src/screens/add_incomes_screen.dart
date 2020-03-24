import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meAccounting/src/blocs/incomes_bloc.dart';
import 'package:meAccounting/src/models/income_model.dart';
import 'package:meAccounting/src/widgets/bank_account_dropdown.dart';

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
            onPressed: () {
              bloc.submitToDB();
              
              // back to previous screen after new income submitted
              Navigator.of(context).pop();
            }),
      ],
    );
  }

  Widget textFieldsTheme(Widget textField, {Color primaryColor}) {
    /*
     * method to create text fields theme in order to change color 
     * when there was an error.
     * 
     * @params Widget, Color
     * @return Widget
     */

    return Theme(
      child: textField,
      data: ThemeData(
          primaryColor: primaryColor,
          accentColor: Colors.white,
          hintColor: Colors.white54,
          textSelectionColor: Colors.white),
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
        return Column(children: [
          textFieldsTheme(
              Card(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Color(0XFF406B96),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: _titleController,
                    onChanged: (value) => bloc.addTitle(value),
                    decoration: InputDecoration(
                      labelText: "Title",
                      hintText: "Title",

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      // errorText: snapshot.hasError ? snapshot.error : null,
                    ),
                  )),
                  // change primary color to red if there was an error
              primaryColor: snapshot.hasError ? Colors.red : Colors.white),

          // Container for error text to avoid show errors inside card
          Container(
              // height: 10,
              alignment: Alignment.bottomLeft,
              // padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 10, top: 2, left: 20),
              child: snapshot.hasError
                  ? Text(
                      snapshot.error,
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.right,
                    )
                  : SizedBox())
        ]);
      },
    );
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
        return Column(children: [
          textFieldsTheme(
              Card(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Color(0XFF406B96),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: _amountController,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) => bloc.addAmount(int.parse(value)),
                    decoration: InputDecoration(
                      labelText: "Amount",
                      hintText: "Amount",

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      // errorText: snapshot.hasError ? snapshot.error : null,
                    ),
                  )),
                  // change primary color to red if there was an error
              primaryColor: snapshot.hasError ? Colors.red : Colors.white),

          // Container for error text to avoid show errors inside card
          Container(
              // height: 10,
              alignment: Alignment.bottomLeft,
              // padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 10, top: 2, left: 20),
              child: snapshot.hasError
                  ? Text(
                      snapshot.error,
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.right,
                    )
                  : SizedBox())
        ]);
      },
    );
  }

  Widget accountIdField() {
    return Card(
      margin: EdgeInsets.only(left:10, right: 10),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Color(0XFF406B96),
      child: BankAccountDropdown((value) => _accountIdController..text = value),
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
        return Column(children: [
          textFieldsTheme(
              Card(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Color(0XFF406B96),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: _descriptionsController,
                    onChanged: (value) => bloc.addDescriptions(value),
                    decoration: InputDecoration(
                      labelText: "Descriptions",
                      hintText: "Descriptions",

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      // errorText: snapshot.hasError ? snapshot.error : null,
                    ),
                  )),

                  // change primary color to red if there was an error
              primaryColor: snapshot.hasError ? Colors.red : Colors.white),

          // Container for error text to avoid show errors inside card
          Container(
              // height: 10,
              alignment: Alignment.bottomLeft,
              // padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 10, top: 2, left: 20),
              child: snapshot.hasError
                  ? Text(
                      snapshot.error,
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.right,
                    )
                  : SizedBox())
        ]);
      },
    );
  }
}
