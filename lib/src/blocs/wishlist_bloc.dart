import 'package:meAccounting/src/models/wishlist_model.dart';
import 'package:meAccounting/src/res/repo.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class WishListBloc {
  final _repo = Repo();

  final _wishListController = BehaviorSubject<List<WishListModel>>();

  final _titleController = BehaviorSubject<String>();
  final _amountController = BehaviorSubject<int>();
  final _descriptionsController = BehaviorSubject<String>();

  Stream<List<WishListModel>> get wishListsStream => _wishListController.stream;

  Stream<String> get titleStream => _titleController.stream;
  Function(String) get addTitle => _titleController.sink.add;

  Stream<int> get amountStream => _amountController.stream;
  Function(int) get addAmount => _amountController.sink.add;

  Stream<String> get descriptionsStream => _descriptionsController.stream;
  Function(String) get addDescriptions => _descriptionsController.sink.add;

  Stream<bool> get validSubmit => Rx.combineLatest2(titleStream, amountStream, (title, amount) => true);

  getWishList() async {
    var _wishList = await _repo.getWishLists();
    _wishListController.sink.add(_wishList);
  }

  void submitToDB() {
    final WishListModel _wishListToSubmit = WishListModel(
      title: _titleController.value,
      amount: _amountController.value,
      descriptions: _descriptionsController.value,
    );

    addNewWishListToDB(_wishListToSubmit);

  }

  void bought(WishListModel wishListModel) {
    _repo.deleteWishList(wishListModel);

    // getWishList();
  }

  addNewWishListToDB(WishListModel wishList) async {
    _repo.addNewWishList(wishList);
  }

}