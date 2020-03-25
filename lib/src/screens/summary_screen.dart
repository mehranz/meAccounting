import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:meAccounting/src/blocs/accounts_bloc.dart';
import 'package:meAccounting/src/blocs/expenses_bloc.dart';
import 'package:meAccounting/src/blocs/incomes_bloc.dart';
import 'package:meAccounting/src/screens/accounts_screen.dart';
import 'package:meAccounting/src/screens/expenses_screen.dart';
import 'package:meAccounting/src/screens/incomes_screen.dart';

class SummaryScreen extends StatelessWidget {
  /*
   * Home Screen Widget to build HomeScreen of app!
   */

  // TODO: probably it's better to make a bloc just for this screen
  final expenseBloc = ExpensesBloc();
  final accountsBloc = AccountsBloc();
  final incomesBloc = IncomesBloc();

  @override
  Widget build(BuildContext context) {
    /*
    * scaffold of home screen in order to hold home screen elements
    * @params BuildContext
    * @return Widget
    */

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
            FlatButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => ExpensesScreen()));
              },
              icon: Icon(
                Icons.attach_money,
                color: Colors.white,
                size: 35,
              ),
              // color: Colors.greenAccent,
              label: Text(
                "Expenses",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              padding: EdgeInsets.all(50),
            ),
            FlatButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => AccountsScreen()));
              },
              icon: Icon(
                Icons.account_balance,
                color: Colors.white,
                size: 35,
              ),
              // color: Colors.greenAccent,
              label: Text(
                "Accounts",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              padding: EdgeInsets.all(50),
            ),
            FlatButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => IncomesScreen()));
              },
              icon: Icon(
                Icons.call_received,
                color: Colors.white,
                size: 35,
              ),
              // color: Colors.greenAccent,
              label: Text(
                "Incomes",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              padding: EdgeInsets.all(50),
            ),
          ],
        ),
      )),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            StreamBuilder(
                stream: expenseBloc.totalExpenseOfDay,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  if (snapshot.hasData)
                    return createCard(
                        "Today Expenses",
                        _formattedMoneyValue(snapshot.data.toDouble())
                            .symbolOnRight);
                  else
                    return CircularProgressIndicator();
                }),

            StreamBuilder(
                stream: incomesBloc.incomesOfToday,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  if (snapshot.hasData)
                    return createCard(
                        "Today Incomes",
                        _formattedMoneyValue(snapshot.data.toDouble())
                            .symbolOnRight);
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

  Widget createCard(String title, String cardValue) {
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
                  child: Text(cardValue,
                      style: TextStyle(color: Colors.white, fontSize: 24.0)),
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
}
