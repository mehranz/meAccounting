class ExpenseModel {
  /*
   * ExpenseModel Class Provides Expense Data Model in order to communicate
   * much easier with data transactions from database
   */

  int id;
  String title;
  int amount;
  int accountId;
  String descriptions;
  final String accountTitle;
  final String createdAt;

  ExpenseModel(
    /*
     * ExpenseModel Constructor to initialize class variables
     * @params int, string, int, int
     */
      {this.id,
      this.title,
      this.amount,
      this.accountId,
      this.descriptions,
      this.accountTitle,
      this.createdAt});

  ExpenseModel.fromDbMap(Map<String, dynamic> dbQueryResult)
  /*
   * From db map Constructor to help make ExpenseModel with map data
   * comes from database queries
   * 
   * @param Map<String, dynamic>
   */
      : this.id = dbQueryResult['id'],
        this.title = dbQueryResult['title'],
        this.amount = dbQueryResult['amount'],
        this.accountId = dbQueryResult['account_id'],
        this.descriptions = dbQueryResult['descriptions'],
        this.accountTitle = dbQueryResult['accountTitle'],
        this.createdAt = dbQueryResult['created_at'];

  Map<String, dynamic> toMap() {
    /*
     * toMap method to create map from ExpenseModel in order to insert
     * an ExpenseModel directly into database
     * 
     * @return Map<String, dynamic>
     */

    return {
      "id": this.id,
      "title": this.title,
      "amount": this.amount,
      "account_id": this.accountId,
      "descriptions": this.descriptions,
      "created_at": this.createdAt
    };
  }
}
