import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:meAccounting/src/blocs/incomes_bloc.dart';
import 'package:meAccounting/src/blocs/incomes_provider.dart';
import 'package:meAccounting/src/models/income_model.dart';
import 'package:meAccounting/src/screens/add_incomes_screen.dart';
import 'package:meAccounting/src/screens/edit_income_screen.dart';

class IncomesScreen extends StatelessWidget {
  /*
   * class to create incomes screen and hold all elements of screen
   */

  @override
  Widget build(BuildContext context) {
    /*
     * method to build whole elments of incomes screen
     * 
     * @params BuildContext
     * @return Widget
     */

    final IncomesBloc bloc = IncomesProvider.of(context);
    bloc.getAllIncomes();

    // visual scaffold with body includes all incomes listview
    return Scaffold(
      appBar: appBar(),
      floatingActionButton: addNewIncomeFloatingButton(context),
      body: incomesListView(bloc),
    );
  }

  AppBar appBar() {
    /*
     * helper method to create material design App Bar for screen
     * 
     * @return AppBar
     */

    return AppBar(
      title: Text("Incomes"),
      centerTitle: true,
    );
  }

  FloatingActionButton addNewIncomeFloatingButton(BuildContext context) {
    /*
     * helper method to create add income floating action button
     * 
     * @return FloatingActionButton
     */
    return FloatingActionButton(
      onPressed: () {
        /**
         * method to navigate to new incomes screen when floating action button pressed
         */
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddIncomeScreen()));
      },
      child: Icon(Icons.add),
    );
  }

  Widget incomesListView(IncomesBloc bloc) {
    /*
     * method to create stream builder in order to read from expenses stream
     * and show all expenses comes from repository sources (database here)
     * 
     * @return Widget
     */

    return StreamBuilder(
      stream: bloc.incomes,
      builder:
          (BuildContext context, AsyncSnapshot<List<IncomeModel>> snapshot) {
        if (snapshot.hasData) {
          return RefreshIndicator(
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                // create alias variables in order to access easily to expense model
                // and created_at datetime field
                final IncomeModel _income = snapshot.data[index];
                final DateTime _created_at = DateTime.parse(_income.created_at);

                // Money Formatter Object in order to format amount
                // to a more human readable style
                final FlutterMoneyFormatter _moneyFormatter =
                    FlutterMoneyFormatter(
                  amount: _income.amount.toDouble(),
                  settings: MoneyFormatterSettings(
                    symbol: 'T',
                    fractionDigits: 0,
                  ),
                );

                return Dismissible(
                  key: Key(_income.title),
                  child: Container(
                      child: Card(
                    elevation: 10,
                    child: ListTile(
                      onTap: () {
                        // navigate to edit income screen with tapped income item
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return EditIncomeScreen(_income);
                        }));
                      },
                      title: Text(_income.title,
                          style: TextStyle(color: Colors.white)),
                      subtitle: Row(children: [
                        Icon(Icons.account_balance,
                            size: 16, color: Colors.white),
                        SizedBox(
                          width: 10,
                        ),
                        Text(_income.accountTitle,
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
                      trailing: Text(_moneyFormatter.output.symbolOnRight,
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
                    bloc.deleteIncome(_income);
                  },
                );
              },
            ),
            onRefresh: () => bloc.getAllIncomes(),
          );
        }
        // show CircularProgressIndicator if stream haven't data (data doesn't loaded yet or not exists at all)
        return CircularProgressIndicator();
      },
    );
  }
}
