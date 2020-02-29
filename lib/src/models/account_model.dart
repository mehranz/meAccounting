class AccountModel {
  /*
   * AccountModel Class Provides Account Data Model in order to
   * communicate much easier with data comes from database in all app
   */

  int id;
  String title;
  int initalAmount;
  int cardNumber;

  AccountModel(
    /*
     * Account Model Constructor to initialize property variables of class
     * when an object created from this class
     * 
     * @params int, string, int, int
     */
    
      {this.id,
      this.title,
      this.initalAmount,
      this.cardNumber});

  AccountModel.fromDBMap(Map<String, dynamic> dbResult)
  /*
   * fromDBMap Constructor to help make AccountModel
   * with Map Data Comes from Database Queries
   * 
   * @param Map<String, dynamic>
   */

    : this.id = dbResult['id'],
      this.title = dbResult['title'],
      this.initalAmount = dbResult['initalAmount'],
      this.cardNumber = dbResult['cardNumber'];


  Map<String, dynamic> toMap() {
    /*
     * toMap method to create map from AccountModel
     * in order to insert it directly to Database
     * 
     * @params
     * @return Map<String, dynamic>
     */

    return {
      "id": this.id,
      "title": this.title,
      "initalAmount": this.initalAmount,
      "cardNumber": this.cardNumber
    };
  }
}
