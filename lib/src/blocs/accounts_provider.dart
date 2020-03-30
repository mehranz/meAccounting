import 'package:flutter/material.dart';

import 'package:meAccounting/src/blocs/accounts_bloc.dart';

class AccountsProvider extends InheritedWidget {
  /*
   * accounts bloc provider class
   */

  final AccountsBloc bloc;

  AccountsProvider({Key key, Widget child})
  : bloc = AccountsBloc(),
    super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static AccountsBloc of (BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AccountsProvider>().bloc;
  }
}