import 'package:flutter/material.dart';
import 'package:meAccounting/src/models/account_model.dart';
import 'package:meAccounting/src/res/repo.dart';

class BankAccountDropdown extends StatefulWidget {
  /*
   * Class to create state of Bank Account Dropdown widget 
   * 
   * @params Function(String)
   */

  // get onChanged CallBack function to handle data when
  // dropdown menu item changes
  final Function(String) _onchangedCallBack;

  // get current value of dropdown in in order to
  //show current account in edit screens
  final String currentValue;

  BankAccountDropdown(this._onchangedCallBack, {this.currentValue});

  @override
  _BankAccountWidgetState createState() =>
      _BankAccountWidgetState(_onchangedCallBack, currentValue);
}

class _BankAccountWidgetState extends State<BankAccountDropdown> {
  /*
   * class to hold Bank Account Dropdown Widget and 
   * change its state
   * 
   * @params Function(String)
   */

  // list of account models
  List<AccountModel> _accounts = <AccountModel>[];

  // current selected item
  String _currentDropdownMenuItem;

  // get onChanged Callback function in order to run
  // whenever dropdown item changed
  final Function(String) onChangedCallBack;

  // get current value of dropdown in in order to
  //show current account in edit screens
  final String _currentValue;
  _BankAccountWidgetState(this.onChangedCallBack, this._currentValue);

  @override
  void initState() {
    /*
     * method to initialize state of widget
     */

    super.initState();

    _currentDropdownMenuItem = _currentValue;

    // load all accounts from database
    _loadAccounts();
  }

  @override
  Widget build(BuildContext context) {
    /*
     * method to build Bank Account Dropdown Widget
     */

    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Theme.of(context).primaryColor,
      ),
      child: Container(
        margin: EdgeInsets.all(8),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white54,
            ),
            hint: Text(
              "Select Your Account",
              style: TextStyle(color: Colors.white54),
            ),
            onChanged: onChanged,
            value: _currentDropdownMenuItem,
            style: TextStyle(color: Colors.white),
            isExpanded: true,
            items: _accounts.map((AccountModel value) {
              return DropdownMenuItem<String>(
                value: value.id.toString(),
                child: Text(value.title),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  _loadAccounts() async {
    /*
     * method to get all Accounts from database
     */

    final loadAccounts = await Repo().getAllAccounts();

    setState(() {
      // assign loaded accounts to _accounts variable
      _accounts = loadAccounts;
    });
  }

  onChanged(String currentValue) {
    /*
     * onChanged function in order to change value of dropdown
     * when it's changed and then run given onChangeCallBack
     * 
     * @params String
     */

    setState(() {
      // assign current dropdown menu item to value selected
      _currentDropdownMenuItem = currentValue;
    });

    onChangedCallBack(currentValue);
  }
}
