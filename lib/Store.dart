import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'DescriptionPage.dart';
import 'Product.dart';
import 'CheckInternet.dart';

class Store extends StatefulWidget {
  const Store({Key? key}) : super(key: key);

  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  List<Product> items = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchItem();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: EdgeInsets.all(10),
    child: GridView.count(
    crossAxisCount: 2,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    children: List.generate(items.length, (int position) {
    return generateItem(items[position], context);
    }),
    ),
    );
  }

  void fetchItem() async {
    // if(await CheckInternet.IsInternetOn() ==true) {

      var url = Uri.parse(
          "http://welearnacademy.ir/flutter/products_list.json");
      Response response = await get(url);
      setState(() {
        var productjson = json.decode(utf8.decode(response.bodyBytes));
        for (var i in productjson) {
          var product = Product(i['product_name'], i['id'], i['price'],
              i['image_url'], i['off'], i['description']);
          items.add(product);
        }
      });
    // }else{
    //   showDialog(context: context, builder: (BuildContext context) {
    //     return Center(
    //       child: AlertDialog(
    //         title: Text('No Internet'),
    //         content: Text('You Are Not Connect To Internet.'),
    //         actions: [
    //           FlatButton(
    //             textColor: Colors.yellow.shade700,
    //             onPressed: () {
    //               exit(0);
    //             },
    //             child: Text('Exit'),
    //           ),
    //           ProgressButton.icon(
    //               iconedButtons: {
    //                 ButtonState.idle: IconedButton(
    //                     text: "Try Again",
    //                     icon: Icon(Icons.network_check_outlined, color: Colors.white),
    //                     color: Colors.orange.shade600),
    //                 ButtonState.loading:
    //                 IconedButton(text: "Loading", color: Colors.white),
    //                 ButtonState.fail: IconedButton(
    //                     text: "Failed",
    //                     icon: Icon(Icons.cancel, color: Colors.white),
    //                     color: Colors.red.shade300),
    //                 ButtonState.success: IconedButton(
    //                     text: "Success",
    //                     icon: Icon(
    //                       Icons.check_circle,
    //                       color: Colors.white,
    //                     ),
    //                     color: Colors.green.shade400)
    //               },
    //               onPressed: () {
    //                 progress();
    //               },
    //               state: stateTextWithIcon),
    //         ],
    //       ),
    //     );
    //   });
    // }
  }

}


Card generateItem(Product product, context) {
  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
    elevation: 4,
    child: InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DescriptionPage(product)));
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.network(product.imageUrl),
              height: 110,
              width: 110,
            ),
            Text(
              product.name,
              style: TextStyle(
                  fontFamily: "Vazir", fontSize: 17, color: Colors.black),
            ),
            Text(
              product.price,
              style: TextStyle(
                  fontFamily: "Vazir", fontSize: 15, color: Colors.red[900]),
            )
          ],
        ),
      ),
    ),
  );
}