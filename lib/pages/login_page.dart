import 'package:flutter/material.dart';
import 'package:flutter_assignment2/pages/home_page.dart';
import 'package:flutter_assignment2/pages/register_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_assignment2/global_var.dart' as globals;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

// this class builds the login page
class _LoginPage extends State<LoginPage> {
  //Atributes
  //the controlers are useful to retrieve the tect from the text fields
  final myControllerUsername = TextEditingController();
  final myControllerPassword = TextEditingController();

  // this method gets the inserted data and logins to the account
  Future<void> validateLogin() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/login/'),
      body: jsonEncode(<String, String>{
        'username': myControllerUsername.text.toString().trim(),
        'password': myControllerPassword.text.toString().trim(),
      }),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      globals.accessToken = data['access_token'];
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MyHomePage()));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)), //make alert rounded
            backgroundColor: const Color.fromARGB(237, 244, 242, 221),
            // Retrieve the text that the user has entered by using the
            // TextEditingController.
            content: const Text(
                "Username or password incorrect.\nIf you do not have an account, you can sign up"),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                    top: 120.0, left: 100, right: 100, bottom: 30),
                child: Image(
                  image: AssetImage("images/appvocado-loading.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 30, right: 30),
                child: TextFormField(
                  controller: myControllerUsername,
                  key: const Key('username'),
                  maxLength: 25,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 42, 134, 0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 42, 134, 0)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
                child: TextFormField(
                  controller: myControllerPassword,
                  key: const Key('password'),
                  maxLength: 25,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 42, 134, 0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 42, 134, 0)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                width: 100,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), //rounded corners of the button
                      )),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFFCBD781)),
                      foregroundColor:
                          MaterialStateProperty.all(const Color(0xFF2A8600))),
                  onPressed: () {
                    // Respond to button press
                    if (myControllerPassword.text == "" ||
                        myControllerUsername.text == "") {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    15.0)), //make alert rounded
                            backgroundColor:
                                const Color.fromARGB(237, 244, 242, 221),
                            // Retrieve the text that the user has entered by using the
                            // TextEditingController.
                            content:
                                const Text("Input a password and username"),
                          );
                        },
                      );
                    } else {
                      //todo: implement call to api
                      validateLogin();
                    }
                  },
                  child: const Text('Login'),
                ),
              ),
              TextButton(
                //register button
                onPressed: () {
                  // Respond to button press
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()));
                },
                child: const Text("Sign up"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
