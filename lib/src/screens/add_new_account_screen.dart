import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meAccounting/src/blocs/accounts_bloc.dart';
import 'package:meAccounting/src/widgets/custom_text_field.dart';

class AddNewAccountScreen extends StatelessWidget {
  /**
   * Widget to show Add Account Screen
   * 
   */

  final bloc = AccountsBloc();

  // text controllers to control value of textfields
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final cardNumberController = TextEditingController();

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
          return CustomTextField(
            "Title",
            "Title",
            errorText: snapshot.hasError ? snapshot.error : null,
            controller: _titleController,
            onChanged: (value) => bloc.addTitle(value),
          );
        });
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
        return CustomTextField(
          "Amount",
          "How Much Do You Have in This Account Right Now?",
          errorText: snapshot.hasError ? snapshot.error : null,
          keyboardType: TextInputType.number,
          controller: _amountController,
          inputFormatters: <TextInputFormatter> [WhitelistingTextInputFormatter.digitsOnly],
          onChanged: (value) => bloc.addInitialAmount( int.parse(value) ),
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

    return StreamBuilder(
      stream: bloc.cardNumberStream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return CustomTextField(
          "Card Number",
          "Enter Your Card Number Here",
          errorText: snapshot.hasError ? snapshot.error : null,
          keyboardType: TextInputType.number,
          controller: _cardNumberController,
          inputFormatters: <TextInputFormatter> [WhitelistingTextInputFormatter.digitsOnly],
          onChanged: (value) => bloc.addCardNumber( int.parse(value) ),
        );
      }
    );
  }

  Widget submitButton(BuildContext context) {
    /**
     * button to submit user changes and add them to database
     * @params BuildContext
     * @return Widget
     */

    return StreamBuilder(
        stream: bloc.submitValid,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return IconButton(
            icon: Icon(Icons.done,
                color: snapshot.hasData ? Colors.white : Colors.white60),
            onPressed: snapshot.hasData
                ? () {
                    bloc.addAccountToDB();
                    Navigator.of(context).pop();
                  }
                : null,
          );
        });
  }
}
