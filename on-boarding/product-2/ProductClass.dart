// Product Class
class Product {
  int _id;
  String _name;
  String _description;
  double _price;

  Product(this._id, this._name, this._description, this._price);

  // getter methods
  int get id => _id;
  String get name => _name;
  String get description => _description;
  double get price => _price;

  //setter methods
  set name(String value) => _name = value;
  set description(String value) => _description = value;
  set price(double value) => _price = value;

  @override
  String toString() {
    return 'Product_ID: $_id\nProduct_Name: $_name\nProduct_Description: $_description\nPrice: \$${_price.toStringAsFixed(2)}\n';
  }
}
