import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/LoginPage.dart';
import 'package:flutter_app/AppHomePage.dart';
import 'package:http/http.dart';

import 'package:connectivity/connectivity.dart';
import 'package:progress_state_button/iconed_button.dart';

import 'package:progress_state_button/progress_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ResponseMes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  var wifiBSSID;
  var wifiIP;
  var wifiName;
  bool iswificonnected = false;
  bool isInternetOn = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetConnect();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController username = TextEditingController(text: "your username");
  TextEditingController password = TextEditingController(text: "your password");
  TextEditingController confirm_password =
      TextEditingController(text: "confirm your password");

  ButtonState stateTextWithIcon = ButtonState.idle;

  // TextEditingController birthdayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Welcome",style: TextStyle(fontSize: 18,fontFamily: "Bentley"),),
      //   backgroundColor: Colors.orange[600],
      // ),
      key: _scaffoldKey,
      body: isInternetOn ? DisplayCreateAcc() : Show_alert(),
      backgroundColor: Colors.yellow[700],
    );
  }

  void Check_createAccount() async {
    var url =
        Uri.parse("https://abolfazlghalibaf.ir/Tourism/Create_account.php");
    var map = new Map<String, dynamic>();
    map['username'] = username.text;
    map['password'] = password.text;
    Response response = await post(url, body: map);

    if (response.statusCode == 200) {
      var mesjson = json.decode(utf8.decode(response.bodyBytes));
      var model = new ResponseMes(mesjson['message'], mesjson['status']);
      if (model.success == true) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AppHomePage()));
      } else {
        _scaffoldKey.currentState!.showSnackBar(new SnackBar(
          content: new Text(
            model.message,
            textDirection: TextDirection.rtl,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.orange[500],
        ));
      }
    }
  }

  SingleChildScrollView DisplayCreateAcc() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
        child: Center(
            child: Column(children: [
          Image.asset(
            "images/icon.png",
            height: 100,
            width: 100,
          ),
          RichText(
            text: TextSpan(
                text: 'WellCome ',
                style: TextStyle(
                    fontSize: 40, fontFamily: "Vazir", color: Colors.white)),
          ),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            elevation: 4,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30, left: 20, right: 20, bottom: 30),
                  child: TextFormField(
                    controller: username,
                    style: TextStyle(color: Colors.black, fontSize: 23),
                    onTap: () {
                      username.clear();
                    },
                    textDirection: TextDirection.ltr,
                    cursorColor: Colors.yellow[700],
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle:
                          TextStyle(color: Colors.orange[500], fontSize: 20),
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 17, horizontal: 15),
                      // border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.yellow.shade700, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.yellow.shade700, width: 2.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  child: TextFormField(
                    controller: password,
                    style: TextStyle(color: Colors.black, fontSize: 23),
                    onTap: () {
                      password.clear();
                    },
                    textDirection: TextDirection.ltr,
                    cursorColor: Colors.yellow[700],
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle:
                          TextStyle(color: Colors.orange[500], fontSize: 20),
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 17, horizontal: 15),
                      // border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.yellow.shade700, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.yellow.shade700, width: 2.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  child: TextFormField(
                    controller: confirm_password,
                    style: TextStyle(color: Colors.black, fontSize: 23),
                    onTap: () {
                      confirm_password.clear();
                    },
                    textDirection: TextDirection.ltr,
                    cursorColor: Colors.yellow[700],
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle:
                          TextStyle(color: Colors.orange[500], fontSize: 20),
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 17, horizontal: 15),
                      // border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.yellow.shade700, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.yellow.shade700, width: 2.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(150, 45),
                        primary: Colors.orange[600]),
                    onPressed: () {
                      if (password.text == confirm_password.text)
                        Check_createAccount();
                      else {
                        _scaffoldKey.currentState!.showSnackBar(new SnackBar(
                          content: new Text(
                            'Two Password do not match',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.orange[500],
                        ));
                      }
                    },
                    child: Text(
                      'Create Account',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
                SizedBox(
                  height: 15,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(
                    "I Have Account.",
                    style: TextStyle(
                        fontFamily: "Vazir",
                        fontSize: 20,
                        color: Colors.orange[500],
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ])),
      ),
    );
  }

  Center Show_alert() {
    return Center(
      child: AlertDialog(
        title: Text('No Internet'),
        content: Text('You Are Not Connect To Internet.'),
        actions: [
          FlatButton(
            textColor: Colors.yellow[700],
            onPressed: () {
              exit(0);
            },
            child: Text('Exit'),
          ),
          ProgressButton.icon(
              iconedButtons: {
                ButtonState.idle: IconedButton(
                    text: "Try Again",
                    icon:
                        Icon(Icons.network_check_outlined, color: Colors.white),
                    color: Colors.orange.shade600),
                ButtonState.loading:
                    IconedButton(text: "Loading", color: Colors.white),
                ButtonState.fail: IconedButton(
                    text: "Failed",
                    icon: Icon(Icons.cancel, color: Colors.white),
                    color: Colors.red.shade300),
                ButtonState.success: IconedButton(
                    text: "Success",
                    icon: Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                    color: Colors.green.shade400)
              },
              onPressed: () {
                progress();
              },
              state: stateTextWithIcon),
        ],
      ),
    );
  }

  Future progress() async {

    setState(() {
//sets the  state of stateTextWithIcon to loading once button is pressed
      stateTextWithIcon = ButtonState.loading;
    });
    GetConnect();

    if (isInternetOn == true) {
      setState(() {
//sets the  state of stateTextWithIcon to success if whatever request made was successful
        stateTextWithIcon= ButtonState.success;
        new Future.delayed(const Duration(seconds: 2),(){
          Navigator.of(context).pop();
          DisplayCreateAcc();
        });
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

  void GetConnect() async {
    final prefs = await SharedPreferences.getInstance();

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isInternetOn = false;
      });
    } else {
      setState(() {
        isInternetOn = true;
        if (prefs.getBool("loginKey") == true) {
          Navigator.of(context).pop();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AppHomePage()));
        }
      });
    }
  }
}
