import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meaccountingfinal/src/blocs/accounts_bloc.dart';
import 'package:meaccountingfinal/src/models/account_model.dart';

class AddNewAccountScreen extends StatelessWidget {
  /**
   * Widget to show Add Account Screen
   * 
   */

  final bloc = AccountsBloc();

  // text controllers to get value of textfields
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _cardNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /**
     * Scaffold of Edit Account screen in order to hold screen's elements
     * @parmas BuildContext
     * @return Widget
     */

    // TODO: create helper methods to make code clean
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Account"),
        centerTitle: true,
        actions: <Widget>[submitButton(context)],
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(children: <Widget>[
          titleField(),
          initialAmountField(),
          cardNumberField(),
        ]),
      ),
    );
  }

  Widget textFieldsTheme(Widget textField, {Color primaryColor}) {
    return Theme(
      child: textField,
      data: ThemeData(
          primaryColor: primaryColor,
          accentColor: Colors.white,
          hintColor: Colors.white54,
          textSelectionColor: Colors.white),
    );
  }

  Widget titleField() {
    /**
     * title field widget to get user's input for title element
     * @params
     * @return Widget
     */

    return StreamBuilder(
      stream: bloc.titleStream,
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

  Widget initialAmountField() {
    /**
     * initial amount field widget to get user's input for initial amount element
     * @params
     * @return Widget
     */

    return StreamBuilder(
      stream: bloc.initialAmountStream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return Column(children: [
          textFieldsTheme(
              Card(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Color(0XFF406B96),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter
                          .digitsOnly // make text field to only accept digits
                    ],
                    onChanged: (value) =>
                        bloc.addInitialAmount(int.parse(value)),
                    controller: _amountController,
                    decoration: InputDecoration(
                      labelText: "Initial Amount",
                      hintText: "how much you have in that account right now?",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  )),
              primaryColor: snapshot.hasError ? Colors.red : Colors.white),
          // Container for error text to avoid show errors inside card
          Container(
              // height: 10,
              alignment: Alignment.bottomLeft,
              // padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 2, left: 20, bottom: 10),
              child: snapshot.hasError
                  ? Text(
                      snapshot.error,
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.right,
                    )
                  : SizedBox()),
        ]);
      },
    );
  }

  Widget cardNumberField() {
    /**
     * card number field widget to get user's input for card number element
     * @params
     * @return Widget
     */

    return StreamBuilder(
      stream: bloc.cardNumberStream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return Column(children: [
          textFieldsTheme(
              Card(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Color(0XFF406B96),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    onChanged: (value) => bloc.addCardNumber(int.parse(value)),
                    controller: _cardNumberController,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter
                          .digitsOnly // make text field to only accept digits
                    ],
                    decoration: InputDecoration(
                      labelText: "Card Number",
                      hintText: "Enter Your Card number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  )),
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
                  : SizedBox()),
        ]);
      },
    );
  }

  Widget submitButton(BuildContext context) {
    /**
     * button to submit user changes and add them to database
     * @params BuildContext
     * @return Widget
     */

    return IconButton(
      icon: Icon(Icons.done),

      // TODO: make submission just when all streams have data
      onPressed: () {
        // create a new AccountModel with data user inserted on textfields
        // in order to add it to database
        var account = AccountModel(
          title: _titleController.text,
          initalAmount: int.parse(_amountController.text),
          cardNumber: int.parse(_cardNumberController.text),
        );
        bloc.addAccountToDB(account);

        // get user back after changes submitted
        Navigator.of(context).pop();
      },
    );
  }
}
