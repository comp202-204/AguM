import 'package:comp202/pages/homescreen.dart';
import 'package:comp202/pages/signup.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class LoginScreen extends StatelessWidget {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future Login(BuildContext cont) async {
    if(email.text == "" || password.text == ""){
      Fluttertoast.showToast(
        msg: "Please enter your Email and Password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: 16.0,
      );
    }else{

      var url =  "http://10.32.1.15/localconnect/login.php";
      var response = await http.post(Uri.parse(url), body: {
        "email": email.text,
        "password": password.text,
      },);

      var data = json.decode(response.body);

      if(data == "success"){
        Navigator.push(cont, MaterialPageRoute(builder: (context) => HomeScreen()));
      }else{
        Fluttertoast.showToast(
          msg: "Email or Password was wrong",
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
              child: Image.asset(
                "assets/photos/logo.jpg",
                width: 80,
              ),
              top: -120,
              left: 0, // Set to null to allow the right property to take effect
              right: 0,
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Container(
                      child: TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'xyz@mail.com',
                          hintStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(borderRadius),
                        color: Color.fromRGBO(205, 103, 103, 0.5),
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
                          hintStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(borderRadius),
                        color: Color.fromRGBO(205, 103, 103, 0.5),
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
                          color: Color.fromRGBO(174,32,41,1),
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
                      Text("Don't you have an account ? "),
                      GestureDetector(
                        child: Text(
                          'REGISTER',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
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

