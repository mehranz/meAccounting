import 'package:flutter/material.dart';
import 'package:meaccountingfinal/src/screens/accounts_screen.dart';
import 'package:meaccountingfinal/src/screens/expenses_screen.dart';

class HomeScreen extends StatelessWidget {
  /*
   * Home Screen Widget to build HomeScreen of app!
   */

  @override
  Widget build(BuildContext context) {
    /*
    * scaffold of home screen in order to hold home screen elements
    * @params BuildContext
    * @return Widget
    */

    // TODO: Create Some Helper Methods to make code clean
    // TODO: Add Logic to this section instead of just showing mock data
    return Scaffold(
      appBar: AppBar(
        title: Text("Summary"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (ctx) => ExpensesScreen()));
                },
                icon: Icon(
                  Icons.attach_money,
                  color: Colors.greenAccent,
                  size: 35,
                ),
                // color: Colors.greenAccent,
                label: Text("Expenses",
                style: TextStyle(fontSize: 20),),
                padding: EdgeInsets.all(50),
                ),

                FlatButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (ctx) => AccountsScreen()));
                },
                icon: Icon(
                  Icons.account_balance,
                  color: Colors.greenAccent,
                  size: 35,
                ),
                // color: Colors.greenAccent,
                label: Text("Accounts",
                style: TextStyle(fontSize: 20),),
                padding: EdgeInsets.all(50),
                ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            createCard("Today Expenses", "730,000T"),
            createCard("Today Incomes", "950,000T"),
            createCard("Your bank amount", "24,670,000T"),
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
      elevation: 1.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50.0))),
      child: Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(
                  colors: [Colors.greenAccent, Colors.greenAccent])),
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(cardValue,
                      style: TextStyle(color: Colors.black54, fontSize: 24.0)),
                ),
              ),
              SizedBox(height: 35.0),
            ],
          )),
    );
  }
}
