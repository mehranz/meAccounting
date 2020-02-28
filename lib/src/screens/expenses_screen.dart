import 'package:flutter/material.dart';

class ExpensesScreen extends StatelessWidget {
  /**
   * Widget to hold expenses screen's elements
   * 
   * this file is to messy right now! and it don't have any logic and it's becaust it was just a perview of UI for now.
   * I'm going to clean it up and add Logic to it very soon.
   * 
   */

  // TODO: Create Helper Methods to make code clean
  // TODO: Add Logic to this section instead of just showing mock data
  @override
  Widget build(BuildContext context) {
    /**
     * Build Scaffold widget which contains all elements of this screen
     * @param BuildContext
     * @return Widget
     */
    return Scaffold(
      appBar: AppBar(
        title: Text("Expenses"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Dismissible(
              key: Key("First Expense"),
              child: ListTile(
                title: Text("First Expense"),
                subtitle: Text("Credit Card"),
                trailing: Text("310, 000 T"),
              ),
              background: Container(color:  Colors.red,
              child: Row(children: [SizedBox(width: 20,), Icon(Icons.delete),])),
              secondaryBackground: Container(color:  Colors.red,
              child: Row(children: [ Icon(Icons.delete), SizedBox(width: 20),], mainAxisAlignment: MainAxisAlignment.end)),
              
              onDismissed: (DismissDirection direction) {
                // delete item
              },
            ),

            Dismissible(
              key: Key("Second Expense"),
              child: ListTile(
                title: Text("Second Expense"),
                subtitle: Text("Credit Card"),
                trailing: Text("230, 000 T"),
              ),
              background: Container(color:  Colors.red,
              child: Row(children: [SizedBox(width: 20,), Icon(Icons.delete),])),
              secondaryBackground: Container(color:  Colors.red,
              child: Row(children: [ Icon(Icons.delete), SizedBox(width: 20),], mainAxisAlignment: MainAxisAlignment.end)),
              
              onDismissed: (DismissDirection direction) {
                // delete item
              },
            ),

            Dismissible(
              key: Key("Third Expense"),
              child: ListTile(
                title: Text("Third Expense"),
                subtitle: Text("Credit Card"),
                trailing: Text("80, 000 T"),
              ),
              background: Container(color:  Colors.red,
              child: Row(children: [SizedBox(width: 20,), Icon(Icons.delete),])),
              secondaryBackground: Container(color:  Colors.red,
              child: Row(children: [ Icon(Icons.delete), SizedBox(width: 20),], mainAxisAlignment: MainAxisAlignment.end)),
              
              onDismissed: (DismissDirection direction) {
                // delete item
              },
            ),

            Dismissible(
              key: Key("Forth Expense"),
              child: ListTile(
                title: Text("Forth Expense"),
                subtitle: Text("Credit Card"),
                trailing: Text("110, 000 T"),
              ),
              background: Container(color:  Colors.red,
              child: Row(children: [SizedBox(width: 20,), Icon(Icons.delete),])),
              secondaryBackground: Container(color:  Colors.red,
              child: Row(children: [ Icon(Icons.delete), SizedBox(width: 20),], mainAxisAlignment: MainAxisAlignment.end)),
              
              onDismissed: (DismissDirection direction) {
                // delete item
              },
            ),

            
          ],
        ),
      ),
    );
  }
}
