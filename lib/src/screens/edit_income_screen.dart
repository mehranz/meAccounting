import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meAccounting/src/blocs/incomes_bloc.dart';
import 'package:meAccounting/src/models/income_model.dart';
import 'package:meAccounting/src/widgets/bank_account_dropdown.dart';

class EditIncomeScreen extends StatelessWidget {
  /*
   * class to hold edit income screen elements
   * 
   * @param IncomeModel
   */

  // get income model that wanted to be edited [with constructor]
  final IncomeModel _income;

  final IncomesBloc bloc = IncomesBloc();

  // create a text editing controller for every field on the screen
  final TextEditingController _titleFieldController = TextEditingController();
  final TextEditingController _amountFieldController = TextEditingController();
  final TextEditingController _descriptionsFieldController =
      TextEditingController();
  final TextEditingController _accountIdFieldController =
      TextEditingController();

  // get income model that wanted to be edited
  EditIncomeScreen(this._income);

  @override
  Widget build(BuildContext context) {
    /*
     * method to build whole screen
     * 
     * @params BuildContext
     */

    return Scaffold(
      appBar: _appBar(context),
      body: _buildBody(),
    );
  }

  AppBar _appBar(BuildContext context) {
    /*
     * helper method to build screen's App Bar
     * 
     * @parmas BuildContext
     * @return AppBar
     */

    return AppBar(
      title: Text("Editing " + _income.title),
      centerTitle: true,
      actions: <Widget>[
        _submitButton(context),
      ],
    );
  }

  Widget _buildBody() {
    /*
     * helper method to build scaffold's body
     * 
     * @return Widget
     */

    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          _buildTitleField(),
          _buildAmountField(),
          _buildDescriptionsField(),
          _buildAccountDropdownField(),
        ],
      ),
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

  IconButton _submitButton(BuildContext context) {
    /*
     * helper method to build submit button
     * placed on app bar's actions
     * 
     * @params BuildContext
     * @return IconButton
     */

    return IconButton(
      icon: Icon(
        Icons.done,
        color: Colors.white,
      ),
      onPressed: () {
        // edit current income model with value of fields
        // and submit to database
        _income.title = _titleFieldController.text;
        _income.amount = int.parse(_amountFieldController.text);
        _income.descriptions = _descriptionsFieldController.text;
        _income.account_id = int.parse(_accountIdFieldController.text);
        bloc.updateIncome(_income);

        Navigator.of(context).pop();
      },
    );
  }

  Widget _buildTitleField() {
    /*
     * helper method to build title text field
     * 
     * @return Widget
     */

    // put previous value of currnet income's title inside text field
    _titleFieldController..text = _income.title;

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
                    controller: _titleFieldController,
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

  Widget _buildAmountField() {
    /*
     * helper method to build amount text field
     * 
     * @return Widget
     */

    // put previous value of currnet income's amount inside text field
    _amountFieldController..text = _income.amount.toString();

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
                    controller: _amountFieldController,
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

  Widget _buildDescriptionsField() {
    /*
     * helper method to build descriptions text field
     * 
     * @return Widget
     */

    // put previous value of currnet income's descriptions inside text field
    _descriptionsFieldController..text = _income.descriptions;

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
                    controller: _descriptionsFieldController,
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

  Widget _buildAccountDropdownField() {
    /*
     * helper method to create Accounts Dropdown selection
     * 
     * @return Widget
     */

    // put previous value of currnet income's account id inside Account id field controller
    _accountIdFieldController..text = _income.account_id.toString();

    return Card(
      margin: EdgeInsets.only(left: 10, right: 10),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Color(0XFF406B96),
      child: BankAccountDropdown(
          (value) => _accountIdFieldController..text = value,
          currentValue: _accountIdFieldController.text),
    );
  }
}
