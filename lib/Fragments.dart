import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/BranchesPage.dart';
import 'package:flutter_app/ShoppingBasket.dart';
import 'package:flutter_app/AppHomePage.dart';
import 'package:flutter_app/Store.dart';



class Fragments extends StatefulWidget {
  @override
  _FragmentsState createState() => new _FragmentsState();
}

class _FragmentsState extends State<Fragments> {
  int _activeWidget = 0;
  Widget _body(){
    print(_activeWidget);
    switch (_activeWidget) {
      case 0:
        return BranchesPage();
      case 1 :
        return Store();
      case 2:
        return ShoppingBasket();

      default:
        return GestureDetector(
          onTap: (){

          },
          child:  Container(
            color: Colors.yellow,
            child: Text("I'm yellow"),
          ),
        );
    }
  }
  @override
  Widget build(BuildContext context) {
    return
       Scaffold(
         body: _body(),
         bottomNavigationBar:  ConvexAppBar(
           items: [
             TabItem(icon: Icons.home_outlined, title: 'Home'),
             TabItem(icon: Icons.location_on_outlined, title: 'Branches'),
             // TabItem(icon: Icons.add, title: 'Add'),
             TabItem(icon: Icons.search_outlined, title: 'Search'),
             // TabItem(icon: Icons.shopping_basket_outlined, title: 'ShoppingBasket'),
           ],
           initialActiveIndex: 0,
           //optional, default as 0
           onTap: (int i) => setState(() {
             _activeWidget=i;
           }),
           height: 70,
           backgroundColor: Colors.white,
           color: Colors.orange[400],
           activeColor: Colors.yellow[700],
         ),
       );

  }
}