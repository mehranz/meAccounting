import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("MeAccounting!"),
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
    );
  }
}
