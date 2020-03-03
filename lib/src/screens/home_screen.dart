import 'package:flutter/material.dart';
import 'package:meaccountingfinal/src/blocs/accounts_bloc.dart';
import 'package:meaccountingfinal/src/blocs/expenses_bloc.dart';
import 'package:meaccountingfinal/src/screens/accounts_screen.dart';
import 'package:meaccountingfinal/src/screens/expenses_screen.dart';

class HomeScreen extends StatelessWidget {
  /*
   * Home Screen Widget to build HomeScreen of app!
   */

  // TODO: probably it's better to make a bloc just for this screen
  final expenseBloc = ExpensesBloc();
  final accountsBloc = AccountsBloc();

  @override
  Widget build(BuildContext context) {
    /*
    * scaffold of home screen in order to hold home screen elements
    * @params BuildContext
    * @return Widget
    */

    expenseBloc.getTotalExpensesOfToday();
    accountsBloc.getTotalBankAmount();

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
          ],
        ),
      )),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            StreamBuilder(
              stream: expenseBloc.totalExpenseOfDay,
              // TODO: check if snapshot has data and if it hasn't show a ProgressIndicator
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                return createCard(
                    "Today Expenses", snapshot.data.toString() + " T");
              },
            ),
            createCard("Today Incomes (Mock)", "950000T"),
            StreamBuilder(
                stream: accountsBloc.totalBankAmount,

                // TODO: check if snapshot has data and if it hasn't show a ProgressIndicator
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  return createCard(
                      "Total Balance", snapshot.data.toString() + " T");
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
}
