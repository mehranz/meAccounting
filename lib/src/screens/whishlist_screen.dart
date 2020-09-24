import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meAccounting/src/blocs/wishlist_bloc.dart';
import 'package:meAccounting/src/blocs/wishlist_provider.dart';
import 'package:meAccounting/src/models/wishlist_model.dart';
import 'package:meAccounting/src/screens/add_new_account_screen.dart';
import 'package:meAccounting/src/screens/add_wishlist_screen.dart';

class WishListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final WishListBloc bloc = WishListProvider.of(context);
    bloc.getWishList();



    return Scaffold(
      appBar: AppBar(
        title: Text("Wish List"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddWishListScreen()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: _buildScaffoldBody(bloc),
    );
  }

  Widget createWishList(WishListBloc bloc) {
    return StreamBuilder(
      stream: bloc.wishListsStream,
      builder: (BuildContext context, AsyncSnapshot<List<WishListModel>> snapshot) {
        if (snapshot.hasData) {
          return RefreshIndicator(
            child: _buildListView(context, snapshot.data.length, snapshot.data, (WishListModel wishListModel) {
              bloc.bought(wishListModel);
            }),
            onRefresh: () => bloc.getWishList(),
          );
        }
        return CircularProgressIndicator();
    },
    );
  }

  Widget _buildScaffoldBody(WishListBloc bloc) {
    return Container(
      child: createWishList(bloc),
    );
  }

  Widget _buildListView(BuildContext context, int length, List<WishListModel> wishLists, Function(WishListModel) deleteFunction) {
    return ListView.builder(
        itemCount: length,
        itemBuilder: (BuildContext context, int index) => _buildCard(context, wishLists[index], deleteFunction),
    );
  }

  Widget _buildCard(BuildContext context, WishListModel wishList, Function(WishListModel) deleteFunction) {
    return Dismissible(
      key: Key(wishList.title),
      child: Container(
        child: Card(
          elevation: 10,
          child: ListTile(
            onTap: () {
              // navigate to edit screen
            },
            title: Text(
              wishList.title == null ? "null" : wishList.title,
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Row(
              children: <Widget>[
                Icon(Icons.shopping_cart, size: 16, color: Colors.white,),
                SizedBox(
                  width: 10,
                ),
                Text(
                  wishList.descriptions
                )
              ],
            ),
            trailing: Text(wishList.amount.toString(), style: TextStyle(color: Colors.white),)
          ),
          color: Color(0XFF406B96),
          margin: EdgeInsets.all(8),
        ),
      ),
      background: Container(
        color: Colors.green,
        child: Row(
          children: <Widget>[
            SizedBox(width: 20,),
            Icon(Icons.done)
          ],
        ),
      ),
      onDismissed: deleteFunction(wishList),
    );
  }
}