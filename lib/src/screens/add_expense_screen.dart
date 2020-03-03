import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meAccounting/src/blocs/expenses_bloc.dart';
import 'package:meAccounting/src/models/expense_model.dart';

class AddNewExpensesScreen extends StatelessWidget {
  /*
   * Widget to hold all elements of Add New Expense Screen 
   */

  final bloc = ExpensesBloc();

  // text controller for every text field in order to controll them
  // and get their values out
  final TextEditingController _titleFieldController = TextEditingController();
  final TextEditingController _amountFieldController = TextEditingController();
  final TextEditingController _descriptionsFieldController =
      TextEditingController();
  final TextEditingController _bankAccountFieldController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    /*
     * Scaffold of Add New Expense screen in order to hold screen's elements
     * 
     * @param BuildContext
     * @return Widget
     */

    return Scaffold(
        appBar: appBar(context),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              textFieldsTheme(titleField()),
              textFieldsTheme(amountField()),
              textFieldsTheme(descriptionsField()),
              textFieldsTheme(accountField())
            ],
          ),
        ));
  }

  Widget appBar(BuildContext context) {
    /*
     * method to create app bar of screen
     * 
     * @params BuildContext
     * @return Widget
     */

    return AppBar(
      title: Text("Add New Expense"),
      centerTitle: true,
      actions: <Widget>[submitButton(context)],
    );
  }

  Widget submitButton(BuildContext context) {
    /*
     * method to create submit button on appBar actions
     * 
     * @param BuildContext
     * @return Widget
     */

    return IconButton(
      onPressed: () async {
        await bloc.addNewExpenseToDB(ExpenseModel(
          title: _titleFieldController.text,
          amount: int.parse(_amountFieldController.text),
          descriptions: _descriptionsFieldController.text,
          accountId: int.parse(_bankAccountFieldController.text),
          createdAt: DateTime.now().toString(),
        ));

        Navigator.of(context).pop();
      },
      icon: Icon(Icons.done),
      color: Colors.white,
    );
  }

  Widget textFieldsTheme(Widget textField) {
    /*
     * method to create text fields theme in order to seprate colors of textfields from app's main theme
     * @params Widget
     * @return Widget
     */

    return Theme(
      child: textField,
      data: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.white,
          hintColor: Colors.white54,
          textSelectionColor: Colors.white),
    );
  }

  Widget titleField() {
    /*
     * method to create title text field
     * 
     * @return Widget
     */

    return Card(
        margin: EdgeInsets.all(10),
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Color(0XFF406B96),
        child: TextField(
          controller: _titleFieldController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: "Title",
            hintText: "Enter Title Here",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ));
  }

  Widget amountField() {
    /*
     * method to create amount text field
     * 
     * @return Widget
     */

    return Card(
        margin: EdgeInsets.all(10),
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Color(0XFF406B96),
        child: TextField(
          controller: _amountFieldController,
          keyboardType: TextInputType.number,

          // limit text field to only accept digits
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly
          ],
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: "Amount",
            hintText: "Enter Amount Here",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ));
  }

  Widget descriptionsField() {
    /*
     * method to create descriptions text field
     * 
     * @return Widget
     */

    return Card(
        margin: EdgeInsets.all(10),
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Color(0XFF406B96),
        child: TextField(
          controller: _descriptionsFieldController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: "Descriptions",
            hintText: "Enter Descriptions Here",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ));
  }

  Widget accountField() {
    /*
     * method to create account_id text field
     * NOTE : this should be changed to a custom dropdown widget soon
     * 
     * @return Widget
     */
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Color(0XFF406B96),
      child: TextField(
        controller: _bankAccountFieldController,
        keyboardType: TextInputType.number,

        // limit text field to only accept digits
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: "Account_id",
          hintText: "Enter Your Account Id here (just for now)",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
