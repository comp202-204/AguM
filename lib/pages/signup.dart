import 'package:comp202/constants.dart';
import 'package:comp202/pages/homescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpScreen extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future Register(BuildContext cont) async {
    if(emailController.text == "" || passwordController.text == "" || usernameController.text == ""){
      Fluttertoast.showToast(
        msg: "Please enter your email, password and username",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: 16.0,
      );
    }else{

      var url = "http://10.30.2.176/localconnect/register.php";
      var response = await http.post(Uri.parse(url), body: {
        "username" : usernameController.text,
        "email": emailController.text,
        "password": passwordController.text,
      },);

      var data = json.decode(response.body);

      if(data == "Register Successed"){
        Fluttertoast.showToast(
          msg: "Registeration success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16.0,
        );
        Navigator.push(cont, MaterialPageRoute(builder: (context) => HomeScreen()));
      }else{
        Fluttertoast.showToast(
          msg: "This email already exist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16.0,
        );
      }
    }

  }

  /*void register(BuildContext context) {
    String username = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    print('Username: $username');
    print('Email: $email');
    print('Password: $password');
  }
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SIGN UP',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
      child: Container(
      width: double.infinity,
      child: Column(
          children: [
          SizedBox(height: 40),
      Image.asset(
        "assets/photos/agüentrance.jpg",
        width: 500,
      ),
      SizedBox(height: 30),
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                  color: Color.fromRGBO(205, 103, 103, 0.5),
              ),
              child: TextFormField(
                controller: usernameController,
                obscureText: false,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your username',
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 18),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                color: Color.fromRGBO(205, 103, 103, 0.5),
              ),
              child: TextFormField(
                controller: emailController,
                obscureText: false,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 18),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                color: Color.fromRGBO(205, 103, 103, 0.5),
              ),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 1,
              ),
            ),
            TextButton(
              onPressed: () => Register(context),
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
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
          ],
        ),
    ),
    ],
    ),
    ),),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SignUpScreen(),
  ));
}
