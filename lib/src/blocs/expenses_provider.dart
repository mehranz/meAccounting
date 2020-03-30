import 'package:flutter/material.dart';
import './expenses_bloc.dart';
export './expenses_bloc.dart';

class ExpensesProvider extends InheritedWidget {
  /*
   * expenses bloc provider class
   * 
   */

  final ExpensesBloc bloc;

  ExpensesProvider({Key key, Widget child})
  : bloc = ExpensesBloc(),
    super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static ExpensesBloc of (BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ExpensesProvider>().bloc;
  }
}