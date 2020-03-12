import 'package:flutter/material.dart';
import 'package:meAccounting/src/blocs/expenses_bloc.dart';
import 'package:meAccounting/src/models/expense_model.dart';
import 'package:meAccounting/src/screens/add_expense_screen.dart';

class ExpensesScreen extends StatelessWidget {
  final bloc = ExpensesBloc();
  /**
   * Widget to hold expenses screen's elements
   * 
   * this file is to messy right now! and it don't have any logic and it's becaust it was just a perview of UI for now.
   * I'm going to clean it up and add Logic to it very soon.
   * 
   */

  // TODO: Create Helper Methods for UI to make code clean
  @override
  Widget build(BuildContext context) {
    /*
     * Build Scaffold widget which contains all elements of this screen
     * @param BuildContext
     * @return Widget
     */
    return Scaffold(
      appBar: AppBar(
        title: Text("Expenses"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddNewExpensesScreen()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Container(
        child: createExpensesList(),
      ),
    );
  }

  Widget createExpensesList() {
    /*
     * method to create stream builder in order to read from expenses stream
     * and show all expenses comes from repository sources (database here)
     * 
     * @return Widget
     */

    bloc.getAllExpenses();
    return StreamBuilder(
      stream: bloc.expenses,
      builder:
          (BuildContext context, AsyncSnapshot<List<ExpenseModel>> snapshot) {
        if (snapshot.hasData) {
          return RefreshIndicator(
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                // create alias variables in order to access easily to expense model
                // and created_at datetime field
                final ExpenseModel _exp = snapshot.data[index];
                final DateTime _created_at = DateTime.parse(_exp.createdAt);

                return Dismissible(
                  key: Key(_exp.title),
                  child: Container(
                      child: Card(
                    elevation: 10,
                    child: ListTile(
                      title: Text(_exp.title,
                          style: TextStyle(color: Colors.white)),
                      subtitle: Row(children: [
                        Icon(Icons.account_balance,
                            size: 16, color: Colors.white),
                        SizedBox(
                          width: 10,
                        ),
                        Text(_exp.accountTitle,
                            style: TextStyle(color: Colors.white)),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          _created_at.year.toString() +
                              "-" +
                              _created_at.month.toString() +
                              "-" +
                              _created_at.day.toString() +
                              " " +
                              _created_at.hour.toString() +
                              ":" +
                              _created_at.minute.toString(),
                          style: TextStyle(color: Colors.white),
                        )
                      ]),
                      trailing: Text(_exp.amount.toString() + " T",
                          style: TextStyle(color: Colors.white)),
                    ),
                    color: Color(0XFF406B96),
                    margin: EdgeInsets.all(8),
                  )),
                  background: Container(
                      color: Colors.red,
                      child: Row(children: [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(Icons.delete),
                      ])),
                  secondaryBackground: Container(
                      color: Colors.red,
                      child: Row(children: [
                        Icon(Icons.delete),
                        SizedBox(width: 20),
                      ], mainAxisAlignment: MainAxisAlignment.end)),
                  onDismissed: (DismissDirection direction) {
                    bloc.deleteExpense(_exp);
                  },
                );
              },
            ),
            onRefresh: () => bloc.getAllExpenses(),
          );
        }
        // show CircularProgressIndicator if stream haven't data (data doesn't loaded yet or not exists at all)
        return CircularProgressIndicator();
      },
    );
  }
}
