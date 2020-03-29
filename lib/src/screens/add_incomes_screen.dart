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
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController _accountIdController = TextEditingController();
  final TextEditingController descriptionsController = TextEditingController();

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
        submitButton(context, bloc.submitToDB),
      ],
    );
  }

  Widget submitButton(BuildContext context, Function submit) {
    return StreamBuilder(
      stream: bloc.validateSubmit,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return IconButton(
          icon: Icon(
            Icons.done,
            color: snapshot.hasData ? Colors.white : Colors.white54,
          ),
          onPressed: snapshot.hasData
              ? () {
                  submit();
            Navigator.of(context).pop();
                }
              : null,
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
          titleField(titleController),
          amountField(amountController),
          descriptionsField(descriptionsController),
          accountIdField(),
        ]));
  }

  Widget titleField(TextEditingController controller) {
    /*
     * method to create title field and get user's input
     * and push it to stream.
     * 
     * @return Widget
     */

    // if controller has value, add it to related stream
    if (titleController.text.isNotEmpty) bloc.addTitle(titleController.text);

    return StreamBuilder(
        stream: bloc.title,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return CustomTextField(
            "Title",
            "Enter Your Title Here",
            errorText: snapshot.hasError ? snapshot.error : null,
            controller: controller,
            onChanged: (value) => bloc.addTitle(value),
          );
        });
  }

  Widget amountField(TextEditingController controller) {
    /*
     * method to create amount field and get user's input
     * and push it to stream.
     * 
     * @return Widget
     */

    // if controller has value, add it to related stream
    if (amountController.text.isNotEmpty) bloc.addAmount( int.parse(amountController.text) );

    return StreamBuilder(
        stream: bloc.amount,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return CustomTextField(
            "Amount",
            "Enter Amount Here",
            errorText: snapshot.hasError ? snapshot.error : null,
            controller: controller,
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

  Widget descriptionsField(TextEditingController controller) {
    /*
     * method to create descriptions field and get user's input 
     * and push it to stream.
     * 
     * @return Widget
     */

    // if controller has value, add it to related stream
    if (descriptionsController.text.isNotEmpty) bloc.addDescriptions(descriptionsController.text);
    
    return StreamBuilder(
      stream: bloc.descriptions,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return CustomTextField(
          "Descriptions",
          "Enter Descriptions of Income",
          errorText: snapshot.hasError ? snapshot.error : null,
          controller: controller,
          onChanged: (value) => bloc.addDescriptions(value),
        );
      },
    );
  }
}
