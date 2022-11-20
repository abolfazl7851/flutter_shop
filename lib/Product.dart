class Product{

   late String _name;
   late int _id;
   late String _price;
   late String _imageUrl;
   late bool _off;
   late String _description;

   Product(this._name, this._id, this._price, this._imageUrl, this._off,
      this._description);

   String get description => _description;

  set description(String value) {
    _description = value;
  }

  bool get off => _off;

  set off(bool value) {
    _off = value;
  }

  String get imageUrl => _imageUrl;

  set imageUrl(String value) {
    _imageUrl = value;
  }

  String get price => _price;

  set price(String value) {
    _price = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}