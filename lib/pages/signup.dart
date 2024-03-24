import 'package:comp202/pages/welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

      var url = "http://192.168.56.1/localconnect/register.php";
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
        Navigator.push(cont, MaterialPageRoute(builder: (context) => WelcomeScreen()));
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
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red.shade200,
              ),
              child: TextFormField(
                controller: usernameController,
                obscureText: false,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your username',
                  hintStyle: TextStyle(color: Colors.black),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.black38,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red.shade200,
              ),
              child: TextFormField(
                controller: emailController,
                obscureText: false,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(color: Colors.black),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.black38,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red.shade200,
              ),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: Colors.black),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.black38,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Register(context),
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SignUpScreen(),
  ));
}
