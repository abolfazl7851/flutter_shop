import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/CheckInternet.dart';
import 'package:flutter_app/ResponseMes.dart';
import 'package:flutter_app/main.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'AppHomePage.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/CheckInternet.dart';



class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  TextEditingController username = TextEditingController(text: "nimrou");
  TextEditingController password = TextEditingController(text: "12345");

  ButtonState stateTextWithIcon = ButtonState.idle;


  // TextEditingController birthdayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
          child: Center(
              child: Column(children: [
                Image.asset(
                  "images/icon.png",
                  height: 100,
                  width: 100,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 30, left: 20, right: 20, bottom: 30),
                    child: Column(
                      children: [
                        TextFormField(
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
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
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
                        SizedBox(
                          height: 20,
                        ),
                        Text("Forgot Password",
                            style: TextStyle(
                              color: Colors.orange[500],
                              fontSize: 20,
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        // ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //         minimumSize: Size(150, 45),
                        //         primary: Colors.orange[600]
                        //     ),
                        //     onPressed: () {
                        //       CheckLogin();
                        //     },
                        //     child: Text(
                        //       'Login',
                        //       style: TextStyle(color: Colors.white, fontSize: 16),
                        //     )),
                        ProgressButton.icon(
                            iconedButtons: {
                              ButtonState.idle: IconedButton(
                                  text: "Login",
                                  icon:
                                  Icon(Icons.login_outlined, color: Colors.white),
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
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => MyApp()));
                          },
                          child: Text(
                            "I Don't Have Account.",
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
                )
              ])),
        ),
      ),
      backgroundColor: Colors.yellow[700],

    );
  }


  Future progress() async {

    setState(() {
//sets the  state of stateTextWithIcon to loading once button is pressed
      stateTextWithIcon = ButtonState.loading;
    });



    if ( await CheckInternet.IsInternetOn()==true) {

      setState(() {
        CheckLogin();

      });

    } else {
      setState(() {
//sets the  state of stateTextWithIcon to fail if the request was unsuccessful
        stateTextWithIcon = ButtonState.fail;

        _scaffoldKey.currentState!.showSnackBar(new SnackBar(content: new Text("No Internet!!",textAlign: TextAlign.center,textDirection: TextDirection.ltr,style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.orange[500],
        ));
      });
    }

    new Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        stateTextWithIcon = ButtonState.idle;
      });
    });


  }

  void CheckLogin() async {

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("loginKey", false);

    var url = Uri.parse("https://abolfazlghalibaf.ir/abweb/check.php");
    var map = new Map<String, dynamic>();
    map['username'] = username.text;
    map['password'] = password.text;
    Response response = await post(
        url,
        body: map
    );

    if (response.statusCode == 200) {
      var loginjson = json.decode(utf8.decode(response.bodyBytes));
      var model = new ResponseMes(loginjson['message'], loginjson['status']);
      if (model.success == true) {

        prefs.setBool("loginKey", true);
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AppHomePage()));
      } else {

        setState(() {
          stateTextWithIcon=ButtonState.idle;
        });
        _scaffoldKey.currentState!.showSnackBar(new SnackBar(content: new Text(model.message,textDirection: TextDirection.rtl,style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.orange[500],
        ));
      }
    }
  }



}


