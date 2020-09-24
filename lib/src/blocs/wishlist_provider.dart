import 'package:flutter/cupertino.dart';
import 'package:meAccounting/src/blocs/wishlist_bloc.dart';

class WishListProvider extends InheritedWidget {

  final WishListBloc bloc;

  WishListProvider({Key key, Widget child})
  : bloc = WishListBloc(),
    super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static WishListBloc of (BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<WishListProvider>().bloc;
  }
}