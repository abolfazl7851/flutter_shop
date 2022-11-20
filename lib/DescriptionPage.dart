import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/BasketData.dart';
import 'package:flutter_app/ShoppingBasket.dart';
import 'Product.dart';

class DescriptionPage extends StatelessWidget {

  Product product;

  DescriptionPage(this.product);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("جزئیات محصول",
            style: TextStyle(color: Colors.black, fontFamily: "Vazir")),
        centerTitle: true,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.grey,
        ),
        backgroundColor: Colors.yellow,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 10),
            child: Align(
              child: Text(
                product.name,
                style: TextStyle(
                  fontSize: 35,
                  fontFamily: "Vazir",
                  color: Colors.red,
                ),
                textDirection: TextDirection.rtl,
              ),
              alignment: Alignment.topRight,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Image.network(
              product.imageUrl,
              height: 350,
              width: 400,
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          Padding(
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: Align(
              child: Text(
                product.description,
                style: TextStyle(
                  fontFamily: "Vazir",
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),

          Expanded(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Text(
                      product.price,
                      style: TextStyle(
                          fontSize: 23,
                          fontFamily: "Vazir",
                          color: Colors.red[900]),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, bottom: 10),
                    child: AddToShoppingBasket(context),
                  )
                ]),
          )),
        ],
      ),
    );
  }

  Widget AddToShoppingBasket(context) {
    if (BasketData.getInstance()!.basketItems.contains(product)) {
      return GestureDetector(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.red[700],
              borderRadius: BorderRadius.all(Radius.circular(10))),
          height: 50,
          width: MediaQuery.of(context).size.width - 150,
          child: Center(
              child: Text(
            "قبلا به سبد خرید اضاف شده است!",
            style: TextStyle(
                fontFamily: "Vazir", color: Colors.white, fontSize: 15),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          )),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          BasketData.getInstance()!.basketItems.add(product);
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.yellow[700],
              borderRadius: BorderRadius.all(Radius.circular(10))),
          height: 50,
          width: MediaQuery.of(context).size.width - 200,
          child: Center(
              child: Text(
            "افزودن به سبد خرید",
            style: TextStyle(
                fontFamily: "Vazir", color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center,
          )),
        ),
      );
    }
  }
}
