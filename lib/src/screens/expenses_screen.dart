import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:meAccounting/src/blocs/expenses_bloc.dart';
import 'package:meAccounting/src/blocs/expenses_provider.dart';
import 'package:meAccounting/src/models/expense_model.dart';
import 'package:meAccounting/src/screens/add_expense_screen.dart';
import 'package:meAccounting/src/screens/edit_expense_screen.dart';

class ExpensesScreen extends StatelessWidget {
  /*
   * Widget to hold expenses screen's elements
   * 
   * this file is to messy right now! and it don't have any logic and it's becaust it was just a perview of UI for now.
   * I'm going to clean it up and add Logic to it very soon.
   * 
   */

  @override
  Widget build(BuildContext context) {
    /*
     * Build Scaffold widget which contains all elements of this screen
     * @param BuildContext
     * @return Widget
     */

    final ExpensesBloc bloc = ExpensesProvider.of(context);
    bloc.getAllExpenses();

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
      body: _buildScaffoldBody(bloc),
    );
  }

  Widget createExpensesList(ExpensesBloc bloc) {
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
            child: _buildListView(context, snapshot.data.length, snapshot.data,
                bloc.deleteExpense),
            onRefresh: () => bloc.getAllExpenses(),
          );
        }
        // show CircularProgressIndicator if stream haven't data (data doesn't loaded yet or not exists at all)
        return CircularProgressIndicator();
      },
    );
  }

  Widget _buildScaffoldBody(ExpensesBloc bloc) {
    return Container(
      child: createExpensesList(bloc),
    );
  }

  Widget _buildListView(BuildContext context, int length,
      List<ExpenseModel> expenses, Function(ExpenseModel) deleteFunction) {
    /**
     * Helper method to build list view in screen
     *
     * @param BuildContext
     * @param int
     * @param List<ExpenseModel>
     * @param Function(ExpenseModel)
     * @return Widget
     */

    return ListView.builder(
      itemCount: length,
      itemBuilder: (BuildContext context, int index) =>
          _buildCard(context, expenses[index], deleteFunction),
    );
  }

  Widget _buildCard(BuildContext context, ExpenseModel expense,
      Function(ExpenseModel) deleteFunction) {
    /**
     * Helper method to build elements inside list view
     *
     * @param BuildContext
     * @param ExpenseModel
     * @param Function(ExpenseModel)
     */

    final DateTime _created_at = DateTime.parse(expense.createdAt);
    return Dismissible(
      key: Key(expense.title),
      child: Container(
        child: Card(
          elevation: 10,
          child: ListTile(
            onTap: () {
              // navigate to edit expense screen with current expense
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return EditExpenseScreen(expense);
                }),
              );
            },
            title: Text(
              expense.title,
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.account_balance, size: 16, color: Colors.white),
                SizedBox(
                  width: 10,
                ),
                Text(
                  expense.accountTitle != null ? expense.accountTitle : "Deleted Account",
                  style: TextStyle(color: Colors.white),
                ),
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
                  _formatDate(_created_at),
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            trailing: Text(_getMoneyFormatter(expense),
                style: TextStyle(color: Colors.white)),
          ),
          color: Color(0XFF406B96),
          margin: EdgeInsets.all(8),
        ),
      ),
      background: Container(
        color: Colors.red,
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Icon(Icons.delete),
          ],
        ),
      ),
      secondaryBackground: Container(
          color: Colors.red,
          child: Row(children: [
            Icon(Icons.delete),
            SizedBox(width: 20),
          ], mainAxisAlignment: MainAxisAlignment.end)),
      onDismissed: (DismissDirection direction) {
        deleteFunction(expense);
      },
    );
  }

  String _getMoneyFormatter(ExpenseModel expense) {
    /**
     * Helper method to get Money Formatter Object in order to format amount
     * value to a more human readable style.
     *
     * @param ExpenseModel
     * @return String
     */
    FlutterMoneyFormatter _moneyFormatter = FlutterMoneyFormatter(
      amount: expense.amount.toDouble(),
      settings: MoneyFormatterSettings(
        symbol: 'T',
        fractionDigits: 0,
      ),
    );

    return _moneyFormatter.output.symbolOnRight;
  }

  String _formatDate(DateTime date) {
    /**
     * Helper method to convert date to YYYY/MM/DD HH:SS format string
     *
     * @param DateTime
     * @return String
     */

    String _formattedTime = date.year.toString() +
        "-" +
        date.month.toString() +
        "-" +
        date.day.toString() +
        " " +
        date.hour.toString() +
        ":" +
        date.minute.toString();
    return _formattedTime;
  }
}
