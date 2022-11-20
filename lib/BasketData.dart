import 'dart:ffi';

import 'Product.dart';

class BasketData{
  static BasketData? _instance;
  late List<Product> _basketItems;


  BasketData(){
    this._basketItems=[];
  }

  List<Product> get basketItems => _basketItems;

  set basketItems(List<Product> value) {
    _basketItems = value;
  }

  static BasketData? getInstance(){
    if(_instance == null){
      _instance=BasketData();
    }
    return _instance;
  }
}

