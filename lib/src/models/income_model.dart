class IncomeModel {
  /*
   * incomes data model class in order to access communicate with 
   * data transactions from database
   * 
   */

  int id;
  String title;
  int amount;
  int account_id;
  String descriptions;
  final String accountTitle;
  final String created_at;

  
  IncomeModel(
    /*
     * construtor of class to init class variables and create income data model
     * 
     * @params int, String, int, int, String, String
     * 
     */
    {
    this.id,
    this.title,
    this.amount,
    this.account_id,
    this.descriptions,
    this.created_at,
    this.accountTitle,
    }
  );

  IncomeModel.fromDbMap(Map<String, dynamic> dbResult)
  /*
   * fromDbMap Constructor in order to create income data model 
   * with data comes from database
   * 
   * @params Map<String, dynamic>
   */

  : this.id = dbResult['id'],
    this.title = dbResult['title'],
    this.amount = dbResult['amount'],
    this.account_id = dbResult['account_id'],
    this.descriptions = dbResult['descriptions'],
    this.created_at = dbResult['created_at'],
    this.accountTitle = dbResult['accountTitle'];
    
  Map<String, dynamic> toMap() {
    /*
     * Convert income data model to map
     * in order to insert to database
     * 
     * @return Map<String, dynamic>
     */

    return {
      'id': this.id,
      'title': this.title,
      'amount': this.amount,
      'account_id': this.account_id,
      'descriptions': this.descriptions,
      'created_at': this.created_at
    };

  }
  
}
