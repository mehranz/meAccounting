import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meAccounting/src/blocs/accounts_bloc.dart';
import 'package:meAccounting/src/widgets/custom_text_field.dart';

class AddNewAccountScreen extends StatelessWidget {
  /*
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

    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Account"),
        centerTitle: true,
        actions: <Widget>[
          submitButton(context, bloc.addAccountToDB),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(children: <Widget>[
          titleField(titleController),
          initialAmountField(amountController),
          cardNumberField(cardNumberController),
        ]),
      ),
    );
  }

  Widget titleField(TextEditingController controller) {
    /**
     * title field widget to get user's input for title element
     * @param TextEditingController
     * @return Widget
     */

    return StreamBuilder(
        stream: bloc.titleStream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (controller.text.isNotEmpty) bloc.addTitle(controller.text);

          return CustomTextField(
            "Title",
            "Title",
            errorText: snapshot.hasError ? snapshot.error : null,
            controller: controller,
            onChanged: (value) => bloc.addTitle(value),
          );
        });
  }

  Widget initialAmountField(TextEditingController controller) {
    /**
     * initial amount field widget to get user's input for initial amount element
     * @param TextEditingController
     * @return Widget
     */

    return StreamBuilder(
      stream: bloc.initialAmountStream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (controller.text.isNotEmpty)
          bloc.addInitialAmount(int.parse(controller.text));

        return CustomTextField(
          "Amount",
          "How Much Do You Have in This Account Right Now?",
          errorText: snapshot.hasError ? snapshot.error : null,
          keyboardType: TextInputType.number,
          controller: controller,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly
          ],
          onChanged: (value) => bloc.addInitialAmount(int.parse(value)),
        );
      },
    );
  }

  Widget cardNumberField(TextEditingController controller) {
    /**
     * card number field widget to get user's input for card number element
     * @param TextEditingController
     * @return Widget
     */

    return StreamBuilder(
        stream: bloc.cardNumberStream,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (controller.text.isNotEmpty)
            bloc.addCardNumber(int.parse(controller.text));

          return CustomTextField(
            "Card Number",
            "Enter Your Card Number Here",
            errorText: snapshot.hasError ? snapshot.error : null,
            keyboardType: TextInputType.number,
            controller: controller,
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ],
            onChanged: (value) => bloc.addCardNumber(int.parse(value)),
          );
        });
  }

  Widget submitButton(BuildContext context, Function submit) {
    /**
     * button to submit user changes
     * 
     * @param BuildContext
     * @param Function
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
                    submit();
                    Navigator.of(context).pop();
                  }
                : null,
          );
        });
  }
}
