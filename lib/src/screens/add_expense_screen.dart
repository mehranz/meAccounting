import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meAccounting/src/blocs/expenses_bloc.dart';
import 'package:meAccounting/src/widgets/bank_account_dropdown.dart';
import 'package:meAccounting/src/widgets/custom_text_field.dart';

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
              accountsFieldDropdown(),
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

    return StreamBuilder(
      stream: bloc.validSubmit,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return IconButton(
          onPressed: snapshot.hasData
              ? () {
                  bloc.submitToDB();
                  Navigator.of(context).pop();
                }
              : null,
          icon: Icon(Icons.done,
              color: snapshot.hasData ? Colors.white : Colors.white60),
        );
      },
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

    return StreamBuilder(
        stream: bloc.titleStream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return CustomTextField("Title", "Enter Title Here",
              errorText: snapshot.hasError ? snapshot.error : null,
              controller: _titleFieldController,
              onChanged: (value) => bloc.addTitle(value));
        });
  }

  Widget amountField() {
    /*
     * method to create amount text field
     * 
     * @return Widget
     */

    return StreamBuilder(
      stream: bloc.amountStream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return CustomTextField(
          "Amount",
          "Enter Amount Here",
          errorText: snapshot.hasError ? snapshot.error : null,
          controller: _amountFieldController,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly
          ],
          onChanged: (value) => bloc.addAmount(int.parse(value)),
        );
      },
    );
  }

  Widget descriptionsField() {
    /*
     * method to create descriptions text field
     * 
     * @return Widget
     */

    return StreamBuilder(
        stream: bloc.descriptionsStream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return CustomTextField(
            "Descriptions",
            "Enter Descriptions Here",
            errorText: snapshot.hasError ? snapshot.error : null,
            controller: _descriptionsFieldController,
            onChanged: (value) => bloc.addDescriptions(value),
          );
        });
  }

  Widget accountsFieldDropdown() {
    /*
     * helper method to create accounts field dropdown widget
     * 
     * @return Widget
     */

    return Card(
      margin: EdgeInsets.all(10),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Color(0XFF406B96),
      child: BankAccountDropdown(
        (value) => bloc.addAccountId(int.parse(value))
      ),
    );
  }
}
