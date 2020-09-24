import 'package:meAccounting/src/models/wishlist_model.dart';
import 'package:meAccounting/src/res/database/database_provider.dart';

class WishListDao {
  final databaseProvider = DatabaseProvider.databaseProvider;

  Future<List<WishListModel>> getWishLists() async {
    final db = await databaseProvider.database;

    List<Map<String, dynamic>> result;

    result = await db.rawQuery(
      "SELECT DISTINCT * FROM wish_lists"
    );

    List<WishListModel> wishLists = result.map((wishList) => WishListModel.fromDbMap(wishList)).toList();

    return wishLists;
  }

  Future<int> addWishList(WishListModel wishListModel) async {
    final db = await databaseProvider.database;

    var result = db.insert("wish_lists", wishListModel.toMap());

    return result;

  }

  Future<int> deleteAllWishLists() async {
    final db = await databaseProvider.database;

    var result = db.delete('wish_lists');

    return result;
  }

  Future<int> deleteWishList(WishListModel wishListModel) async {
    final db = await databaseProvider.database;
    var result = db.delete('wish_lists', where: "id = ?", whereArgs: [wishListModel.id]);

    return result;
  }
}