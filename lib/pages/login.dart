import 'package:comp202/pages/welcome.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class LoginScreen extends StatelessWidget {

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Future Login(BuildContext cont) async {
    if(username.text == "" || password.text == ""){
      Fluttertoast.showToast(
        msg: "Please enter your name and password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: 16.0,
      );
    }else{

      var url =  "http://192.168.56.1/localconnect/login.php";
      var response = await http.post(Uri.parse(url), body: {
        "username": username.text,
        "password": password.text,
      },);

      var data = json.decode(response.body);

      if(data == "Success"){
        Navigator.push(cont, MaterialPageRoute(builder: (context) => WelcomeScreen()));
      }else{
        Fluttertoast.showToast(
          msg: "Username or Password was wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16.0,
        );
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: Image.asset("assets/images/main_top.png"),
              width: 180,
              top: 0,
              left: 0,
            ),
            Positioned(
              child: Image.asset("assets/images/login_bottom.png"),
              width: 180,
              bottom: -10,
              right: 0,
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: titleFontWeight,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Container(
                      child: TextFormField(
                        controller: username,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'user@gmail.com',
                          hintStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.purple[darkPink],
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(borderRadius),
                        color: Colors.purple[lightPink],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Container(
                      child: TextFormField(
                        controller: password,
                        obscureText: true,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '******',
                          hintStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.purple[darkPink],
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(borderRadius),
                        color: Colors.purple[lightPink],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 1,
                    ),
                    child: TextButton(
                      onPressed: () {
                         Login(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.purple[darkPink],
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("don't have an account yet?"),
                      GestureDetector(
                        child: Text(
                          'register',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () {
                          print('go to the register page');
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}