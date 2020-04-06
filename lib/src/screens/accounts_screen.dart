import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:meAccounting/src/blocs/accounts_bloc.dart';
import 'package:meAccounting/src/blocs/accounts_provider.dart';
import 'package:meAccounting/src/models/account_model.dart';
import 'package:meAccounting/src/screens/add_new_account_screen.dart';
import 'package:meAccounting/src/screens/edit_account_screen.dart';

class AccountsScreen extends StatelessWidget {
  /*
   * Widget to show Accounts Screen
   * 
   */

  // global key for pointing to state of scaffold
  // in order to show a SnackBar
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    /**
     * Build Scaffold to hold all elements of screen like Accounts List
     * @param BuildContext
     * @return Widget
     */

    final AccountsBloc bloc = AccountsProvider.of(context);
    bloc.getAllAccounts();

    return Scaffold(
      key: scaffoldKey,
      appBar: _appBar(),
      floatingActionButton: _floatingActionButton(context),
      body: _scaffoldBody(bloc, context),
    );
  }

  Widget _appBar() {
    /**
     * Helper method to build app bar of screen
     *
     * @return Widget
     */

    return AppBar(
      title: Text("Accounts"),
      centerTitle: true,
    );
  }

  Widget _floatingActionButton(BuildContext context) {
    /**
     * Helper method to build floating action button of screen
     *
     * @param BuildContext
     * @return Widget
     */

    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        // Navigate to add new Account Screen
        // when user clicked at floating action add button
        Navigator.push(context,
            MaterialPageRoute(builder: (ctx) => AddNewAccountScreen()));
      },
    );
  }

  Widget _scaffoldBody(AccountsBloc bloc, BuildContext context) {
    /**
     * Helper Method to build screen's scaffold Body
     *
     * @param AccountsBloc
     * @param BuildContext
     * @return Widget
     */

    return Container(
      margin: EdgeInsets.all(10),
      child: StreamBuilder(
        stream: bloc.accounts,
        builder:
            (BuildContext ctx, AsyncSnapshot<List<AccountModel>> snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext ctx, int index) {
                  AccountModel account = snapshot.data[index];

                  // Money Formatter Object in order to format amount
                  // to a more human readable style
                  final FlutterMoneyFormatter moneyFormatter =
                      FlutterMoneyFormatter(
                    amount: account.initalAmount.toDouble(),
                    settings:
                        MoneyFormatterSettings(fractionDigits: 0, symbol: 'T'),
                  );

                  return _buildListTile(context, bloc, account, moneyFormatter);
                },
              ),
              onRefresh: () async {
                return bloc.getAllAccounts();
              },
            );
          } else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildListTile(BuildContext context, AccountsBloc bloc,
      AccountModel account, FlutterMoneyFormatter moneyFormatter) {
    /**
     * Helper method to build a Dismissible ListTile for every account elements
     * comes from Stream
     *
     * @param BuildContext
     * @param AccountsBloc
     * @param AccountModel
     * @param FlutterMoneyFormatter
     * @return Widget
     */

    return Dismissible(
      key: Key(account.title),
      child: _buildCard(context, account, moneyFormatter),
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
        ], mainAxisAlignment: MainAxisAlignment.end),
      ),
      onDismissed: (direction) {
        bloc.deleteAccountFromDB(account.id);
        scaffoldKey.currentState.showSnackBar(
          new SnackBar(
            content:
                Text("Account " + account.title + " deleted successfully!"),
          ),
        );
      },
    );
  }

  Widget _buildCard(BuildContext context, AccountModel account,
      FlutterMoneyFormatter moneyFormatter) {
    /**
     * Helper Method to build a Card for each item of accounts screen
     *
     * @param BuildContext
     * @param AccountModel
     * @param FlutterMoneyFormatter
     * @return Widget
     */

    return Card(
      color: Color(0XFF406B96),
      child: ListTile(
        onTap: () {
          // navigate user to EditAccountScreen while passing tapped account model
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditAccountScreen(account),
            ),
          );
        },
        title: Text(
          account.title,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Row(
          children: <Widget>[
            Icon(
              Icons.credit_card,
              color: Colors.white,
              size: 16,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              account.cardNumber.toString(),
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        trailing: Text(
          moneyFormatter.output.symbolOnRight,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
