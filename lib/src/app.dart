import 'package:flutter/material.dart';
import 'package:meAccounting/src/blocs/accounts_provider.dart';
import 'package:meAccounting/src/blocs/expenses_provider.dart';
import 'package:meAccounting/src/blocs/incomes_provider.dart';
import 'package:meAccounting/src/screens/summary_screen.dart';

class App extends StatelessWidget {
  /*
   * App Class To provide main widget of app 
   */

  @override
  Widget build(BuildContext context) {
    /*
     * build method of app widget to get together whole app
     */

    return _blocs(MaterialApp(
      title: "MeAccouting",
      theme: ThemeData(
          primaryColor: Color(0XFF18222C),
          scaffoldBackgroundColor: Color(0XFF20303F)),
      home: SummaryScreen(),
    ));
  }

  Widget _blocs(Widget child) {
    /**
     * method to wrap widgets with all providers in app
     *
     * @param Widget
     * @return Widget
     */
    return AccountsProvider(
      child: ExpensesProvider(
        child: IncomesProvider(
          child: child,
        ),
      ),
    );
  }
}
