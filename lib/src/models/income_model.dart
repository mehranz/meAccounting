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
  int descriptions;
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
    }
  );
