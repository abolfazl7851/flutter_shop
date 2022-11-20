import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class BottomNavigate extends StatelessWidget {
  const BottomNavigate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return BottomAppBar(
    //   shape: CircularNotchedRectangle(),
    //   notchMargin: 15,
    //   clipBehavior: Clip.antiAlias,
    //   child: Container(
    //     height: 60,
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: <Widget>[
    //         Container(
    //           width: MediaQuery.of(context).size.width/2-30,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               Icon(Icons.home_outlined,color: Colors.orange[500],),
    //               Icon(Icons.person_outlined,color: Colors.orange[500],)
    //             ],
    //           ),
    //         ),
    //         Container(
    //           width: MediaQuery.of(context).size.width/2-30,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               Icon(Icons.search_outlined,color: Colors.orange[500],),
    //               Icon(Icons.shopping_basket_outlined,color: Colors.orange[500],)
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    //   color: Colors.white,
    //
    // );

    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.map, title: 'Discovery'),
          TabItem(icon: Icons.add, title: 'Add'),
          TabItem(icon: Icons.message, title: 'Message'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        initialActiveIndex: 2,//optional, default as 0
        onTap: (int i) => print('click index=$i'),
        height: 70,
        backgroundColor: Colors.white,
        color: Colors.orange[400],
        activeColor: Colors.yellow,
      ));

    //   BottomNavigationBar(
    //     type: BottomNavigationBarType.fixed,
    //     fixedColor: Color(0xff2398C3),
    //     showSelectedLabels: false,
    //     showUnselectedLabels: false,
    //     items: [
    //       BottomNavigationBarItem(
    //           icon: Icon(Icons.home_outlined), label: "home"),
    //       BottomNavigationBarItem(
    //           icon: Icon(Icons.search_outlined), label: "search"),
    //       BottomNavigationBarItem(
    //           icon: Icon(Icons.person_outlined), label: "person"),
    //       BottomNavigationBarItem(icon: Icon(Icons.shopping_basket_outlined),
    //           label: "shoppingBasket")
    //     ]
    // );
  }
}
