import 'package:flutter/material.dart';
import 'package:meAccounting/src/blocs/incomes_bloc.dart';

class IncomesProvider extends InheritedWidget {
  /*
   * Incomes Bloc Provider Class
   * 
   */

  final IncomesBloc bloc;

  IncomesProvider({Key key, Widget child})
  : bloc = IncomesBloc(),
    super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static IncomesBloc of (BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<IncomesProvider>().bloc;
  }
}