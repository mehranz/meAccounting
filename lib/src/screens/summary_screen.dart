import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:meAccounting/src/blocs/accounts_bloc.dart';
import 'package:meAccounting/src/blocs/accounts_provider.dart';
import 'package:meAccounting/src/blocs/expenses_bloc.dart';
import 'package:meAccounting/src/blocs/expenses_provider.dart';
import 'package:meAccounting/src/blocs/incomes_bloc.dart';
import 'package:meAccounting/src/blocs/incomes_provider.dart';
import 'package:meAccounting/src/screens/accounts_screen.dart';
import 'package:meAccounting/src/screens/expenses_screen.dart';
import 'package:meAccounting/src/screens/incomes_screen.dart';

class SummaryScreen extends StatelessWidget {
  /*
   * Home Screen Widget to build HomeScreen of app!
   */

  // TODO: probably it's better to make a bloc just for this screen

  @override
  Widget build(BuildContext context) {
    /*
    * scaffold of home screen in order to hold home screen elements
    * @params BuildContext
    * @return Widget
    */

    final ExpensesBloc expenseBloc = ExpensesProvider.of(context);
    final AccountsBloc accountsBloc = AccountsProvider.of(context);
    final IncomesBloc incomesBloc = IncomesProvider.of(context);
    expenseBloc.getTotalExpensesOfToday();
    accountsBloc.getTotalBankAmount();
    incomesBloc.getIncomesOfToday();

    // TODO: Create Some Helper Methods to make code clean
    return Scaffold(
      appBar: AppBar(
        title: Text("Summary"),
        centerTitle: true,
      ),
      drawer: Drawer(
          child: Container(
        color: Color(0XFF20303F),
        child: ListView(
          children: <Widget>[
            _drawerItem(context, "Accounts", Icons.account_balance, AccountsScreen()),
            _drawerItem(context, "Expenses", Icons.attach_money, ExpensesScreen()),
            _drawerItem(context, "Incomes", Icons.call_received, IncomesScreen()),
          ],
        ),
      )),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            StreamBuilder(
                stream: expenseBloc.totalExpenseOfDay,
                builder:
                    (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
                  if (snapshot.hasData)
                    return createCard(
                        "Today Expenses",
                        _formattedMoneyValue(snapshot.data[0].toDouble())
                            .symbolOnRight,
                        arrowIcon: Icon(
                          snapshot.data[0] >= snapshot.data[1]
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: Colors.white,
                        ));
                  else
                    return CircularProgressIndicator();
                }),
            StreamBuilder(
                stream: incomesBloc.incomesOfToday,
                builder:
                    (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
                  if (snapshot.hasData)
                    return createCard(
                        "Today Incomes",
                        _formattedMoneyValue(snapshot.data[0].toDouble())
                            .symbolOnRight,
                        arrowIcon: Icon(
                          snapshot.data[0] >= snapshot.data[1]
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: Colors.white,
                        ));
                  else
                    return CircularProgressIndicator();
                }),
            StreamBuilder(
                stream: accountsBloc.totalBankAmount,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  if (snapshot.hasData)
                    return createCard(
                        "Total Balance",
                        _formattedMoneyValue(snapshot.data.toDouble())
                            .symbolOnRight);
                  else
                    return CircularProgressIndicator();
                }),
          ],
        ),
      ),
    );
  }

  Widget createCard(String title, String cardValue, {Icon arrowIcon}) {
    /**
     * Widget to hold cards of Summary (Home) screen.
     * this cards will hold information like today expenses, incomes and some other useful informations
     * @params String, String
     * @return String
     */
    return Card(
      margin: EdgeInsets.all(10.0),
      elevation: 10.0,
      color: Color(0XFF406B96),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Spacer(),
                      Text(
                        cardValue,
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      ),
                      Spacer(),
                      if (arrowIcon != null) arrowIcon,
                    ],
                  ),
                ),
              ),
              SizedBox(height: 35.0),
            ],
          )),
    );
  }

  MoneyFormatterOutput _formattedMoneyValue(double amount) {
    /*
     * method to format money value with 0 fractionDigits,
     * and 'T' symbol (Stands for Toman: Iran's currency)
     *
     * @params double
     * @return MoneyFormatterOutput
     */

    final FlutterMoneyFormatter _formatter = FlutterMoneyFormatter(
      amount: amount,
      settings: MoneyFormatterSettings(fractionDigits: 0, symbol: 'T'),
    );

    return _formatter.output;
  }

  Widget _drawerItem(BuildContext context, String label, IconData icon, Widget screen) {
    /**
     * helper method to create app drawer items
     *
     * @param BuildContext
     * @param String
     * @param IconData
     * @param Widget
     * @return Widget
     */
    return FlatButton.icon(
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => screen,
          ),
        );
      },
      icon: Icon(
        icon,
        color: Colors.white,
        size: 35,
      ),
      // color: Colors.greenAccent,
      label: Text(
        label,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
      padding: EdgeInsets.all(50),
    );
  }
}
