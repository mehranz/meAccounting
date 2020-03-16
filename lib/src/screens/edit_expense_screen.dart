import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meAccounting/src/blocs/expenses_bloc.dart';
import 'package:meAccounting/src/models/expense_model.dart';
import 'package:meAccounting/src/widgets/bank_account_dropdown.dart';

class EditExpenseScreen extends StatelessWidget {

  // get expense model wanted to be edited from constructor
  final ExpenseModel _expense;

  final ExpensesBloc bloc = ExpensesBloc();

  // create a text editing controller for each text fields in screen
  final TextEditingController _titleFieldController = TextEditingController();
  final TextEditingController _amountFieldController = TextEditingController();
  final TextEditingController _descriptionsFieldController =
      TextEditingController();
  final TextEditingController _bankAccountFieldController =
      TextEditingController();

  // get expense model wanted to be edited
  EditExpenseScreen(this._expense);

  @override
  Widget build(BuildContext context) {
    /*
     * method to build whole screen
     * 
     * @params BuildContext
     * @return Widget
     */

    return Scaffold(
      appBar: appBar(context),
      body: buildBody(),
    );
  }

  AppBar appBar(BuildContext context) {
    /*
     * helper method to build app bar
     * 
     * @return AppBar
     */

    return AppBar(
      title: Text("Edit Expense " + _expense.title),
      centerTitle: true,
      actions: <Widget>[
        _submitButton(context),
      ],
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

  Widget buildBody() {
    /*
     * helper method to build scaffold's body
     * 
     * @return Widget
     */

    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          textFieldsTheme(_titleField()),
          textFieldsTheme(_amountField()),
          textFieldsTheme(_descriptionsField()),
          _bankAccountField(),
        ],
      ),
    );
  }

  Widget _titleField() {
    /*
     * helper method to build title text field
     * 
     * @return Widget
     */

    _titleFieldController..text = _expense.title;

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

  Widget _amountField() {
    /*
     * helper method to build amount text field
     * 
     * @return Widget
     */

    _amountFieldController..text = _expense.amount.toString();

    return Card(
        margin: EdgeInsets.all(10),
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Color(0XFF406B96),
        child: TextField(
          // limit text field to only accept digits
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly
          ],
          controller: _amountFieldController,
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

  Widget _descriptionsField() {
    /*
     * helper method to build descriptions text field
     * 
     * @return Widget
     */

    _descriptionsFieldController..text = _expense.descriptions;

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
            hintText: "Enter Descriptions here",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ));
  }

  Widget _bankAccountField() {
    /*
     * helper method to build accounts field dropdown widget
     * 
     * @return Widget
     */

    _bankAccountFieldController..text = _expense.accountId.toString();

    return Card(
      margin: EdgeInsets.all(10),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Color(0XFF406B96),
      child: BankAccountDropdown(
        (value) => _bankAccountFieldController..text = value,
        currentValue: _bankAccountFieldController.text,
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    /*
     * helper method to build submit button 
     * placed into scaffold actions
     * 
     * @return Widget
     */

    return IconButton(
      icon: Icon(
        Icons.done,
        color: Colors.white,
      ),

      onPressed: () {
        // update existing expense value with value of fields
        // and submit them to database
        _expense.title = _titleFieldController.text;
        _expense.amount = int.parse(_amountFieldController.text);
        _expense.descriptions = _descriptionsFieldController.text;
        _expense.accountId = int.parse(_bankAccountFieldController.text);
        bloc.updateExpense(_expense);

        Navigator.of(context).pop();
      },
    );
  }
}
