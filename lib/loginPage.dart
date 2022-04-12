import 'package:flutter/material.dart';
import 'package:flutter_assignment2/homePage.dart';
import 'package:flutter_assignment2/registerPage.dart';

class loginPage extends StatefulWidget {
  loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPage();
}

// this class builds the details of a certain offer
// ignore: camel_case_types
class _loginPage extends State<loginPage> {
  //Atributes
  //the controlers are useful to retrieve the tect from the text fields
  final myControllerUsername = TextEditingController();
  final myControllerPassword = TextEditingController();

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
                          MaterialStateProperty.all(Color(0xFFCBD781)),
                      foregroundColor:
                          MaterialStateProperty.all(Color(0xFF2A8600))),
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
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyHomePage()));
                    }
                  },
                  child: const Text('Login'),
                ),
              ),
              TextButton(
                //register button
                onPressed: () {
                  // Respond to button press
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => registerPage()));
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
