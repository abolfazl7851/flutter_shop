import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/CheckInternet.dart';
import 'package:flutter_app/Fragments.dart';
import 'package:flutter_app/Store.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Product.dart';
import 'package:flutter_app/BranchesPage.dart';
import 'package:flutter_app/Branches.dart';
import 'package:flutter_app/ShoppingBasket.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:http/http.dart';
import 'DescriptionPage.dart';

class AppHomePage extends StatefulWidget {

  // This widget is the root of your application.
  @override
  AppHomePageState createState() => AppHomePageState();
}

class AppHomePageState extends State<AppHomePage> {

  String _title = "فروشگاه";
  void changeTitle(){
    setState(() {
      switch (_activeWidget) {
        case 0:
          _title = "فروشگاه";
          break;
        case 1:
          _title = "نقشه شعب";
          break;
        case 2:
          _title = "";
          break;
        case 3:
          _title = "";
          break;
        case 4:
          _title = "سبد حرید";
          break;
      }
    });
  }

  int _activeWidget = 0;

  Widget _body() {

    switch (_activeWidget) {
      case 0:
        return Store();
      case 1:
        return BranchesPage();
      case 2:
        return Container();
      case 3:
        return Container();
      case 4:
        return ShoppingBasket();
      default:
        return Container(
          color: Colors.yellow,
          child: Text("I'm yellow"),
        );
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  ButtonState stateTextWithIcon = ButtonState.idle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title,
              style: TextStyle(color: Colors.black, fontFamily: "Vazir")),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.logout_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Center(
                        child: AlertDialog(
                            title: Text(
                              "Logout",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            content:
                                Text('Do you want to logout your account?'),
                            actions: [
                          FlatButton(
                            textColor: Colors.orange[600],
                            onPressed: () => Navigator.pop(context),
                            child: Text('No'),
                          ),
                          FlatButton(
                            textColor: Colors.orange[600],
                            onPressed: () {
                              LogOut();
                            },
                            child: Text("Yes"),
                          )
                        ]));
                  });
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.next_plan_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Fragments()));
              },
            )
          ],
          backgroundColor: Colors.yellow[700],
          elevation: 0,
        ),
        body: _body(),
        bottomNavigationBar: ConvexAppBar(
          items: [
            TabItem(icon: Icons.store_outlined, title: 'Store'),
            TabItem(icon: Icons.location_on_outlined, title: 'Branches'),
            TabItem(icon: Icons.add, title: 'Add'),
            TabItem(icon: Icons.search_outlined, title: 'Search'),
            TabItem(
                icon: Icons.shopping_basket_outlined, title: 'Basket'),
          ],
          initialActiveIndex: 0,
          //optional, default as 0
          onTap: (int i) => setState(() {
            _activeWidget = i;changeTitle();
          }),
          height: 70,
          backgroundColor: Colors.white,
          color: Colors.orange[400],
          activeColor: Colors.yellow[700],
        )
        // bottomNavigationBar: BottomNavigate(),
        // floatingActionButton: FloatingActionButton(onPressed: () {  },backgroundColor: Colors.yellow[600],child: Icon(Icons.add_outlined),),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );
  }

  Future progress() async {
    setState(() {
//sets the  state of stateTextWithIcon to loading once button is pressed
      stateTextWithIcon = ButtonState.loading;
    });

    if (await CheckInternet.IsInternetOn() == true) {
      setState(() {
//sets the  state of stateTextWithIcon to success if whatever request made was successful
        stateTextWithIcon = ButtonState.success;
        Navigator.of(context).pop();
      });
    } else {
      setState(() {
//sets the  state of stateTextWithIcon to fail if the request was unsuccessful
        stateTextWithIcon = ButtonState.fail;
      });
    }

    new Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        stateTextWithIcon = ButtonState.idle;
      });
    });
  }
}

void LogOut() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool("loginKey", false);
  exit(0);
}
