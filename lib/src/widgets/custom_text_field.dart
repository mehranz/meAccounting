import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  
  final String label;
  final String hint;
  final String errorText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatters;

  final Function(String) onChanged;

  CustomTextField(
    this.label,
    this.hint,
    {this.errorText, this.keyboardType, this.controller, this.inputFormatters, this.onChanged}
  );


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

  @override
  Widget build(BuildContext context) {
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
                    inputFormatters: inputFormatters,
                    onChanged: onChanged,
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: label,
                      hintText: hint,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: keyboardType,
                  )),
              primaryColor: errorText != null ? Colors.red : Colors.white),
          // Container for error text to avoid show errors inside card
          Container(
              // height: 10,
              alignment: Alignment.bottomLeft,
              // padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 2, left: 20, bottom: 10),
              child: errorText != null
                  ? Text(
                      errorText,
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.right,
                    )
                  : SizedBox()),
        ]);
  }

}