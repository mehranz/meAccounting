class WishListModel {
  int id;
  String title;
  int amount;
  String descriptions;

  WishListModel({
    this.id,
    this.title,
    this.amount,
    this.descriptions,
  });

  WishListModel.fromDbMap(Map<String, dynamic> dbResult)
  : this.id = dbResult['id'],
    this.title = dbResult['title'],
    this.amount = dbResult['amount'],
    this.descriptions = dbResult['descriptions'];

  Map<String, dynamic> toMap() {
    return {
      "title": this.title,
      "amount": this.amount,
      "descriptions": this.descriptions,
    };
  }
}