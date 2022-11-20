import 'package:flutter/material.dart';
import 'package:flutter_app/BasketData.dart';
import 'package:flutter_app/Product.dart';
import 'package:flutter_app/ShoppingBasket.dart';

typedef BasketItemDelete(int index);

class BasketItem extends StatefulWidget {
  Product? _product;

  int index=-1;
  BasketItem(
      this._product,
      this._basketItemDelete,
      this.index
      );

  BasketItemDelete _basketItemDelete;

  @override
  _BasketItemState createState() => _BasketItemState();
}

class _BasketItemState extends State<BasketItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 200,
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget._product!.name,
                    style: TextStyle(fontFamily: "Vazir", fontSize: 20),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Image.network(
                    widget._product!.imageUrl,
                    height: 140,
                    width: 140,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.delete_outline,
                      size: 30,
                    ),
                    onTap: () {
                      setState(() {
                        widget._basketItemDelete(widget.index);
                      });
                    },
                  ),
                  Text(
                    "قیمت : " + widget._product!.price,
                    style: TextStyle(
                        color: Colors.red[700],
                        fontSize: 18,
                        fontFamily: "Vazir"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      elevation: 10,
      shadowColor: Colors.grey[600],
    );
  }

}
