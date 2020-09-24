import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meAccounting/src/blocs/wishlist_bloc.dart';
import 'package:meAccounting/src/widgets/custom_text_field.dart';

class AddWishListScreen extends StatelessWidget {
  final bloc = WishListBloc();

  final TextEditingController titleFieldController = TextEditingController();
  final TextEditingController amountFieldController = TextEditingController();
  final TextEditingController descriptionsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            textFieldsTheme(titleField(titleFieldController)),
            textFieldsTheme(amountField(amountFieldController)),
            textFieldsTheme(descriptionsField(descriptionsController)),
          ],
        ),
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return AppBar(
      title: Text("Add New Wish"),
      centerTitle: true,
      actions: <Widget>[submitButton(context, bloc.submitToDB)],
    );
  }

  Widget textFieldsTheme(Widget textField) {
    return Theme(
      child: textField,
      data: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.white,
        hintColor: Colors.white54,
        textSelectionColor: Colors.white
      ),
    );
  }

  Widget titleField(TextEditingController controller) {
    if (controller.text.isNotEmpty) bloc.addTitle(controller.text);

    return StreamBuilder(
      stream: bloc.titleStream,

      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return CustomTextField(
          "Title", "Enter Title Here",
          errorText: snapshot.hasError ? snapshot.error : null,
          controller: controller,
          onChanged: (value) {bloc.addTitle(value);},
        );
      },
    );
  }

  Widget amountField(TextEditingController controller) {
    if (controller.text.isNotEmpty) bloc.addAmount(int.parse(controller.text));

    return StreamBuilder(
      stream: bloc.amountStream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return CustomTextField(
          "Amount", "Enter Amount Here",
          errorText: snapshot.hasError ? snapshot.error : null,
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly
          ],
          onChanged: (value) => bloc.addAmount(int.parse(value)),
        );
      },
    );
  }

  Widget descriptionsField(TextEditingController controller) {
    if (controller.text.isNotEmpty) bloc.addDescriptions(controller.text);

    return StreamBuilder(
      stream: bloc.descriptionsStream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return CustomTextField(
          "Descriptions",
          "Enter Descriptions Here",
          errorText: snapshot.hasError ? snapshot.error : null,
          controller: controller,
          onChanged: (value) => bloc.addDescriptions(value),
        );
      },
    );
  }

  Widget submitButton(BuildContext context, Function submit) {
    return StreamBuilder(
      stream: bloc.validSubmit,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return IconButton(
          onPressed: snapshot.hasData ? () {
            submit();
            Navigator.of(context).pop();
          } : null,
          icon: Icon(Icons.done, color: snapshot.hasData ? Colors.white : Colors.white60,),
        );
      },
    );
  }
}