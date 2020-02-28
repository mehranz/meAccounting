import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meaccountingfinal/src/blocs/accounts_bloc.dart';
import 'package:meaccountingfinal/src/models/account_model.dart';

class EditAccountScreen extends StatelessWidget {

  /*
   * Widget to hold edit account screen
   * @consts AccountModel
   */

  // get account in order to edit it
  final AccountModel _account;
  EditAccountScreen(this._account);

  final bloc = AccountsBloc();

  // text controllers to set and get value of textfields
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
        title: Row(
          children: <Widget>[
            Icon(
              Icons.edit,
              color: Colors.black,
            ),
            SizedBox(
              width: 10,
            ),
            Text("Editing " + _account.title),
          ],
        ),
        centerTitle: true,
        actions: <Widget>[submitButton(context)],
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(children: <Widget>[
          titleField(),
          SizedBox(
            height: 20,
          ),
          initialAmountField(),
          SizedBox(
            height: 20,
          ),
          cardNumberField(),
        ]),
      ),
    );
  }

  Widget titleField() {
    /**
     * title field widget to get user's input for title element
     * @params
     * @return Widget
     */
    
    // assign old account title value to text field
    _titleController..text = _account.title;

    return StreamBuilder(
      stream: bloc.titleStream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return TextField(
          controller: _titleController,
          onChanged: (value) => bloc.addTitle(value),
          decoration: InputDecoration(
            labelText: "Title",
            hintText: "Title",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            errorText: snapshot.hasError ? snapshot.error : null,
          ),
        );
      },
    );
  }

  Widget initialAmountField() {
    /**
     * initial amount field widget to get user's input for initial amount element
     * @params
     * @return Widget
     */

    // assign old account initial amount value to text field
    _amountController..text = _account.initalAmount.toString();

    return StreamBuilder(
      stream: bloc.initialAmountStream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return TextField(
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly // make text field to only accept digits
          ],
          onChanged: (value) => bloc.addInitialAmount(int.parse(value)),
          controller: _amountController,
          decoration: InputDecoration(
            labelText: "Initial Amount",
            hintText: "how much you have in that account right now?",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            errorText: snapshot.hasError ? snapshot.error : null,
          ),
          keyboardType: TextInputType.number,
        );
      },
    );
  }

  Widget cardNumberField() {
    /**
     * card number field widget to get user's input for card number element
     * @params
     * @return Widget
     */

    // assign old account card number value to text field
    _cardNumberController..text = _account.cardNumber.toString();

    return StreamBuilder(
      stream: bloc.cardNumberStream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return TextField(
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly // make text field to only accept digits
          ],
          onChanged: (value) => bloc.addCardNumber(int.parse(value)),
          controller: _cardNumberController,
          decoration: InputDecoration(
              labelText: "Card Number",
              hintText: "Enter Your Card number",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              errorText: snapshot.hasError ? snapshot.error : null),
          keyboardType: TextInputType.number,
        );
      },
    );
  }

  Widget submitButton(BuildContext context) {
    /**
     * button to submit user changes and update them in database
     * @params BuildContext
     * @return Widget
     */

    return IconButton(
      icon: Icon(Icons.done),
      
      // TODO: make submission just when all streams have data
      onPressed: () {
        // change account object's properties to what user entered
        // and update it to database
        _account.title = _titleController.text;
        _account.initalAmount = int.parse(_amountController.text);
        _account.cardNumber = int.parse(_cardNumberController.text);

        bloc.updateAccount(_account);

        // get user back after changes submitted
        Navigator.of(context).pop();
      },
    );
  }
}
