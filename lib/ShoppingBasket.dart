import 'package:flutter/material.dart';
import 'package:flutter_app/BasketItem.dart';
import 'package:flutter_app/Product.dart';

import 'BasketData.dart';

class ShoppingBasket extends StatefulWidget {

  const ShoppingBasket({Key? key}) : super(key: key);

  @override
  _ShoppingBasketState createState() => _ShoppingBasketState();
}

class _ShoppingBasketState extends State<ShoppingBasket> {
  @override
  Widget build(BuildContext context) {
    return BasketUi();
  }
  Widget BasketUi(){
    return ListView.builder(
      itemCount: BasketData.getInstance()!.basketItems.length,
        itemBuilder: (context,position){
        return GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: BasketItem(BasketData.getInstance()!.basketItems[position],DeleteItem,position),
          ),

        );
        }
    );
  }
  void DeleteItem(int index){
    setState(() {
      BasketData.getInstance()!.basketItems.removeAt(index);
    });
  }
}


