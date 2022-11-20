
import 'dart:ffi';

import 'package:flutter/foundation.dart';

class Branches{

  late String _shopName;
  late int _shopId;
  late String _shopTel;
  late double _latitude;
  late double _longitude;
  late String _manager;

  Branches(this._shopName, this._shopId, this._shopTel, this._latitude,
      this._longitude, this._manager);

  String get manager => _manager;

  set manager(String value) {
    _manager = value;
  }




  String get shopTel => _shopTel;

  set shopTel(String value) {
    _shopTel = value;
  }

  int get shopId => _shopId;

  set shopId(int value) {
    _shopId = value;
  }

  String get shopName => _shopName;

  set shopName(String value) {
    _shopName = value;
  }

  double get longitude => _longitude;

  set longitude(double value) {
    _longitude = value;
  }

  double get latitude => _latitude;

  set latitude(double value) {
    _latitude = value;
  }
}